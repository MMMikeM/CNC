; config.g - Scylla Board (RatRig StrongHold 750x1250)

; General Setup
M111 S0                         ; Debug off
M550 P"StrongHold"              ; Machine name
M575 P1 B9600 S7                ; RS485 Device mode for M260.4 Modbus - 9600 baud (VFD PD164=1, PD165=3 RTU 8N1)

; Drive Mapping
M584 X0 Y1:2 Z3                 ; X=driver0, Y=drivers1&2, Z=driver3

; Motor Directions
M569 P0 S0 D2                   ; X
M569 P1 S1 D2                   ; Y1
M569 P2 S1 D2                   ; Y2
M569 P3 S1 D2                   ; Z

; Driver sense resistors - required on Scylla V1 (TeamGloomy board docs)
M569.9 P0.0 R0.05 S10
M569.9 P0.1 R0.05 S10
M569.9 P0.2 R0.05 S10
M569.9 P0.3 R0.05 S10

; Microstepping
M350 X16 Y16 Z16 I1             ; x16 microstepping with interpolation

; Steps/mm - TR8x8, 16 microsteps
M92 X400 Y400 Z400

; Motor Currents
M906 X1500 Y1500 Z1500          ; 1500mA - conservative until reliable
M84 S30                         ; Motor idle timeout 30s

; Speeds and Acceleration
M203 X3000  Y1800 Z1500         ; Max speeds mm/min - Y capped below ~1960 whip limit (MACHINE.md s.3)
M201 X500   Y500  Z200          ; Acceleration (mm/s²)
M566 X1000  Y1000 Z500          ; Jerk (mm/min)

; StallGuard
M915 P0   S5 H2 R0 F1           ; X
M915 P1:2 S5 H2 R0 F1           ; Y
M915 P3   S5 H2 R0 F1           ; Z

; Axis Limits
M208 X0   Y0    Z0   S1         ; Minima
M208 X700 Y1200 Z125 S0         ; Maxima

; Endstops
M574 X1 S1 P"^D.11"             ; X-MIN
M574 Y2 S1 P"^D.14+^D.13"       ; Y-MAX, one pin per motor, order matches M584 Y1:2
M574 Z2 S1 P"^D.12"             ; Z-MAX

; Spindle - RS485 Huanyang VFD
M950 R0 C"B.1" L0:24000         ; Spindle on spindlepwm pin, 0-24000 RPM
M563 P0 R0 S"Spindle"           ; Tool 0
M453                            ; CNC mode (no parameters in RRF 3.3+)
T0                              ; Select tool 0 so M3/M5 work without a manual T0

; LED
M950 P0 C"D.6" Q500             ; LED control on D.6 (must precede M42)
M42 P0 S1                       ; LED on

; Network
M552 S1                         ; Enable networking
M586 P0 S1                      ; Enable HTTP
