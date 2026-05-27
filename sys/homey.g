G91                     ; Relative positioning
G1 H2 Z5 F1500         ; Lift Z

M584 Y1 U2             ; Separate Y motors
G1 H1 Y1300 F1200      ; Fast seek to endstop (left)
G1 Y-2 F300            ; Back off 2mm
G1 H1 Y4 F240          ; Slow approach
G1 Y-2 F300            ; Final back off

G1 H1 U1300 F1200      ; Fast seek to endstop (right)
G1 U-2 F300            ; Back off 2mm
G1 H1 U4 F240          ; Slow approach
G1 U-2 F300            ; Final back off

M584 Y1:2              ; Recombine Y motors
G90                    ; Absolute positioning
G92 Y1200              ; Set Y position