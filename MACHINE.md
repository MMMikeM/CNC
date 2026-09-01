# MACHINE.md

Hardware reference for the StrongHold ONE CNC router.

**Scope:** this file describes physical hardware and the physics that follows from
it. It contains no configuration values and no record of current machine state.
Config lives in the config files; this file must remain true regardless of what the
config currently says.

**If you are an agent:** the figures here are derived from the Rat Rig BOM and the
source documents in this repo — `BIGTREETECH_Scylla_V1.0_User_Manual_md/`,
`TMC2160A_datasheet_rev1.10.md`, `TeamGloomy_Scylla_V1_H723_Pins.md`,
`HY_Series_Inverter_User_Manual_md/`. This file holds only what those documents do
not: machine-specific analysis and conclusions. Raw specs live in the sources; do not
duplicate them here. Section 6 lists what is *not* known. Do not fill those gaps by
assumption.

---

## 1. Identity

|                 |                                                                    |
|-----------------|--------------------------------------------------------------------|
| Machine         | Rat Rig StrongHold ONE CNC, 750 x 1250 (SKU HW3252MK)              |
| Frame           | 40-series aluminium extrusion (4040 + 40120), 10/12mm steel plates |
| Controller      | BIGTREETECH Scylla V1.0                                            |
| Firmware family | RepRapFirmware, gloomyandy STM32 port                              |
| Units           | Metric throughout                                                  |

---

## 2. Motion hardware

Source: Rat Rig BOM, SKUs HW3253MK / HW3198MK / HW4442MK.

### Lead screws — all TR8*8 (8mm diameter, **8mm lead**, single start)

| Axis | Length    | Rat Rig SKU |
|------|-----------|-------------|
| X    | 1057mm    | HW2727SC    |
| Y    | 1557mm x2 | HW1865SC    |
| Z    | 281mm     | HW2686SC    |

Supporting hardware: nut blocks HW1079GC (x8), tensioning nuts HW2117NC (x3),
thrust bearings F8-16M (x7), lock collars 8mm ID (x11).

8mm lead is confirmed by BOM part naming, not inferred from steps/mm.

### Linear rails

| Axis | Rail  | Length | Carriages per rail |
|------|-------|--------|--------------------|
| X    | MGN15 | 1000mm | 2x MGN15C          |
| Y    | HG15  | 1500mm | 2x LHGH15CA        |
| Z    | MGN15 | 250mm  | 2x MGN15C          |

Two rails per axis. Y uses the heavier HG15 profile.

### Motors and couplers

- 4x NEMA23 "High Torque" (Rat Rig StrongHold ONE build guide). Open loop, no
  encoders. The Scylla has no closed-loop capability.
- Couplers HW3379GC, disc type, **6.35mm to 8mm**. Motor shaft is 6.35mm (1/4"),
  screw end is 8mm.
- Y is a dual-motor axis, one motor per driver, so independent squaring is
  mechanically possible.

### Endstops

- **SN04-N2 NPN normally-closed inductive proximity sensors.** 4mm nominal sensing
  range against ferrous metal, roughly half that or worse against aluminium — a steel
  target plate is preferable to bare extrusion.
- **The kit ships 3** (SKU HW2982EC): one each for X, Y, Z. Printed mounts supplied
  are 2x `sh_xz_endstop_mount` and 1x `sh_y_endstop_mount`.
- Supply requirement is **6-36V**. These will not operate from a 5V rail. The Scylla
  sets the VCC rail voltage for all eight limit inputs from a single jumper, fused at
  3A (BTT manual §3.3, `BIGTREETECH_Scylla_V1.0_User_Manual_md/`).
- Wiring: brown = VCC, blue = GND, black = signal.
- Repeatability is roughly 1-3% of sensing distance (0.04-0.12mm), against ~0.01mm
  for a mechanical microswitch, with additional temperature drift. This sets the floor
  on workpiece-origin repeatability when homing between jobs.
- NC is the fail-safe polarity: a broken wire or dead sensor reads as triggered.

---

## 3. Derived constants

Formulas given so they can be recomputed rather than trusted.

### Steps per mm

```
steps/mm = (200 full steps/rev x microstep divisor) / lead
         = (200 x divisor) / 8
```

| Divisor | steps/mm | Resolution |
|---------|----------|------------|
| 8       | 200      | 5.00 µm    |
| 16      | 400      | 2.50 µm    |
| 32      | 800      | 1.25 µm    |

Microstep divisor and steps/mm are coupled. Changing one without the other scales all
travel and all feed rates by the ratio between them, and invalidates soft limits by
the same factor.

The TMC2160's MicroPlyer (`TMC2160A_datasheet_rev1.10.md`) interpolates any input
resolution up to 256 microsteps in hardware, so motor smoothness does not depend on
the divisor. What the divisor does affect is the size of the interpolation artefact
during acceleration, since MicroPlyer predicts from the previous step interval.

### Motor speed at a given feed

```
rpm = feed [mm/min] / lead [mm]
```

At 8mm lead: 2000 mm/min = 250 rpm, 3000 mm/min = 375 rpm.

### Lead screw critical speed (whip)

```
n_crit [rpm] = 1.2e8 x k x d_root / L^2
```

`d_root` ~ 6.2mm for TR8, `L` = unsupported screw length in mm, `k` = 1.0 for
fixed-simple mounting. Derate to 80% for a working limit.

| Axis | L      | n_crit        | Derated | Feed limit at 8mm lead |
|------|--------|---------------|---------|------------------------|
| Y    | 1557mm | 307 rpm       | 245 rpm | **~1960 mm/min**       |
| X    | 1057mm | 666 rpm       | 533 rpm | ~4260 mm/min           |
| Z    | 281mm  | far above use | —       | not a constraint       |

Critical speed scales with 1/L², so the two long axes differ by a factor of ~2.2
despite using identical screws. **Y is the binding axis.** X should tolerate roughly
double the feed rate of Y; if it does not, the limit is electrical rather than
mechanical.

Mounting method matters considerably: fixed-fixed with angular contact bearings at
both ends and the screw under tension gives k ~ 2.2, more than doubling these figures.
Simple-simple gives k ~ 0.7.

---

## 4. Spindle and VFD

|           |                                            |
|-----------|--------------------------------------------|
| Spindle   | 2.2kW water-cooled, 80mm body, ER20 collet |
| Max speed | 24,000 rpm (400Hz base frequency, 2-pole)  |
| VFD       | Huanyang HY02D223B                         |

ER20 collet range is approximately 1-13mm, so 12mm shanks fit.

Below base frequency the VFD runs constant volts-per-hertz, so the entire usable range
is the constant-torque region:

```
T = P / omega = 2200 / (2 x pi x 24000 / 60) ~ 0.875 Nm
```

Torque is flat at ~0.875 Nm; power scales linearly with speed (~733W at 8,000 rpm).
**Spindle torque is never the limiting factor when cutting wood** — cutting a 12mm
slot 12mm deep in oak at 2000 mm/min draws on the order of 170W. Chip load and machine
rigidity are the real constraints.

Below roughly 6,000 rpm a plain V/f Huanyang loses torque to stator resistance, so
8,000 rpm is the practical floor.

Water cooling uses an external pump, so low-rpm operation carries no cooling penalty
(unlike an air-cooled spindle, where the fan is on the motor shaft).

### Scylla spindle interface

The spindle outputs (SP-EN, SP-DIR, SPD with its AO/DO jumper, AVR reference input)
and the RS485 MCU/SBC selector switch are documented in the BTT manual, §3.7 and
§3.9 (`BIGTREETECH_Scylla_V1.0_User_Manual_md/`). The RS485 wire protocol for the
Huanyang VFD is in `Huanyang_RS485_Protocol_Notes.md` and the manual appendix in
`HY_Series_Inverter_User_Manual_md/`.

**Failsafe consideration:** if the spindle is commanded purely over RS485, no hardware
signal stops it when the controller halts, hangs or loses power — the VFD continues at
its last commanded frequency. A physically wired enable line provides a stop path that
does not depend on the controller being alive.

---

## 5. Electrical

### Controller

|             |                                                                   |
|-------------|-------------------------------------------------------------------|
| Input range | DC24V - DC56V on V-Motor, V-MOS and V-MCU (three separate inputs) |
| Drivers     | 4x TMC2160, 4.7A RMS / 6.7A peak                                  |
| MCU         | STM32H723VGT6, 550MHz Cortex-M7                                   |

The TMC2160 datasheet (`TMC2160A_datasheet_rev1.10.md`) gives a *stricter* operational
range than BTT's board rating — VS 10-55V, with false short-detection triggers possible
above 52V. Treat 56V as the board's absolute ceiling, not a target.

### Supply current

Supply current is not motor phase current; the drivers are switching regulators.

```
P_motor ~ I_phase^2 x R_winding x 2 phases
I_supply ~ P_motor / (V_supply x eta)
```

At 3A/phase into a ~1.3Ω winding, roughly 23W per motor. Four motors moving
simultaneously is ~2-3A from the rail, plus iron losses at high step rates.

Holding is the *cheapest* state on the supply side, not the most expensive: at
standstill there is no back-EMF, no mechanical work and no switching iron loss, only
I²R.

### Regenerative energy

During quick deceleration, motor coils feed energy back to the supply; a switching
supply can source current but cannot sink it, so the rail voltage rises on every
deceleration. The datasheet's bulk-capacitance and layout requirements are in
`TMC2160A_datasheet_rev1.10.md` (100µF per amp of coil current, low-ESR, short heavy
PSU runs). **For this machine: four motors at 3A implies 1200µF minimum**, rated above
the supply voltage.

### Supply voltage: what higher voltage would buy

Stepper torque falls off with speed because back-EMF subtracts from the supply
voltage. The corner frequency where this begins is approximately:

```
f_corner ~ V / (2 x pi x L x I)
```

With typical NEMA23 values (L ~ 3mH, I ~ 3A):

| Supply | f_corner | Corner rpm | Feed at 8mm lead |
|--------|----------|------------|------------------|
| 24V    | ~425 Hz  | ~127 rpm   | ~1020 mm/min     |
| 36V    | ~640 Hz  | ~191 rpm   | ~1530 mm/min     |
| 48V    | ~850 Hz  | ~255 rpm   | ~2040 mm/min     |

Corner frequency scales linearly with supply voltage. Above the corner, torque falls
progressively; a motor at twice its corner speed retains roughly half its low-speed
torque.

**How this interacts with the whip limits in section 3:**

- At 24V, both long axes are torque-limited well below their mechanical whip ceilings.
  Voltage is the binding constraint on both.
- Around 48V, the Y torque limit (~2040 mm/min) converges with the Y whip limit
  (~1960 mm/min). Beyond that point, further voltage buys nothing on Y — the screw
  becomes the constraint.
- X has roughly twice Y's whip headroom (~4260 mm/min), so X continues to benefit from
  higher voltage after Y has stopped benefiting.

The practical consequence is that voltage and screw upgrades are complementary rather
than alternatives, and their order matters: raising voltage first reveals whether whip
is genuinely the limit, and costs a fraction of a screw swap.

These figures assume typical motor parameters. Actual inductance and rated current for
the fitted motors are unknown (section 6) and would shift the table.

### Current setting: why it matters less than it appears

Corner frequency is *inversely* proportional to the current setting, so halving the
current doubles it. At 24V with L ~ 3mH:

| Current setting | f_corner | Corner rpm | Feed at 8mm lead |
|-----------------|----------|------------|------------------|
| 3.0A            | ~425 Hz  | ~127 rpm   | ~1020 mm/min     |
| 1.5A            | ~850 Hz  | ~255 rpm   | ~2040 mm/min     |

Read alone, that suggests lower current is better. It is not — halving the current also
halves the torque the curve starts from. The result is a flatter curve at half the
height.

The consequence falls out of the algebra. Above the corner, achievable coil current
falls roughly as `f_corner / f`, so:

```
T(f) = k x I_rated x f_corner / f
     = k x I_rated x V / (2 x pi x L x I_rated x f)
     = k x V / (2 x pi x L x f)
```

**`I_rated` cancels.** Above the corner frequency, torque is a function of supply
voltage, inductance and speed only. The current setting drops out entirely.

Normalised torque against speed at 24V (1.0 = holding torque at 3A):

| Motor rpm | 3.0A setting | 1.5A setting |
|-----------|--------------|--------------|
| 100       | 1.00         | 0.50         |
| 127       | 1.00         | 0.50         |
| 200       | 0.64         | 0.50         |
| 255       | 0.50         | 0.50         |
| 400       | 0.32         | 0.32         |
| 600       | 0.21         | 0.21         |

The curves converge at the corner frequency of the *lower* setting and are identical
above it.

**Practical consequences:**

- Raising the current setting buys nothing above the crossover speed — at 24V that is
  ~2040 mm/min on an 8mm lead, close to this machine's working feed.
- It buys real torque *below* the crossover: during acceleration, plunges, Z moves,
  and slow finishing passes. Since curve-heavy toolpaths spend much of their time
  accelerating, this is not negligible.
- The cost is quadratic in heat. `P = I^2 R x 2 phases` means 3A dissipates four times
  what 1.5A does — roughly 23W per motor against 6W, or 92W versus 23W across four
  motors, all of it going into the frame.

This is the strongest argument for voltage over current: raising the supply voltage
moves the corner *without* lowering the curve, gaining torque at speed while preserving
low-speed torque, at no thermal cost.

The broken-line model above is a simplification; real torque curves round through the
knee rather than turning sharply. Directionally it holds.

### Firmware pin names

The full pin tables (driver pins, named aliases, PWM timer assignments, SPI channels)
are in `TeamGloomy_Scylla_V1_H723_Pins.md`. What that table doesn't say:

- The alias names (`xmin`, `ymax`, …) are conventional, not binding — BTT's manual
  states explicitly that any input may serve any purpose provided firmware and wiring
  agree. This machine has three axes and four endstops (the fourth being the added
  dual-Y sensor), so one A-axis input covers that role and four inputs remain spare.
- The DIAG pins (`xdiag` etc.) carry the TMC2160 stall-detection output, needed for
  sensorless homing or stall-based load monitoring.
- `aux0` (PA_4) has **no PWM timer** — digital on/off only, unlike aux1 and aux2.
- Pins sharing a hardware timer must share a PWM frequency. `spindlepwm` and
  `spindledir` share a timer with `xmax`; the four PD_12-15 limit inputs share Timer 4
  with `extin0`. Harmless while those pins are digital inputs, but it constrains any
  attempt to drive two of them as PWM outputs at different frequencies.
- The timer assignments **change between RRF 3.6 and 3.7**, so the pins table is
  firmware-version-sensitive.

---

## 6. Not known — verify physically

The following cannot be determined from the BOM, the manuals, or the config, and must
not be assumed:

- **Motor part number, rated current, winding resistance and inductance.** The BOM
  records only "Nema 23 Stepper Motor High Torque". Every current and torque figure in
  this document is an estimate pending this.
- **PSU model and actual trimmed output voltage.** Measure at the terminals.
- **Whether bulk capacitance is fitted**, and its value.
- **Jumper positions**: limit-input VCC rail voltage, Speed-OUT AO/DO selection,
  RS485 MCU/SBC selector, V-DIR and V-EN rail selection, Vprobe and Vtool. All are
  physical and none are visible from software.
- **Pin naming and mapping.** Documented in `TeamGloomy_Scylla_V1_H723_Pins.md` and
  verified 2026-09-01: the authoritative source is
  [`boards/btt/scylla1_0_h723/rrfpins.txt`](https://github.com/gloomyandy/RRFBuild/blob/v3.6-dev/boards/btt/scylla1_0_h723/rrfpins.txt)
  in the gloomyandy/RRFBuild repo, which is
  compiled into the firmware binary — the strings embedded in the 3.6.3 Scylla build
  are byte-identical to it, and both match the TeamGloomy table. (An earlier note here
  claimed the file lives on the SD card; it does not, and the card also runs without a
  `board.txt` in `/sys`.) Re-check on firmware upgrades, since PWM timer assignments
  differ between RRF 3.6 and 3.7.
- **Whether the Scylla's optoisolated limit inputs have hardware pullups fitted.** BTT
  publish no schematic for the input stage, so pullup and inversion requirements must
  be established by test.
- **Screw mounting method at each end** (fixed / simple / tensioned), which changes the
  critical-speed figures in section 3 by up to a factor of two.
- **Firmware version in use**, since several relevant G-code behaviours have changed
  across RRF 3.x releases.

### Physical verification

**Travel per revolution.** Mark the coupler, command a known distance, measure actual
travel with a rule. This validates the whole lead-to-steps chain in one test.

**Endstop polarity.** Query endstop state with nothing near the sensor, then with a
steel object held against it. A clean flip means the polarity is right. Permanently
triggered or never changing points to inversion or supply voltage respectively.

**Whip vs torque diagnosis.** Run identical moves along X and along Y at increasing
feed. Section 3 predicts X should manage roughly twice Y's ceiling. If both cap at the
same figure, the limit is electrical, not mechanical.

---

## 7. Cutting physics

### Chip load

```
fz = feed [mm/min] / (rpm x flutes)
```

Target chip load in hardwood:

| Cutter diameter | fz            |
|-----------------|---------------|
| 3mm             | 0.05 - 0.10mm |
| 6mm             | 0.15 - 0.25mm |
| 8mm             | 0.20 - 0.30mm |
| 12mm            | 0.30 - 0.45mm |

A sharp carbide edge has a radius of 5-10µm, rising to 20-30µm when worn. Chip
thickness must exceed roughly 2-3x the edge radius to shear rather than plough, giving
an absolute floor around 0.05mm with a worn tool. Below it the flute rubs: heat,
burnished walls, rapid dulling.

Manufacturer feed charts assume industrial gantries running 8-15 m/min and produce
chip loads several times higher than achievable here. They are not applicable.

**Consequence at this machine's feed range:** low flute counts and low spindle speeds.
Single-flute cutters at 8,000-10,000 rpm give a proper chip at ~2000 mm/min; two flutes
work at the bottom of the rpm range; three or more are under-fed at any usable spindle
speed. This conclusion is a function of feed rate, and would change if the feed ceiling
rose.

### Depth of cut and flute length

Full-width slot depth is limited by **flute length**, not by machine capability. On a
straight-shank cutter the shank is the same diameter as the cutting edge, so below the
flute it rubs the slot walls with no clearance and no chip path. Workarounds: cut a
channel wider than the tool, machine from both faces, or use a necked cutter with a
reduced-diameter section above the flutes.

Chip evacuation from deep slots requires an upcut helix, which augers chips out
mechanically. Straight flutes have no axial component and will pack.

### Tool deflection

```
delta = F L^3 / (3 E I)
E_carbide ~ 600 GPa   (~3x steel)
I = pi d_eff^4 / 64,  d_eff ~ 0.8 D for a typical core diameter
```

Stickout is cubed and dominates every other term. Diameter is to the fourth power, so
increasing diameter outperforms any flute-geometry choice. Flute count does not
determine rigidity; core diameter does, and it varies more within a flute count than
between.

Peak cutting force in a full-width slot:

```
F_peak ~ 55 x ap x fz   (sharp edge)
F_peak ~ 80 x ap x fz   (worn edge)
```

where `ap` is axial depth of cut in mm. Specific cutting force for wood varies by
±40% across species, moisture content and grain direction, so treat these as a bracket.

Frame compliance at the tool tip on a 40-series extrusion gantry with MGN15 rails is
plausibly 2-5 N/µm — the same order as tool deflection at realistic cutting forces.
Reducing stickout alone will not bring total deflection below roughly 50µm.

### Cut geometry and flute direction

Only the finishing pass determines surface quality; roughing deflection is removed by
whatever follows it. Upcut is correct for hidden pockets and for any deep cut needing
chip evacuation. Compression geometry (upcut at the tip, downcut above) earns its cost
only where both faces of the cut are visible, and requires the transition point to sit
below the workpiece top surface — which means the pass establishing that surface must
be deeper than the upcut section.
