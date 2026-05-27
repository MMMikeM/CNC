; Ensure Z is at safe height before X home
if !move.axes[2].homed
    M98 P"homez.g"
G90
G1 Z125 F5000              ; Park Z at max for clearance

G91                        ; Relative
G1 H1 X-800 F5000          ; Fast seek (capped by M203)
G1 X2 F5000                ; Back off
G1 H1 X-4 F100             ; Slow approach
G1 X2 F100                 ; Final back off
G90                        ; Absolute
G92 X0                     ; Set position
