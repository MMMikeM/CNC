; homex.g - home X to X-MIN (inductive sensor on D.11)
; H1 sets X to the M208 minimum (0) when the endstop triggers - no G92 needed.

; Ensure Z is at safe height before X home
if !move.axes[2].homed
    M98 P"homez.g"
G90
G1 Z125 F1500                   ; Park Z at max for clearance

G91                             ; Relative
G1 H1 X-800 F3000               ; Fast seek
G1 X2 F3000                     ; Back off
G1 H1 X-4 F100                  ; Slow approach
G1 X2 F100                      ; Final back off, clear of sensor
G90                             ; Absolute
