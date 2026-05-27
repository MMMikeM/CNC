; spindle-warmup.g - manual spindle warm-up routine
; Run before a job: M98 P"spindle-warmup.g"
; Drives the spindle through M3/M5 so spindle-daemon.g handles the VFD.

if {!exists(global.configWarmupRPM)}
    global configWarmupRPM = 6000
if {!exists(global.configWarmupMinutes)}
    global configWarmupMinutes = 2

M118 P0 S{"Spindle warm-up: " ^ global.configWarmupRPM ^ " RPM for " ^ global.configWarmupMinutes ^ " min"}
M3 S{global.configWarmupRPM}
G4 S{global.configWarmupMinutes * 60}
M5
M118 P0 S"Spindle warm-up complete"
