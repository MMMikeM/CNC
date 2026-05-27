; config.g - Scylla Board (RatRig StrongHold 1250x750) - Fully Fixed

; General Setup
M111 S0                     ; Debug off
M550 P"StrongHold"          ; Set machine name
M575 P1 B57600 S2           ; RS485 VFD Communication (Fixed)

; Drive Mapping
M584 X0 Y1:2 Z3             ; X on driver 0, Y on drivers 1&2, Z on driver 3

; Motor Directions
M569 P0 S0                  ; X motor direction (negative)
M569 P1 S1                  ; Y1 motor direction (positive)
M569 P2 S1                  ; Y2 motor direction (positive)
M569 P3 S1                  ; Z motor direction (positive)

; Motor Configuration
M350 X8 Y8 Z8 I1            ; Enable interpolation for smoother movement
M906 X1500 Y1500 Z1500      ; Motor currents (mA) (increased from 1000)
M92 X400 Y400 Z400          ; Steps per mm for each axis

; Maximum Speed Settings (mm/s)
M203 X50 Y50 Z25            ; Max speeds

; Acceleration Settings (mm/s^2)
M201 X500 Y500 Z200         ; Acceleration limits

; Instantaneous Speed Changes (mm/min)
M566 X1000 Y1000 Z500       ; Maximum instantaneous speed changes

; StallGuard Configuration for TMC2160
M915 P0 S5 H2 R0 F1         ; X axis StallGuard (tuned sensitivity)
M915 P1:2 S5 H2 R0 F1       ; Y axis StallGuard (both motors)
M915 P3 S5 H2 R0 F1         ; Z axis StallGuard

; Axis Limits
M208 X0 Y0 Z0 S1            ; Set axis minima
M208 X700 Y1200 Z125 S0     ; Set axis maxima

; Endstop Configuration - Corrected Pins for SN04-N2 Sensors
M574 X1 S1 P"^D.11"         ; X min endstop (fixed from io1.in)
M574 Y2 S1 P"^D.14"         ; Y max primary endstop
M574 U2 S1 P"^D.13"         ; Y max secondary endstop
M574 Z2 S1 P"^D.12"         ; Z max endstop

; Spindle Setup - RS485 VFD Control (Fixed)
M950 R0 C"B.1" L0:24000     ; Create spindle using `B.1` (spindlepwm), 0-24000 RPM range
M563 P0 R0 S"Spindle"       ; Define Tool 0 as Spindle
M453 R0                     ; Enable CNC mode with spindle R0
M950 P2 C"C.5"              ; Define virtual pin 2 for spindle enable
M950 P3 C"B.0"              ; Define virtual pin 3 for spindle direction
M42 P2 S1                   ; Activate spindle enable
M42 P3 S0                   ; Set spindle direction to default (adjust as needed)

; **Fixed Network Configuration**
M552 S1                     ; Enable network
M586 P0 S1                  ; Enable HTTP
; M586 P1 S0                  ; Disable FTP (commented out to avoid errors)
; M586 P2 S1                  ; Enable Telnet (commented out to avoid errors)

