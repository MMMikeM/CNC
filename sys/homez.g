

G91                    ; Relative positioning
G1 H1 Z130 F250       ; Move to endstop
G1 Z-2 F300           ; Back off 2mm
G90                   ; Absolute positioning
G92 Z125              ; Set Z position