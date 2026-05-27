G91                        ; Relative
G1 H1 Z130 F5000           ; Fast seek to Z-MAX (capped by M203)
G1 Z-2 F5000               ; Back off
G1 H1 Z4 F100              ; Slow approach
G1 Z-2 F100                ; Final back off
G90                        ; Absolute
G92 Z125                   ; Set position
