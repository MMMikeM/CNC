; Enhanced Spindle Monitoring Daemon with optimized communications and logging
; For Huanyang HY02D223B VFD
; Version 2.0 with improved error handling, thermal management, and adaptive control

; ====================================
; CONFIGURATION SECTION
; ====================================
; User-configurable parameters - can be modified through M-codes between runs
if {!exists(global.configMaxRPM)} 
    global configMaxRPM = 24000         ; Maximum spindle RPM
if {!exists(global.configMaxHz)} 
    global configMaxHz = 400            ; Maximum VFD frequency in Hz
if {!exists(global.configWarmupEnabled)}
    global configWarmupEnabled = true   ; Enable spindle warm-up routine
if {!exists(global.configWarmupMinutes)}
    global configWarmupMinutes = 2      ; Warm-up duration in minutes
if {!exists(global.configWarmupRPM)}
    global configWarmupRPM = 6000       ; Warm-up RPM
if {!exists(global.configPollingIntervalNormal)}
    global configPollingIntervalNormal = 100  ; Normal polling interval in ms
if {!exists(global.configPollingIntervalIdle)}
    global configPollingIntervalIdle = 250    ; Idle polling interval in ms
if {!exists(global.configMaxLogEntries)}
    global configMaxLogEntries = 100    ; Maximum log entries to keep
if {!exists(global.configEnableStatusReporting)}
    global configEnableStatusReporting = true  ; Enable status in dashboard
if {!exists(global.configCommTimeoutMs)}
    global configCommTimeoutMs = 500    ; Communication timeout in ms

; ====================================
; STATE VARIABLES INITIALIZATION
; ====================================
if {!exists(global.runDaemon)} 
    global runDaemon = true             ; Daemon control flag
if {!exists(global.spindleState)} 
    global spindleState = "STOP"        ; Current spindle state (STOP, CW, CCW)
if {!exists(global.lastError)}
    global lastError = 0                ; Last error code
if {!exists(global.errorCount)}
    global errorCount = 0               ; Consecutive error counter
if {!exists(global.vfdLog)}
    global vfdLog = ""                  ; Log storage
if {!exists(global.logEntryCount)}
    global logEntryCount = 0            ; Count of log entries
if {!exists(global.directionVerified)}
    global directionVerified = false    ; Direction change verification flag
if {!exists(global.lastSetFrequency)}
    global lastSetFrequency = 0         ; Last set frequency
if {!exists(global.spindleRunTime)}
    global spindleRunTime = 0           ; Time spindle has been running in seconds
if {!exists(global.spindleWarmupState)}
    global spindleWarmupState = "NONE"  ; Warm-up state (NONE, ACTIVE, COMPLETE)
if {!exists(global.spindleWarmupStartTime)}
    global spindleWarmupStartTime = 0   ; Warm-up start timestamp
if {!exists(global.lastOperationTime)}
    global lastOperationTime = 0        ; Last operation timestamp for timing
if {!exists(global.lastStatusReportTime)}
    global lastStatusReportTime = 0     ; Last time status was reported
if {!exists(global.vfdFaultCode)}
    global vfdFaultCode = 0             ; Current VFD fault code
if {!exists(global.loadPercentage)}
    global loadPercentage = 0           ; Current load percentage
if {!exists(global.currentVfdHz)}
    global currentVfdHz = 0             ; Current VFD frequency

; ====================================
; UTILITY FUNCTIONS
; ====================================

; Logging function with array-based rotation
function addLogEntry(message)
    if #message == 0
        return
    
    ; Get current time for the log entry
    var timestamp = datetime(1)
    set global.vfdLog = global.vfdLog ^ var.timestamp ^ ": " ^ message ^ "\n"
    set global.logEntryCount = global.logEntryCount + 1
    
    ; Rotate log if exceeds maximum entries
    if global.logEntryCount > global.configMaxLogEntries
        var lines = split(global.vfdLog, "\n")
        var newLog = ""
        var startIndex = max(0, length(lines) - global.configMaxLogEntries)
        
        for var i = startIndex while var.i < length(lines) var.i = var.i + 1
            if #lines[var.i] > 0
                set newLog = newLog ^ lines[var.i] ^ "\n"
        
        set global.vfdLog = newLog
        set global.logEntryCount = global.configMaxLogEntries
    
    ; Report to console if configured
    if global.configEnableStatusReporting
        M118 P0 S{"VFD: " ^ message}

; Update dashboard status (called periodically)
function updateStatus()
    ; Only update periodically to avoid flooding
    var currentTime = state.upTime
    if currentTime - global.lastStatusReportTime < 5
        return
    
    set global.lastStatusReportTime = currentTime
    
    ; Create status message based on current state
    var statusMessage = ""
    if global.spindleState == "STOP"
        set statusMessage = "Spindle: Stopped"
    else
        set statusMessage = "Spindle: " ^ global.spindleState ^ " " ^ 
                           floor(global.currentVfdHz * 60) ^ " RPM" ^
                           " Load: " ^ global.loadPercentage ^ "%"
    
    ; Add warmup status if applicable
    if global.spindleWarmupState == "ACTIVE"
        var warmupTimeLeft = floor(global.configWarmupMinutes * 60 - (currentTime - global.spindleWarmupStartTime))
        set statusMessage = statusMessage ^ " (Warming up: " ^ var.warmupTimeLeft ^ "s left)"
    
    ; Add fault code if present
    if global.vfdFaultCode > 0
        set statusMessage = statusMessage ^ " FAULT: " ^ global.vfdFaultCode
    
    ; Display as a temporary popup message that doesn't require dismissal
    M291 P{var.statusMessage} R"VFD Status" S0 T2

; Function to handle VFD read request with retry logic
function readVfdRegister(register, expectedLength, resultVar)
    var retryCount = 0
    var maxRetries = 3
    var retryDelay = 20
    var success = false
    
    ; Format register as high/low bytes
    var highByte = floor(var.register / 256)
    var lowByte = var.register - (var.highByte * 256)
    
    ; Retry loop with timeout
    while var.retryCount < var.maxRetries && !var.success
        ; Send Modbus read command and capture response
        M260.4 P1 A1 B{{0x04, 0x03, var.highByte, var.lowByte, 0x00}} R{var.expectedLength} V{var.resultVar}
        
        ; Check if command succeeded
        if {self[var.resultVar] != null}
            set var.success = true
            break
        
        set var.retryCount = var.retryCount + 1
        G4 P{var.retryDelay}  ; Small delay before retry
    
    ; Return success or failure
    result = var.success

; Function to write to VFD register with verification
function writeVfdRegister(register, value, verify)
    var highReg = floor(var.register / 256)
    var lowReg = var.register - (var.highReg * 256)
    var highVal = floor(var.value / 256)
    var lowVal = var.value - (var.highVal * 256)
    
    ; Send Modbus write command
    M260.4 P1 A1 B{{0x05, 0x02, var.highReg, var.lowReg, var.highVal, var.lowVal}} R4
    G4 P3
    
    ; Verify write if requested
    if var.verify
        G4 P5
        var success = false
        call readVfdRegister(var.register, 5, "verifyResponse") success
        
        if var.success
            var verifyVal = self.verifyResponse[3] * 256 + self.verifyResponse[4]
            if var.verifyVal != var.value
                call addLogEntry("Write verification failed. Expected: " ^ var.value ^ " Got: " ^ var.verifyVal)
                result = false
                return
    
    result = true

; Function to check and handle VFD faults
function checkVfdFaults()
    var success = false
    
    ; Read fault register
    call readVfdRegister(0x03, 5, "faultResponse") success
    
    if !var.success
        call addLogEntry("Failed to read fault status")
        return
    
    ; Parse fault code
    var newFaultCode = self.faultResponse[4]
    
    ; Check if fault status changed
    if var.newFaultCode != global.vfdFaultCode
        set global.vfdFaultCode = var.newFaultCode
        
        if var.newFaultCode > 0
            ; Log the specific fault
            var faultMessage = "VFD Fault detected: " ^ var.newFaultCode
            
            ; Specific fault messages based on Huanyang VFD manual
            if var.newFaultCode == 1
                set var.faultMessage = var.faultMessage ^ " (Overcurrent)"
            elif var.newFaultCode == 2
                set var.faultMessage = var.faultMessage ^ " (Overvoltage)"
            elif var.newFaultCode == 3
                set var.faultMessage = var.faultMessage ^ " (Overheating)"
            elif var.newFaultCode == 4
                set var.faultMessage = var.faultMessage ^ " (Overload)"
            
            call addLogEntry(var.faultMessage)
            
            ; Emergency stop if fault detected
            M291 P{var.faultMessage} R"VFD ERROR" S2 T5
            M112 ; Emergency stop
            set global.runDaemon = false  ; Stop daemon
            
        elif global.vfdFaultCode > 0
            ; Fault cleared
            call addLogEntry("VFD Fault cleared")
    
    result = (var.newFaultCode == 0)

; Function to smoothly stop the spindle
function stopSpindle(withTimeout)
    call addLogEntry("Stopping spindle")
    
    ; Send stop command
    M260.4 P1 A1 B{{0x05, 0x02, 0x00, 0x00}} R4
    G4 P3
    
    ; Wait for spindle to actually stop with timeout
    if var.withTimeout
        var startTime = state.upTime
        var timeout = false
        
        while !var.timeout
            G4 P50
            
            ; Check if spindle has stopped
            var success = false
            call readVfdRegister(0x0100, 5, "speedResponse") success
            
            if !var.success
                break
            
            var currentSpeed = self.speedResponse[3] * 256 + self.speedResponse[4]
            
            ; Exit when stopped or timeout reached
            if var.currentSpeed == 0
                break
                
            if state.upTime - var.startTime > 10  ; 10-second timeout
                call addLogEntry("Spindle stop timeout - continuing anyway")
                set var.timeout = true
    
    ; Reset spindle state
    M3 P0 S0  ; Ensure controller state matches
    set global.spindleState = "STOP"
    set global.spindleRunTime = 0
    set global.spindleWarmupState = "NONE"
    
    ; Update status after stopping
    call updateStatus()

; Function to read current VFD parameters
function readVfdStatus()
    ; Read current set frequency
    var success = false
    call readVfdRegister(0x0000, 5, "rawSetFrequency") success
    
    if !var.success
        return false
        
    ; Read current output frequency
    G4 P3
    call readVfdRegister(0x0100, 5, "rawOutFrequency") success
    
    if !var.success
        return false
    
    ; Read current load percentage (if supported)
    G4 P3
    call readVfdRegister(0x0300, 5, "rawLoadPercentage") success
    
    ; Process readings
    var setFrequency = self.rawSetFrequency[3] * 256 + self.rawSetFrequency[4]
    var outFrequency = self.rawOutFrequency[3] * 256 + self.rawOutFrequency[4]
    set global.currentVfdHz = var.outFrequency / 100.0
    
    ; Update load percentage if available
    if var.success
        set global.loadPercentage = self.rawLoadPercentage[4]
    
    ; Update runtime if spindle is running
    if global.currentVfdHz > 0 && (global.spindleState == "CW" || global.spindleState == "CCW")
        var currentTime = state.upTime
        var elapsed = var.currentTime - global.lastOperationTime
        set global.spindleRunTime = global.spindleRunTime + (var.elapsed / 1000)
        set global.lastOperationTime = var.currentTime
    
    result = true

; Function to set spindle direction
function setSpindleDirection(direction)
    var currentDirection = global.spindleState
    
    ; Skip if already in correct direction
    if (var.direction == "CW" && var.currentDirection == "CW") || 
       (var.direction == "CCW" && var.currentDirection == "CCW")
        return true
    
    ; Stop spindle before changing direction
    var currentlyRunning = false
    if global.currentVfdHz > 0
        set var.currentlyRunning = true
        call stopSpindle(true)
    
    ; Set new direction
    if var.direction == "CW"
        M260.4 P1 A1 B{{0x03, 0x01, 0x01}} R3
        G4 P3
        set global.spindleState = "CW"
        call addLogEntry("Direction changed to CW")
    elif var.direction == "CCW"
        M260.4 P1 A1 B{{0x03, 0x01, 0x11}} R3
        G4 P3
        set global.spindleState = "CCW"
        call addLogEntry("Direction changed to CCW")
    else
        call addLogEntry("Invalid direction: " ^ var.direction)
        return false
    
    ; Clear direction verification flag
    set global.directionVerified = false
    
    ; Verify direction change
    G4 P10
    var success = false
    call readVfdRegister(0x0200, 5, "dirResponse") success
    
    if var.success
        var dirValue = self.dirResponse[4]
        var actualDir = ""
        
        if var.dirValue == 1
            set var.actualDir = "CW"
        elif var.dirValue == 17  ; 0x11
            set var.actualDir = "CCW"
        
        if var.actualDir == var.direction
            set global.directionVerified = true
        else
            call addLogEntry("Direction verification failed: requested=" ^ var.direction ^ " actual=" ^ var.actualDir)
    
    return true

; Function to handle warm-up routine
function handleWarmup()
    ; Skip if warm-up is disabled
    if !global.configWarmupEnabled
        return false
    
    ; Skip if spindle isn't running
    if global.spindleState == "STOP"
        return false
    
    var currentTime = state.upTime
    
    ; Check if we need to initiate warm-up
    if global.spindleWarmupState == "NONE" && global.spindleRunTime < 60
        ; Start warm-up process
        set global.spindleWarmupState = "ACTIVE"
        set global.spindleWarmupStartTime = var.currentTime
        call addLogEntry("Starting spindle warm-up routine")
        
        ; Set warm-up RPM
        var warmupHz = floor(global.configWarmupRPM / global.configMaxRPM * global.configMaxHz * 100)
        var highByte = floor(var.warmupHz / 256)
        var lowByte = var.warmupHz - (var.highByte * 256)
        
        M260.4 P1 A1 B{{0x05, 0x02, var.highByte, var.lowByte}} R4
        G4 P3
        
        call updateStatus()
        return true
    
    ; Check if warm-up is in progress
    if global.spindleWarmupState == "ACTIVE"
        var warmupEndTime = global.spindleWarmupStartTime + (global.configWarmupMinutes * 60)
        
        ; Check if warm-up is complete
        if var.currentTime >= var.warmupEndTime
            set global.spindleWarmupState = "COMPLETE"
            call addLogEntry("Spindle warm-up completed")
            call updateStatus()
            return false
        
        return true
    
    return false

; Function to handle communication recovery
function recoverCommunication()
    set global.errorCount = global.errorCount + 1
    call addLogEntry("Communication error. Attempt " ^ global.errorCount)
    
    if global.errorCount <= 5
        return false
    
    call addLogEntry("Attempting recovery...")
    var recoveryAttempts = 0
    var success = false
    
    while var.recoveryAttempts < 3 && !var.success
        G4 P{50 * (var.recoveryAttempts + 1)}
        
        ; Try to send reset command
        M260.4 P1 A1 B{{0x05, 0x02, 0x00, 0x00}} R4
        G4 P10
        
        ; Try to read basic register
        M260.4 P1 A1 B{{0x04, 0x03, 0x00, 0x00, 0x00}} R5 V"testResponse"
        
        if self.testResponse != null
            set var.success = true
            set global.errorCount = 0
            call addLogEntry("Recovery successful")
            break
            
        set var.recoveryAttempts = var.recoveryAttempts + 1
    
    if !var.success
        call addLogEntry("Recovery failed. Stopping spindle")
        M3 P0 S0
        set global.spindleState = "STOP"
        set global.errorCount = 0
        return false
    
    return true

; Function to set spindle speed with adaptive ramping
function setSpindleSpeed(targetRPM)
    ; Convert RPM to Hz
    var targetHz = var.targetRPM / global.configMaxRPM * global.configMaxHz
    
    ; Safety limit
    if var.targetHz > global.configMaxHz
        set var.targetHz = global.configMaxHz
        call addLogEntry("Warning: Speed request exceeds maximum - limiting to " ^ global.configMaxHz ^ "Hz")
    
    ; Skip update if warm-up is active
    if global.spindleWarmupState == "ACTIVE"
        return
    
    ; Determine max change rate based on current RPM
    var maxChangePerCycle = 3  ; Default for low RPM
    
    if var.targetRPM < 12000
        set var.maxChangePerCycle = 3
    elif var.targetRPM < 18000
        set var.maxChangePerCycle = 5
    else
        set var.maxChangePerCycle = 8
    
    ; Apply rate limiting to frequency changes
    var freqDifference = var.targetHz - global.currentVfdHz
    if abs(var.freqDifference) > var.maxChangePerCycle
        if var.freqDifference > 0
            set var.targetHz = global.currentVfdHz + var.maxChangePerCycle
        else
            set var.targetHz = global.currentVfdHz - var.maxChangePerCycle
    
    ; Update VFD frequency only if significant change AND different from last command
    if abs(global.currentVfdHz - var.targetHz) > 0.25 && var.targetHz != global.lastSetFrequency
        var scaledFrequency = floor(var.targetHz * 100)
        var highByte = floor(var.scaledFrequency / 256)
        var lowByte = var.scaledFrequency - (var.highByte * 256)
        
        M260.4 P1 A1 B{{0x05, 0x02, var.highByte, var.lowByte}} R4
        G4 P3
        set global.lastSetFrequency = var.targetHz
        
        ; Log speed update
        call addLogEntry("Speed updated to " ^ var.targetHz ^ "Hz (" ^ floor(var.targetHz / global.configMaxHz * global.configMaxRPM) ^ " RPM)")

; Verify spindle speed accuracy and detect potential issues
function verifySpindleSpeed()
    ; Skip verification during warm-up or if just started
    if global.spindleWarmupState == "ACTIVE" || global.spindleRunTime < 10
        return
    
    ; Calculate expected Hz based on commanded RPM
    var requestedRPM = spindles[0].active
    var expectedHz = var.requestedRPM / global.configMaxRPM * global.configMaxHz
    
    ; Check for significant deviation (more than 5%)
    var allowedDeviation = var.expectedHz * 0.05
    
    if abs(var.expectedHz - global.currentVfdHz) > var.allowedDeviation && global.currentVfdHz > 1
        ; Only report once every 10 seconds to avoid flooding
        if state.upTime - global.lastError > 10
            call addLogEntry("Warning: Speed deviation detected: Expected=" ^ 
                          var.expectedHz ^ "Hz Actual=" ^ global.currentVfdHz ^ "Hz")
            set global.lastError = state.upTime
        
        ; If deviation is extreme (>15%), might indicate a problem
        if abs(var.expectedHz - global.currentVfdHz) > (var.expectedHz * 0.15)
            call addLogEntry("Critical: Large speed deviation - check spindle!")

; ====================================
; MAIN DAEMON LOOP
; ====================================
call addLogEntry("VFD Monitoring Daemon Started - " ^ global.configMaxRPM ^ " RPM max")

; Initialize timing
set global.lastOperationTime = state.upTime
set global.lastStatusReportTime = state.upTime

while global.runDaemon
    ; Create adaptive polling interval
    var pollingInterval = global.configPollingIntervalNormal
    
    ; Use longer interval if spindle is stopped
    if global.spindleState == "STOP"
        set var.pollingInterval = global.configPollingIntervalIdle
    
    G4 P{var.pollingInterval}  ; Wait between cycles
    
    ; Read VFD status
    var success = false
    call readVfdStatus() success
    
    ; Handle communication errors
    if !var.success
        var recovered = false
        call recoverCommunication() recovered
        
        if !var.recovered
            continue
    else
        set global.errorCount = 0  ; Reset error counter if successful
    
    ; Check for spindle faults
    call checkVfdFaults()
    
    ; Update dashboard status periodically
    if global.configEnableStatusReporting
        call updateStatus()
    
    ; Process readings and determine actions
    ; Determine spindle state from controller
    var shouldRun = (spindles[0].state == "forward" || spindles[0].state == "reverse")
    var vfdForward = (global.spindleState == "CW")
    var vfdReverse = (global.spindleState == "CCW")
    var vfdRunning = (var.vfdForward || var.vfdReverse)
    
    ; Handle spindle stop request
    if !var.shouldRun && var.vfdRunning
        call stopSpindle(true)
        continue
    
    ; Handle spindle warm-up if needed
    var isWarmingUp = false
    call handleWarmup() isWarmingUp
    
    if var.isWarmingUp
        continue
    
    ; Handle direction changes
    if spindles[0].state == "forward" && !var.vfdForward
        call setSpindleDirection("CW")
    elif spindles[0].state == "reverse" && !var.vfdReverse
        call setSpindleDirection("CCW")
    
    ; Handle speed updates
    if var.shouldRun && spindles[0].active > 0
        call setSpindleSpeed(spindles[0].active)
    
    ; Verify spindle speed accuracy periodically
    call verifySpindleSpeed()

; Daemon shutdown cleanup
call addLogEntry("VFD Monitoring Daemon Stopped")