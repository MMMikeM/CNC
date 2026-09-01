; homey.g - home Y to Y-MAX, both motors independently
; M574 Y declares one endstop pin per motor (D.14 for driver 1, D.13 for driver 2),
; so a single H1 move stops each motor on its own sensor and squares the gantry.
; No M584 axis-splitting needed. H1 sets Y to the M208 maximum (1200) - no G92.
; Fast seek capped at F1800: Y lead screw whip limit is ~1960 mm/min (MACHINE.md s.3).

; Ensure Z is at safe height before Y home
if !move.axes[2].homed
    M98 P"homez.g"
G90
G1 Z125 F1500                   ; Park Z at max for clearance

G91                             ; Relative
G1 H1 Y1300 F1800               ; Fast seek, each motor stops on its own endstop
G1 Y-2 F1800                    ; Back off
G1 H1 Y4 F100                   ; Slow approach
G1 Y-2 F100                     ; Final back off, clear of sensors
G90                             ; Absolute
