G91                    ; Relative positioning
G1 H1 Z130 F250        ; Home Z first
G1 Z-2 F300            ; Back off Z
G1 Z5 F1500            ; Lift Z a bit more for safety

G1 H1 X-800 F700       ; Then home X
G1 X2 F300             ; Back off X
G1 H1 X-4 F140         ; Precise X home

M584 Y1 U2             ; Separate Y motors
G1 H1 Y1300 F1200      ; Home Y (left)
G1 Y-2 F300            ; Back off Y left
G1 H1 Y4 F240          ; Precise Y left home
G1 H1 U1300 F1200      ; Home Y (right)
G1 U-2 F300            ; Back off Y right
G1 H1 U4 F240          ; Precise Y right home
M584 Y1:2              ; Recombine Y motors

G90                    ; Absolute positioning
G92 X0 Y1200 Z125      ; Set all axes positions