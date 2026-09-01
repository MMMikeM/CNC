; spindle-daemon.g - Huanyang HY02D223B VFD: speed over RS485, monitoring
;
; Run/stop/direction are HARDWARE signals: RRF drives SP-EN/SP-DIR (created by
; M950 R0 in config.g) wired to the VFD's FOR/REV terminals with SP-COM to DCM,
; and the VFD has PD001=1 (terminal run commands). A controller halt or power
; loss drops the enable line and stops the spindle - the failsafe path does not
; depend on this daemon running.
;
; This daemon only writes the target frequency (function 0x05, Hz x 100) and
; polls output frequency and current into globals. Protocol details:
; Huanyang_RS485_Protocol_Notes.md. Frames exclude addr+CRC (M260.4 adds both).
; Requires M575 P1 B9600 S7 and VFD PD002=2, PD163=1, PD164=1 (9600),
; PD165=3 (RTU 8N1).
;
; A failed M260.4 reports an error but does not abort the macro; 'result' is
; non-zero afterwards and the V variable is not an array. Every transaction is
; checked and a dead VFD (unpowered, unwired) sets global.vfdOnline = false and
; backs the poll off to once a minute (every 2s while a spindle command is
; pending) instead of spamming the console.

; Conditions containing round brackets must be wrapped in { } - in CNC mode
; (M453) RRF treats bare ( ) as comments and reports "unknown value 'exists'".
if {!exists(global.runDaemon)}
    global runDaemon = true
if {!exists(global.vfdHz)}
    global vfdHz = 0.0          ; output frequency read back from the VFD
if {!exists(global.vfdAmps)}
    global vfdAmps = 0.0        ; output current read back from the VFD
if {!exists(global.vfdSetHz100)}
    global vfdSetHz100 = -1     ; last commanded frequency, Hz x 100; -1 = never sent
if {!exists(global.vfdOnline)}
    global vfdOnline = false    ; true while the VFD answers on RS485

M118 P0 S"VFD daemon started"

while global.runDaemon
    G4 P500

    ; --- poll VFD: output frequency (function 04, item 1 = OutF) ---
    ; reply: [func, len, item, hi, lo]
    M260.4 P1 A1 B{0x04, 0x01, 0x01} R5 V"outF"
    if result != 0
        set global.vfdOnline = false
        set global.vfdSetHz100 = -1 ; force a fresh frequency write once it is back
        if spindles[0].state == "stopped"
            G4 S60                  ; VFD not answering, spindle idle - retry once a minute
        else
            G4 S2                   ; spindle commanded - keep trying to get the speed across
        continue
    set global.vfdOnline = true
    set global.vfdHz = {(var.outF[3] * 256 + var.outF[4]) / 100}

    ; --- poll VFD: output current (function 04, item 2 = OutA) ---
    M260.4 P1 A1 B{0x04, 0x01, 0x02} R5 V"outA"
    if result == 0
        set global.vfdAmps = {(var.outA[3] * 256 + var.outA[4]) / 10}

    ; --- speed follows spindles[0]; 0 when stopped so a restart never
    ;     resumes at a stale frequency (function 05, Hz x 100) ---
    var hz100 = 0
    if spindles[0].state == "forward" || spindles[0].state == "reverse"
        set var.hz100 = {floor(spindles[0].active * 40000 / spindles[0].max)}
        if var.hz100 > 40000
            set var.hz100 = 40000
    if var.hz100 != global.vfdSetHz100
        M260.4 P1 A1 B{0x05, 0x02, floor(var.hz100 / 256), mod(var.hz100, 256)} R4
        if result == 0
            set global.vfdSetHz100 = var.hz100

M118 P0 S"VFD daemon stopped"
