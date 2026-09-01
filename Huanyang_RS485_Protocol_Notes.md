# Huanyang HY-series RS485 protocol — community notes

Facts established by reverse engineering that the official manual omits or leaves
ambiguous. Sources:

- LinuxCNC `hy_vfd` driver: `src/hal/user_comps/huanyang-vfd/hy_vfd.c` and `hy_comm.h`
  (github.com/LinuxCNC/linuxcnc, fetched 2026-09-01)
- Bouni's command list: gist.github.com/Bouni/803492ed0aab3f944066 (fetched 2026-09-01)
- Manual appendix IX-B: see `HY_Series_Inverter_User_Manual_md/`

## Not standard Modbus

The framing (addr + payload + CRC16-Modbus, low byte first) matches Modbus RTU, but the
function codes and payload structure do not. Standard Modbus register read/write
(function 03/06/16, as sent by RRF `M260.1`/`M261.1`) will not work. Use RRF `M260.4`
(raw Modbus transaction) — it prepends the address and appends the CRC, which matches
this protocol exactly.

## Function codes

| Code | Meaning | Payload (after addr, before CRC) |
|---|---|---|
| 0x01 | Read PD parameter | `LEN` `PDxxx` [`data`] |
| 0x02 | Write PD parameter | `LEN` `PDxxx` `data-hi` `data-lo` |
| 0x03 | Write control command | `0x01` `CNTR` |
| 0x04 | Read status item | `0x01` `CFG` (reply carries the value) |
| 0x05 | Write run frequency | `0x02` `freq-hi` `freq-lo`, value = Hz × 100 |
| 0x08 | Loop test | echoes payload |

`LEN` for PD read/write: 3 when data is one word, 2 when one byte or none.
Error replies set the top bit of the function code (e.g. 0x81) — check for it.

## CNTR control byte (function 0x03) — values that actually work

The manual lists CNTR as a bit field (bit0 run, bit1 for, bit2 rev, bit3 stop…).
The values used in practice, confirmed by the LinuxCNC driver:

| CNTR | Effect |
|---|---|
| 0x01 | Run forward (run + for) |
| 0x11 | Run reverse (run + r/f bit) |
| 0x08 | Stop |

The reply is a CNST status byte: bit0 run, bit1 jog, bit2 command r/f, bit3 running,
bit4 jogging, bit5 running r/f, bit6 braking, bit7 track start.

Direction cannot be changed while running — stop first, then command the new direction.

## Status items (function 0x04, CFG byte 0–7)

| CFG | Item | Scaling |
|---|---|---|
| 0 | Set F — commanded frequency | value / 100 = Hz |
| 1 | Out F — output frequency | value / 100 = Hz |
| 2 | Out A — output current | value / 10 = A (LinuxCNC treats raw as A×10) |
| 3 | RoTT — motor RPM | direct, depends on PD143/PD144 |
| 4 | DC V — bus voltage | V |
| 5 | AC V — input voltage | V |
| 6 | Cont — CNST status byte | bit field, see above |
| 7 | Tmp — inverter temperature | °C |

Request frame is `addr 04 01 CFG crc` — payload length is 1 (a single CFG byte),
not a 16-bit register address. Reply data is `03 CFG hi lo` (LEN, item, word).

There is no documented fault-code status item. Fault records are read as PD parameters
(PD177–PD180 via function 0x01); the current-fault display is not exposed as a CFG item.

## Scalings for PD parameters over the wire

- Frequencies (PD004, PD005, function 0x05 data): Hz × 100
- Voltages (PD141): V × 10
- Currents (PD142): A × 10
- RPM (PD144): direct (RPM at 50 Hz)

## VFD parameter prerequisites for RS485 control

| Param | Value | Meaning |
|---|---|---|
| PD001 | 2 | Run commands from communication port |
| PD002 | 2 | Frequency from communication port |
| PD163 | 1 | Slave address 1 |
| PD164 | 1 | 9600 baud (options: 0=4800, 1=9600, 2=19200, 3=38400 — nothing higher) |
| PD165 | 3 | RTU mode, 8N1 |

## Timing

- Manual: ≥50 ms quiet time between frames (RTU frame delimiter).
- LinuxCNC uses generous 500 ms timeouts per transaction; the VFD is slow. Polling
  faster than ~5–10 Hz is unreliable; the LinuxCNC driver reads one status item per
  cycle rather than all of them each cycle.
