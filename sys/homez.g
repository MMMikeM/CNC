; homez.g - home Z to Z-MAX (inductive sensor on D.12)
; H1 sets Z to the M208 maximum (125) when the endstop triggers - no G92 needed.

G91                             ; Relative
G1 H1 Z130 F1500                ; Fast seek
G1 Z-2 F1500                    ; Back off
G1 H1 Z4 F100                   ; Slow approach
G1 Z-2 F100                     ; Final back off, clear of sensor
G90                             ; Absolute
