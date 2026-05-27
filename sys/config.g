; config.g - Scylla Board (RatRig StrongHold 750x1250)

; General Setup
M111 S0                     ; Debug off
M550 P"StrongHold"          ; Machine name
M575 P1 B57600 S2           ; RS485 - 57600 baud (match VFD PD164)

; Drive Mapping
M584 X0 Y1:2 Z3             ; X=driver0, Y=drivers1&2, Z=driver3

; Motor Directions
M569 P0 S0                  ; X
M569 P1 S1                  ; Y1
M569 P2 S1                  ; Y2
M569 P3 S1                  ; Z

; Microstepping
M350 X8 Y8 Z8 I1            ; x8 microstepping with interpolation

; Motor Currents
M906 X1500 Y1500 Z1500      ; 1500mA - conservative until reliable
M84 S30                     ; Motor idle timeout 30s

; Steps/mm
M92 X400 Y400 Z400

; Speeds and Acceleration
M203 X50 Y50 Z25            ; Max speeds (mm/s)
M201 X500 Y500 Z200         ; Acceleration (mm/s²)
M566 X1000 Y1000 Z500       ; Jerk (mm/min)

; StallGuard
M915 P0 S5 H2 R0 F1         ; X
M915 P1:2 S5 H2 R0 F1       ; Y
M915 P3 S5 H2 R0 F1         ; Z

; Axis Limits
M208 X0 Y0 Z0 S1            ; Minima
M208 X700 Y1200 Z125 S0     ; Maxima

; Endstops
M574 X1 S1 P"^D.11"         ; X-MIN
M574 Y2 S1 P"^D.14"         ; Y-MAX (primary)
M574 U2 S1 P"^D.13"         ; Y-MAX (secondary, E-MAX)
M574 Z2 S1 P"^D.12"         ; Z-MAX

; Spindle - RS485 Huanyang VFD
M950 R0 C"B.1" L0:24000     ; Spindle on spindlepwm pin, 0-24000 RPM
M563 P0 R0 S"Spindle"       ; Tool 0
M453 R0                     ; CNC mode

; LED
M950 P0 C"D.6" Q500         ; LED control on D.6
M42 P0 S1                   ; LED on

; Network
M552 S1                     ; Enable networking
M586 P0 S1                  ; Enable HTTP
