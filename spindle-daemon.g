; spindle-daemon.g - Huanyang HY02D223B VFD control over RS485
; Mirrors spindles[0] state (set by M3/M4/M5 and S) to the VFD via M260.4 raw
; Modbus, and publishes VFD readings to globals for DWC/macros.
;
; Protocol: see Huanyang_RS485_Protocol_Notes.md. Frames below exclude the slave
; address and CRC - M260.4 adds both. Requires in config.g:
;   M575 P1 B9600 S7            ; RS485 port in Device mode
; and on the VFD: PD001=2, PD002=2, PD163=1, PD164=1 (9600), PD165=3 (RTU 8N1).
;
; Error handling: a failed M260.4 (timeout/bad CRC) aborts this macro. RRF then
; restarts daemon.g roughly 10s later; all state lives in globals so the restart
; resumes cleanly. The VFD holds its last commanded state across the gap - a
; hardwired enable line remains the only true failsafe (MACHINE.md s.4).

if !exists(global.runDaemon)
    global runDaemon = true
if !exists(global.vfdState)
    global vfdState = "STOP"    ; last commanded VFD state: "STOP", "CW", "CCW"
if !exists(global.vfdHz)
    global vfdHz = 0.0          ; output frequency read back from the VFD
if !exists(global.vfdAmps)
    global vfdAmps = 0.0        ; output current read back from the VFD
if !exists(global.vfdSetHz100)
    global vfdSetHz100 = 0      ; last commanded frequency, Hz x 100

M118 P0 S"VFD daemon started"

while global.runDaemon
    G4 P500

    ; --- poll VFD: output frequency (function 04, item 1 = OutF) ---
    ; reply: [func, len, item, hi, lo]
    M260.4 P1 A1 B{0x04, 0x01, 0x01} R5 V"outF"
    set global.vfdHz = {(var.outF[3] * 256 + var.outF[4]) / 100}

    ; --- poll VFD: output current (function 04, item 2 = OutA) ---
    M260.4 P1 A1 B{0x04, 0x01, 0x02} R5 V"outA"
    set global.vfdAmps = {(var.outA[3] * 256 + var.outA[4]) / 10}

    ; --- desired state from the object model ---
    var want = "STOP"
    if spindles[0].state == "forward"
        set var.want = "CW"
    elif spindles[0].state == "reverse"
        set var.want = "CCW"

    ; --- start / stop / direction (function 03: 0x01 fwd, 0x11 rev, 0x08 stop) ---
    if var.want != global.vfdState
        if global.vfdState != "STOP"
            M260.4 P1 A1 B{0x03, 0x01, 0x08} R3
            set global.vfdState = "STOP"
            set global.vfdSetHz100 = 0
            M118 P0 S"VFD: stop"
        if var.want != "STOP"
            ; wait (bounded, ~30s) for coast-down before starting or reversing;
            ; the Huanyang rejects direction changes while the output is live
            var waited = 0
            while var.waited < 150
                M260.4 P1 A1 B{0x04, 0x01, 0x01} R5 V"coastF"
                if var.coastF[3] == 0 && var.coastF[4] == 0
                    break
                set var.waited = var.waited + 1
                G4 P200
            if var.want == "CW"
                M260.4 P1 A1 B{0x03, 0x01, 0x01} R3
            else
                M260.4 P1 A1 B{0x03, 0x01, 0x11} R3
            set global.vfdState = var.want
            M118 P0 S{"VFD: run " ^ var.want}

    ; --- speed (function 05, value = Hz x 100; VFD ramps per PD014/PD015) ---
    if global.vfdState != "STOP"
        var hz100 = {floor(spindles[0].active * 40000 / spindles[0].max)}
        if var.hz100 > 40000
            set var.hz100 = 40000
        if var.hz100 != global.vfdSetHz100
            M260.4 P1 A1 B{0x05, 0x02, floor(var.hz100 / 256), mod(var.hz100, 256)} R4
            set global.vfdSetHz100 = var.hz100

M118 P0 S"VFD daemon stopped"
