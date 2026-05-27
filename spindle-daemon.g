; spindle-daemon.g - Huanyang HY02D223B VFD monitor
; Reads spindles[0] state from RRF, drives VFD via Modbus, watches for faults.

; ====================================
; CONFIG
; ====================================
if {!exists(global.configMaxRPM)}
    global configMaxRPM = 24000
if {!exists(global.configMaxHz)}
    global configMaxHz = 400
if {!exists(global.configPollingMs)}
    global configPollingMs = 200
if {!exists(global.configMaxErrors)}
    global configMaxErrors = 5

; ====================================
; STATE
; ====================================
if {!exists(global.runDaemon)}
    global runDaemon = true
if {!exists(global.spindleState)}
    global spindleState = "STOP"
if {!exists(global.currentVfdHz)}
    global currentVfdHz = 0
if {!exists(global.lastSetFrequency)}
    global lastSetFrequency = 0
if {!exists(global.vfdFaultCode)}
    global vfdFaultCode = 0
if {!exists(global.loadPercentage)}
    global loadPercentage = 0
if {!exists(global.errorCount)}
    global errorCount = 0

; ====================================
; HELPERS
; ====================================

; Read a VFD register with retry. Returns success bool in result.
function readVfdRegister(register, expectedLength, resultVar)
    var highByte = floor(var.register / 256)
    var lowByte = var.register - (var.highByte * 256)
    var retries = 0
    while var.retries < 3
        M260.4 P1 A1 B{{0x04, 0x03, var.highByte, var.lowByte, 0x00}} R{var.expectedLength} V{var.resultVar}
        if {self[var.resultVar] != null}
            result = true
            return
        set var.retries = var.retries + 1
        G4 P20
    result = false

; Stop the spindle by commanding 0 Hz, wait briefly for decel.
function stopSpindle()
    M260.4 P1 A1 B{{0x05, 0x02, 0x00, 0x00}} R4
    G4 P3
    var waited = 0
    while var.waited < 10
        G4 P50
        var ok = false
        call readVfdRegister(0x0100, 5, "stopSpeed") ok
        if !var.ok
            break
        if self.stopSpeed[3] * 256 + self.stopSpeed[4] == 0
            break
        set var.waited = var.waited + 1
    M3 P0 S0
    set global.spindleState = "STOP"
    set global.lastSetFrequency = 0

; Change direction. Stops first if currently spinning (mandatory on Huanyang).
function setSpindleDirection(direction)
    if var.direction == global.spindleState
        return
    if global.currentVfdHz > 0
        call stopSpindle()
    if var.direction == "CW"
        M260.4 P1 A1 B{{0x03, 0x01, 0x01}} R3
    elif var.direction == "CCW"
        M260.4 P1 A1 B{{0x03, 0x01, 0x11}} R3
    else
        return
    G4 P3
    set global.spindleState = var.direction
    M118 P0 S{"VFD: direction " ^ var.direction}

; Set spindle speed. VFD's own PD014/PD015 handle accel/decel ramping.
function setSpindleSpeed(targetRPM)
    var targetHz = var.targetRPM / global.configMaxRPM * global.configMaxHz
    if var.targetHz > global.configMaxHz
        set var.targetHz = global.configMaxHz
    if abs(global.currentVfdHz - var.targetHz) > 0.25 && var.targetHz != global.lastSetFrequency
        var scaled = floor(var.targetHz * 100)
        var hi = floor(var.scaled / 256)
        var lo = var.scaled - (var.hi * 256)
        M260.4 P1 A1 B{{0x05, 0x02, var.hi, var.lo}} R4
        G4 P3
        set global.lastSetFrequency = var.targetHz

; Check VFD fault register; if newly faulted, E-stop and halt daemon.
function checkVfdFaults()
    var ok = false
    call readVfdRegister(0x03, 5, "faultResp") ok
    if !var.ok
        return
    var code = self.faultResp[4]
    if var.code == global.vfdFaultCode
        return
    set global.vfdFaultCode = var.code
    if var.code == 0
        M118 P0 S"VFD: fault cleared"
        return
    var msg = "VFD Fault " ^ var.code
    if var.code == 1
        set var.msg = var.msg ^ " (Overcurrent)"
    elif var.code == 2
        set var.msg = var.msg ^ " (Overvoltage)"
    elif var.code == 3
        set var.msg = var.msg ^ " (Overheating)"
    elif var.code == 4
        set var.msg = var.msg ^ " (Overload)"
    M118 P0 S{var.msg}
    M291 P{var.msg} R"VFD ERROR" S2 T5
    M112
    set global.runDaemon = false

; Read output frequency and load percentage from VFD.
function readVfdStatus()
    var ok = false
    call readVfdRegister(0x0100, 5, "outFreq") ok
    if !var.ok
        result = false
        return
    set global.currentVfdHz = (self.outFreq[3] * 256 + self.outFreq[4]) / 100.0
    G4 P3
    call readVfdRegister(0x0300, 5, "loadResp") ok
    if var.ok
        set global.loadPercentage = self.loadResp[4]
    result = true

; ====================================
; MAIN LOOP
; ====================================
M118 P0 S{"VFD daemon started (max " ^ global.configMaxRPM ^ " RPM)"}

while global.runDaemon
    G4 P{global.configPollingMs}

    var ok = false
    call readVfdStatus() ok
    if !var.ok
        set global.errorCount = global.errorCount + 1
        if global.errorCount >= global.configMaxErrors
            M118 P0 S"VFD: comm failure, stopping spindle"
            M260.4 P1 A1 B{{0x05, 0x02, 0x00, 0x00}} R4
            M3 P0 S0
            set global.spindleState = "STOP"
            set global.errorCount = 0
        continue
    set global.errorCount = 0

    call checkVfdFaults()

    var shouldRun = (spindles[0].state == "forward" || spindles[0].state == "reverse")
    var vfdRunning = (global.spindleState == "CW" || global.spindleState == "CCW")

    if !var.shouldRun && var.vfdRunning
        call stopSpindle()
        continue

    if spindles[0].state == "forward" && global.spindleState != "CW"
        call setSpindleDirection("CW")
    elif spindles[0].state == "reverse" && global.spindleState != "CCW"
        call setSpindleDirection("CCW")

    if var.shouldRun && spindles[0].active > 0
        call setSpindleSpeed(spindles[0].active)

M118 P0 S"VFD daemon stopped"
