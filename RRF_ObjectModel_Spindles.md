# RRF Object Model — spindles[]

> Source: https://github.com/Duet3D/RepRapFirmware/wiki/Object-Model-Documentation (fetched 2026-09-01)

## spindles[]
List of configured CNC spindles

#### spindles[].active
Active RPM

#### spindles[].canReverse
Flags whether the spindle may spin in reverse direction

#### spindles[].current
Current RPM, negative if anticlockwise direction

#### spindles[].frequency
Frequency (in Hz)

#### spindles[].idlePwm
Idle PWM value (0..1)

#### spindles[].max
Maximum RPM

#### spindles[].maxPwm
Maximum PWM value when turned on (0..1)

#### spindles[].min
Minimum RPM when turned on

#### spindles[].minPwm
Minimum PWM value when turned on (0..1)

#### spindles[].state
Current state

This property may be one of the following:
- unconfigured: Spinde not configured
- stopped: Spindle is stopped (inactive)
- forward: Spindle is going forwards
- reverse: Spindle is going in reverse

#### spindles[].type
Spindle type

This property may be one of the following:
- enaDir: Enable and direction
- fwdRev: Forward and reverse
