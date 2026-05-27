; Ensure Z is at safe height before Y home
if !move.axes[2].homed
    M98 P"homez.g"
G90
G1 Z125 F5000              ; Park Z at max for clearance

G91                        ; Relative
M584 Y1 U2                 ; Split Y motors for independent homing
G1 H1 Y1300 U1300 F5000    ; Fast seek both sides (capped by M203)
G1 Y-2 U-2 F5000           ; Back off
G1 H1 Y4 U4 F100           ; Slow approach
G1 Y-2 U-2 F100            ; Final back off
M584 Y1:2                  ; Recombine
G90                        ; Absolute
G92 Y1200                  ; Set position
