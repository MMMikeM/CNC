M98 P"homez.g"                       ; Home Z first for clearance

; Parallel X + dual-Y home (Y split for de-racking)
M584 Y1 U2                           ; Split Y motors
G91                                  ; Relative
G1 H1 X-800 Y1300 U1300 F5000        ; Parallel fast seek (capped by M203)
G1 X2 Y-2 U-2 F5000                  ; Back off
G1 H1 X-4 Y4 U4 F100                 ; Slow approach
G1 X2 Y-2 U-2 F100                   ; Final back off
M584 Y1:2                            ; Recombine
G90                                  ; Absolute
G92 X0 Y1200                         ; Set positions
