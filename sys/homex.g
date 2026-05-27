G91                    ; Relative positioning
G1 H2 Z5 F1500        ; Lift Z
G1 H1 X-800 F700      ; Fast seek
G1 X2 F300            ; Back off 2mm
G1 H1 X-4 F140        ; Slow approach
G1 X2 F300            ; Final back off
G90                   ; Absolute positioning
G92 X0                ; Set X position