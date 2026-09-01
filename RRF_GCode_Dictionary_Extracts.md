# RepRapFirmware G-code Dictionary — extracts for config.g

> Source: https://docs.duet3d.com/en/User_manual/Reference/Gcodes (fetched 2026-09-01)

> Only the commands used in this machine's config.g are included. Each section is verbatim from the Duet3D docs (CC BY-SA).


---

## M111: Set Debug Level

### Parameters

- **Pnn** Debug module number
- **Sn** Debug on (S1), off (S0). S0 is equivalent to D0. S1 is equivalent to D{0xFFFF}.
- **Dnnn** Set/clear individual debug flags for the specified module
- **Bnnnn**

  - RRF 3.6.0 and later: Selects the CAN-connected expansion/tool board
  - RRF 3.5.x: Redirect debug output and allocate buffer memory size

- **Fnnnn** Redirect debug output and allocate buffer memory size (RRF 3.6.0 and later)


#### SBC mode

From v3.6.0, `M111 P-1` can be used to set debug logging parameters for DCS in SBC mode. Additional parameters for `M111 P-1` include:

- **Snnn** Set debug level (one of `trace`, `debug`, `info`, `warning`, `error`, `fatal`)
- **Onnn** Output log messages as generic messages via DWC (e.g. `O1`)


### Examples


```
M111
M111 P4 S1 ; enable all debugging for module 4
M111 P4 D2 ; enable just bit 1 debugging information for module 4
M111 B1024 ; allocate a 1K debug buffer (RRF 3.5.x)

```


### Description

Enable or disable debugging features for the module number specified by the P parameter. M111 without parameters lists all the modules, their numbers, and whether debugging is enabled for each.

The details of what debugging information is output when debugging is enabled varies from one firmware revision to another, so it is not specified here.

### Notes

- Print quality may be affected when debug output is enabled because of the volume of data sent to USB.
- Debug output is normally sent to the USB port, and any debug output generated from an interrupt service routine is discarded. You can use M111 with the F (RRF 3.6.0 or later) or B (RRF 3.5.x) parameter to allocate a debug buffer; in which case debug output is written to the buffer (even when it comes from an interrupt service routine) and is later extracted and written as a generic message to all active input channels. The F (or B) parameter is the debug buffer size in bytes and must be an exact power of 2. Debug data that can't be written to the buffer because it is full is discarded.
- After the F (RRF 3.6.0 or later) or B (RRF 3.5.x) parameter is used to allocate a debug buffer, if excessive amounts of debug data are generated then HTTP disconnections may occur.
- Debug output should normally be used only for debugging firmware, or when instructed to help with diagnosis of particular issues.


---

## M550: Set Name

### Parameters

- **P"nnn"** Machine name


### Examples


```
M550 P"Godzilla"

```


### Description

Sets the name of the printer to (in the case of the above example) Godzilla. The name can be any string of printable characters except ';', which still means start comment. The name shows at the top of the DWC page.

The machine name is also used to allow local network discovery using **mDNS local network discovery**. Rather than remembering the ip address of the printer to connect to, or having to find it if assigned by DHCP (mDNS works both with fixed ip address and DHCP), you can use it's name. Using the example name above, in your browser connect to the DWC with `http://Godzilla.local`.

### Notes

- Quotation marks around the machine name are mandatory in RRF3, but discretionary in earlier firmware versions.
- In SBC mode, this command should be in dsf-config.g, NOT config.g.
- Using the machine name to access the machine on the network relies on mDNS. This needs to be supported on the device trying to connect. See a longer description about [mDNS support here](https://docs.duet3d.com/User_manual/Machine_configuration/Networking#a-note-about-mdns-local-network-discovery).
- The machine name is also used as the NetBIOS name, which can help to identify the Duet on a network. This is only supported on Duet 2 WiFi and legacy Duet 0.6/0.85.
- Both the mDNS and NetBIOS name are limited to 15 characters. If you use a longer name, the mDNS name will be the first 15 characters, eg if the Duet name is "3DPrinterWithVeryLongName", you should still be able to connect to "3DPrinterWithVe.local".


---

## M575: Set serial comms parameters

This sets the communications parameters of the serial comms channel specified by the P parameter.

### Parameters

- **Pnnn** Serial channel number
- **Bnnn** Baud rate, default 57600 (same as the default PanelDue baud rate)
- **C"port_name"** Port name for Transmit/Receive control of the RS485 transceiver when the mode is Device and you are using it for Modbus RTU (S7). Not required when running on Duet hardware with a built-in RS485 transceiver. Not required if the transceiver module does automatic transmit/receive switching (note that such transceivers may not work with some Modbus devices).
- **Snnn** Mode: 0 = PanelDue; 1 (default) = PanelDue mode, checksum or CRC required; 2 = raw mode; 3 = raw mode with checksum or CRC required; 4 = PanelDue mode, CRC required; 5 = disabled; 6 = raw mode, CRC required; 7 = Device, e.g. Modbus or raw UART (if supported).
- **Fn** Selects number of data bits and parity (optional, supported in RRF 3.7.0-beta2 and later). Only applied when the port is in Device mode. 0 = 8 data bits, no parity bit (default); 1 = 8 data bits, even parity; 2 = 8 data bits, odd parity.


### Examples


```
;RRF 3.6 and earlier
M575 P1 B57600 S1 ; sets first auxiliary port (io0 on Duet 3) to PanelDue mode
M575 P2 B9600 S7 ; sets second auxiliary port (io1 on Duet 3) to Device mode (e.g. for Modbus)

```


### Notes

-

**P parameter** (RRF 3.7 and later)
 All Duet 3 main boards now provide two CDC channels over USB. This means that in M575 commands, device 1 is now the second USB CDC device, device 2 is the first serial port, and device 3 is the second serial port.

  - P0 specifies the main serial interface, typically a USB port.
  - P1 specifies the second serial interface, typically a USB port.
  - P2 specifies an auxiliary serial port (for example, the port used to connect a PanelDue, usually io0 on Duet 3)
  - P3 specifies a second auxiliary port if there is one (for example, the port used for RS485, usually io1 on Duet 3)

-

**P parameter** (RRF 3.6 and earlier)

  - P0 specifies the main serial interface, typically a USB port.
  - P1 specifies an auxiliary serial port (for example, the port used to connect a PanelDue, usually io0 on Duet 3)
  - P2 specifies a second auxiliary port if there is one (for example, the port used for RS485, usually io1 on Duet 3)

-

The **B parameter** is the required baud rate (this parameter is ignored if the port is a true USB port).
-

The **S parameter** defines the mode. Modes 2 and 3 are supported in RRF 3.01 and later. Modes 4 and 6 are supported in RRF 3.4 and later. Mode 5 is supported in RRF 3.6 and later. Mode 7 is supported by RRF 3.6 and later on some boards.
-

In RRF 3.1 and later for Duet 3, the auxiliary serial port remains disabled until a M575 P1 command is received. This is to allow the IO_0 port to be used for other purposes. In RRF 3.2 and later on all boards, the auxilliary serial port(s) remain disabled until enabled using M575.
-

In RRF 3.6.0 and later, the USB port can now be switched into PanelDue mode using M575.
-

Details of the CRC calculation are outlined in the [Gcode Structure](https://docs.duet3d.com/User_manual/Reference/Gcodes#crc) section above
-

For more information connecting RS485/Modbus devices, see [Connecting RS485 and Modbus RTU devices](https://docs.duet3d.com/User_manual/Connecting_hardware/RS485_Modbus)


#### PanelDue mode vs Raw mode

PanelDue mode is more resistant to interference and lost data because of the JSON structure and associated field identifiers, and makes it easier to distinguish the responses to particular commands from other data.

here is an example of the M114 command and response sent in PanelDue mode



```
M114
{"seq":6,"resp":"X:10.000 Y:50.000 Z:1.000 U:0.000 E:0.000 E0:0.0 E1:0.0 Count 4800 4000 400 4000 Machine 10.000 50.000 1.000 0.000 Bed comp 0.000\n"}

```


here is an example of the same command in raw mode



```
M114
X:10.000 Y:50.000 Z:1.000 U:0.000 E:0.000 E0:0.0 E1:0.0 Count 4800 4000 400 4000 Machine 10.000 50.000 1.000 0.000 Bed comp 0.000

```


---

## M584: Set drive mapping
- RepRapFirmware 3.5 and later
- RepRapFirmware 3.4.x and earlier

##### Parameters

- **Xnnn** Driver number(s) for X motor(s)
- **Ynnn** Driver number(s) for Y motor(s)
- **Znnn** Driver number(s) for Z motor(s)
- **Ennn** Driver number(s) for E motor(s)
- **Unnn, Vnnn, Wnnn, Annn, ...** Additional axes and driver number(s). Available axis names are UVWABCDabcdef, additionally ghijklmnopqrstuvwxyz on Duet 3 MB6HC and MB6XD only.
- **Rn** (optional) 0 = axes created in this command are linear, 1 = axes created are rotational. If not present, RRF assumes UVW are linear and ABCD are rotational.
- **Sn** (optional) 0 = axes created in this command are treated as linear in feedrate calculations, 1 = axes created are treated as rotational in feedrate calculations. See section 2.1.2.5 of the NIST GCode standard for how the feedrate is interpreted. Default is S0 for linear axes and S1 for rotational axes (see the R parameter).
- **Pnnn** Number of visible axes, defaults to the total number of axes configured, excluding extruder drives.

##### Notes (3.5.x and later)

- You can use M584 to create additional axes - for example, to represent additional carriages on a machine with multiple independent X carriages. You can create new axes in any order.
- The maximum number of axes configurable is dependent on the firmware version, see: [RepRapFirmware overview, firmware configuration limits](https://docs.duet3d.com/User_manual/RepRapFirmware/RepRapFirmware_overview#firmware-configuration-limits)
- **VERY IMPORTANT!** X (driver 0), Y (driver 1) and Z (driver 2) are assigned by default.
- There are no default extruder drives; all extruder drives must be declared explicitly using M584.
- Using M584 to map drivers to axes does not affect endstop inputs. Endstops inputs for each axis need to be defined.

##### Parameters

- **Xnnn** Driver number(s) for X motor(s)
- **Ynnn** Driver number(s) for Y motor(s)
- **Znnn** Driver number(s) for Z motor(s)
- **Ennn** Driver number(s) for E motor(s)
- **Unnn, Vnnn, Wnnn, Annn, ...** Additional axes and driver number(s). Available axis names depend on firmware version:
 UVW available from RepRapFirmware 1.16
 UVWABC available from RepRapFirmware 1.19 and 2.x
 UVWABCD available from RepRapFirmware 3.0 thru 3.2
 UVWABCDabcdefghijkl available in RepRapFirmware 3.4
- **Rn** (optional, supported in RRF 3.2 and later) 0 = axes created in this command are linear, 1 = axes created are rotational. If not present, RRF 3.2 and later assume UVW are linear and ABCD are rotational.
- **Sn** (optional, supported in RRF 3.2 and later) 0 = axes created in this command are treated as linear in feedrate calculations, 1 = axes created are treated as rotational in feedrate calculations. See section 2.1.2.5 of the NIST GCode standard for how the feedrate is interpreted. Default is S0 for linear axes and S1 for rotational axes (see the R parameter).
- **Pnnn** Number of visible axes, defaults to the total number of axes configured, excluding extruder drives.

##### Notes (3.4 and earlier)

- You can use M584 to create additional axes - for example, to represent additional carriages on a machine with multiple independent X carriages.
- In 1.20 and later firmware you can create new axes in any order. In earlier firmware versions, additional axes must be created in the order UVWABC.
- The maximum number of axes configurable is dependent on the firmware version, see: [RepRapFirmware overview, firmware configuration limits](https://docs.duet3d.com/User_manual/RepRapFirmware/RepRapFirmware_overview#firmware-configuration-limits)
- **VERY IMPORTANT!** From **RRF 3.3**, X (driver 0), Y (driver 1) and Z (driver 2) are assigned by default. There are no default extruder drives; all extruder drives must be declared explicitly using M584.
- In **RRF 3.2.2 and earlier**, X (driver 0), Y (driver 1), Z (driver 2) and one extruder (driver 3) are assigned by default.
- Changing an existing drive (i.e. X, Y, Z or E) to a different driver with an **existing** assignment will result in two axes using the same driver, e.g. M584 X1 results in 'Driver assignments: X1 Y1 Z2'. Changing a drive to an unassigned driver results in the drive moving to the new driver, e.g. M584 Z3 results in 'Driver assignments: X1 Y1 Z3'. This may result in unexpected behaviour. It is best practice to define all drives explicitly as in the above example, if you are not using the default drive/driver assignments.
- Using M584 to map drivers to axes does not affect endstop inputs.

  - In RRF 3, endstops inputs for each axis need to be defined.
  - In RRF 2, endstop inputs XYZ are pre-allocated, after that they are allocated in the order in which axes are created. So if you create just one extra axes (e.g. U), it will use the E0 endstop input. If more than one axis is created in a single M584 command, endstop inputs are allocated to the new axes in axis creation order (see previous item). For example, M584 C5 U6 would allocate endstop input E0 to the U axis and E1 to the C axis.



### Order dependency

- M584 must come earlier in config.g than any M350 and M906 commands. If it creates new axes, it must also be earlier than any M92, M201, M203, M208, M350, M566, M574, M667 and M669 commands.


### Examples


```
M584 X0 Y1 Z2:3 E4:5:6 ; Driver 0 controls the X motor, 1 controls Y, 2 and 3 control Z motors, 4 5 and 6 control E motors

```


### Notes (all versions)

-

Every driver that is assigned must have its current set using M906. Not setting a current will default a low current (approx 1/32 of the driver max current), however M906 will report 0 until a current is assigned. Disable the driver explicitly if you do not want any current sent to a driver that is assigned.
-

Because GCode is normally case insensitive, axes that are represented by lowercase letters must be prefixed with a single quote character in GCode commands. For example, M584 'A1.2 would assign axis 'a' to driver 1.2, and G1 'A10 would move the 'a' axis to the 10mm or 10 degree position (or by 10mm or 10 degrees if in relative mode).
-

**P** paramter: You can hide axes, starting with the last axis created, using the P parameter. Hidden axes have no homing buttons or jog controls in the user interface.
-

If you create more than one axis in a M584 command, the axes are created in the order UVWABCDabcdefghijkl regardless of the order of the parameters in the M584 command. This affects which axes will be hidden if you use the M584 P parameter to hide axes. For example, M584 C5 U6 creates axes U and C in that order, so M584 P4 would hide the C axis, not the U axis. If you want to create the axes in the order C then U (so that M584 P4 hides the U axis), use two M584 commands: M584 C5 followed by M584 U6.
-

RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour. Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M92 Z80, not M92 Z80:80
-

On the Duet 2 WiFi and Duet 2 Ethernet, if you configure multiple drivers for an axis, either all of them must be TMC2660 drivers on the Duet or a Duet expansion board, or none of them must be. This is to facilitate dynamic microstepping and other features of the TMC2660.
-

On Duet 3 mainboards and expansion boards, the drivers are assigned with <board CAN address>.<driver number>. The mainboard is always CAN address 0, and is implied if omitted. Example:


```
M584 X0 Y1 Z2 E3:4:1.0:1.1

```
 The "0" index for the main board is implicit, this is equivalent to the previous example:


```
M584 X0.0 Y0.1 Z0.2 E0.3:0.4:1.0:1.1

```

-

If you assign an axis or extruder to one or more drivers, and later you want to reassign it to a different driver, then to ensure correct operation you must disable those axes/extruders using M18 before using M584 to reassign them. After using M584, you must set the motor current using M906 and the microstepping using M350. Example:


```
; Here axis B and extruder E0 have already been assigned and possibly moved, but we now want to reassign them
M18 B E0      ; disable the axes/extruder that we are going to reassign
M584 B3 E4     ; reassign them
M906 B1000 E1000  ; set the motor currents
M350 B16 E16 I1  ; set the microstepping

```


---

## M569: Set motor driver direction, enable polarity, mode and step pulse timing

### Parameters

- **Pnnn** Motor driver number
- **Snnn** Direction of movement of the motor(s) attached to this driver: 0 = backwards, 1 = forwards (default 1)
- **Rnnn** Driver enable polarity: 0 = active low, 1 = active high, -1 = driver is always disabled and is not monitored, and in the case of external drivers the error input is ignored (default 0)
- **Tnnn** (firmware 1.14 and later) Minimum driver step pulse width and interval in microseconds
- **Taa:bb:cc:dd** (firmware 1.21 and later) Minimum driver step pulse width, step pulse interval, direction setup time and direction hold time, in microseconds (only applies to external drivers connected to Duet 2, Duet 3 Mini 5+, Duet 3 MB6XD and Duet 3 Expansion 1XD)
- **Dnn** (firmware 2.0 and later, only applies to TMC2660, TMC22xx, TMC2160 and TMC5160 stepper drivers) Driver mode: 0=constant off time, 1=random off time (TMC2660 drivers only), 2=spread cycle, 3=stealthChop (mode 3 for TMC22xx/TMC2160/TMC5160 only), 4=Closed Loop, 5=Assisted open loop (modes 4 and 5 are only for Duet 3 closed loop controllers and motors such as the [1HCL](https://docs.duet3d.com/Duet3D_hardware/Duet_3_family/Duet_3_Expansion_1HCL) and the [Motor23CL](https://docs.duet3d.com/Duet3D_hardware/Duet_3_family/Duet_3_Motor_23CL)). The default is spreadCycle for all drivers from RRF 3.4, and stealthChop2 for TMC22xx in RRF 3.3 and earlier. In stealthChop mode the drivers will switch over to spreadCycle automatically at high speeds, see the V parameter.
- **Fnn** (firmware 2.02 and later) Off-time in the chopper control register, 1 to 15
- **Cnnnn** (firmware 2.0 and later, only applies to TMC2660, TMC22xx, TMC2160 and TMC5160 stepper drivers) Lowest 17 bits of the chopper control register value.
- **Bnn** (firmware 2.02 and later) Blanking time (*tbl*) in the chopper control register, 0 to 3. See the TMC driver datasheet.
- **Hnn** (firmware 2.02 and later) *thigh* parameter for those stepper driver chips that support it, e.g. TMC5160 and TMC2160. Send M569 P# (where # is the driver number) with no additional parameters to see how this translates into mm/sec. See also the V parameter.
- **Yaa:bb** or **Yaa:bb:cc** (firmware 2.02 and later) Hysteresis start, end and decrement values in the chopper control register. See the TMC driver datasheet for the meaning.
- **Vnnn** (firmware 2.02 and later) *tpwmthrs* parameter for those stepper driver chips that support it. This is the interval in clock cycles between 1/256 microsteps below which the drivers will switch from stealthChop to to spreadCycle mode. Only applies when the driver is configured in stealthChop mode. Typical value are from 100 (high speed) to 4000 (low speed). Send M569 P# (where # is the driver number) with no additional parameters to see how this translates into mm/sec.
- **Unn** (firmware 3.6.0 onwards) for stepper drivers that support *globalscaler* (TMC5160/2160). This is the maximum value to use for iRun current scaler, 0-31. If not set (and in older firmware versions), this is set to 31 and globalscaler is calculated, otherwise iRun will be set to the value specified. However if the target current can't be reached by reducing globalscaler alone, iRun, and iHold, are also reduced, likewise if the target current is high then iRun and iHold may be increased to achieve it. This means iRun and iHold may be set different than specified to ensure the requested current is applied to the motors, sending `M569 Px` can be used to verify the iRun value used and the calculated current the driver will actually apply to the motor. Setting iRun directly can allow setting hysteresis start/end values that are more suitable for specific motors, resulting in lower noise. In theory this should only be needed when using low inductance motors, or a high motor supply voltage (e.g. 48V). You can use the excel calculator provided by TMC to help tune iRun and hysteresis values.


### Examples


```
M569 P0 S0        ; reverse the direction of the motor attached to driver 0
M569 P5 R1 T2.5:2.5:5:0  ; driver 5 requires an active high enable, 2.5us minimum step pulse, 2.5us minimum step interval, 5us DIR setup time and no hold time

```


### Notes

- If no T parameter is given, then on boards having internal drivers the step pulse width and interval are guaranteed to be suitable for the on-board drivers only, and will generally be too fast for external drivers. On the EXP1XD board the default is T2.7:2.7:2.7:2.7. On the MB6XD board the default is T2.5:2.5:2.5:2.5.
- The T values get rounded up to the next highest value supported by the firmware. So the values reported back may be a little higher than you requested.
- **RepRapFirmware takes the highest T parameters seen in any M569 command, and applies those values to all drivers for which any nonzero T parameter was specified.** So if you want to reduce the T parameters, you will need to do that on all drivers that already have nonzero T parameters. On the MB6XD this means that if you want to reduce the T values below the defaults, you need to do this on all six drivers even if you are not using all of them. Additionally, on all main boards except for the MB6XD, if you reduce the T parameters then you must restart the firmware for the change to take effect. On Duet 3 systems with CAN-connected expansion boards this note applies separately to each board. It does not apply to the EXP1XD because that board has only one driver.
- Some versions of RepRapFirmware prior to 1.14 also provided XYZ and E parameters to allow the mapping from axes and extruders to stepper driver numbers to be changed. From 1.14 onward, this functionality is provided by M584 instead.


---

## M569.9: Configure driver sense resistor and maximum current

*Supported by the STM port of RRF only*

### Parameters

- **Pn.n** Motor CAN board address (if applicable) and driver number
- **Rnnnn** Driver current sense resistor value in ohms
- **Snnnn** Driver maximum current limit in amperes


### Examples


```
M569.9 P0.1 R0.075 S4.4   ; driver 1 on the main board has a 0.075 Ohm sense resistor and will have the maximum current setting limited to 4.4A

```


### Notes

This command is available on boards running the STM32 port of RepRapFirmware (version 3.4.2_102 and later), it can be used to inform the firmware of the TMC driver sense resistor and maximum current limit used by driver modules that have non standard values.


---

## M350: Set microstepping mode

### Usage

- M350 Xnn Ynn Znn Enn Inn


### Parameters

- *Not all parameters need to be used, but at least ***one*** should be used. As with other commands, RepRapFirmware reports the current settings if no parameters are used*.
- **Xnn** Set stepping mode for the X axis
- **Ynn** Set stepping mode for the Y axis
- **Znn** Set stepping mode for the Z axis
- **Enn** Set stepping mode for Extruder 0 (use Enn:nn:nn etc. for multiple extruders)
- **Inn** Enable (nn=1) or disable (nn=0) microstep interpolation mode for the specified drivers, if they support it. All Duet 3 boards, and Duet 2 Maestro supports interpolation at all microstep settings. Duet 2 WiFi/Ethernet support interpolation (to x256 microstepping) only when configured for x16 microstepping.


**Modes (nn)**

- 1 = full step
- 2 = half step
- 4 = quarter step
- 8 = 1/8 step
- 16 = 1/16 step
- 32 = 1/32 step
- 64 = 1/64 step
- 128 = 1/128 step
- 256 = 1/256 step


### Order dependency

This command must be later in config.g than any M584 command.

### Examples


```
M350 Z1 ;set the Z-axis' driver to use full steps
M350 E4:4:4 ;set extruders 0-2 to use quarter steps)

```


When M350 is processed, the steps/mm will be adjusted automatically to allow for any changes in microstepping. Therefore you can either:

a) Set Steps/mm correctly for the default 1/16 microstepping, then set the microstepping to the desired amount using M350:



```
M92 X80 Y80 Z400 ; set axis steps/mm
M92 E420:430 ; set extruder 0 and 1 steps/mm
M350 X128 Y128 Z128 E128:128 ; set microstepping

```


or

b) Set the microstepping using M350 and then set the correct steps/mm for that microstepping amount:



```
M350 X128 Y128 Z128 E128:128 ; set microstepping
M92 X640 Y640 Z3200 ; set axis steps/mm @128 microstepping
M92 E3360:3440 ; set extruder 0 and 1 steps/mm

```


Assuming that in the first example the microstepping was initially at the default x16, both the above examples result in the same steps/mm settings.

### Notes

- RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour.
 Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M350 Z16, not M350 Z16,16
- Microstep interpolation at all microstep settings is supported on all Duet 3 boards with onboard drivers (TMC5160, TMC2160 or TMC2209), and on Duet 2 Maestro (TMC2224 drivers). The TMC2660 drivers used on the Duet 2 WiFi and Duet 2 Ethernet support microstep interpolation, but only when microstepping is set to 16. In other configurations, specifying I1 has no effect.
- When using external drivers, the microstepping mode (M350) is not controlled by firmware configuration. It is set by the external stepper driver, usually using jumpers to set the 'pulses per rotation'.


---

## M92: Set axis steps per unit

### Parameters

- *This command can be used without any additional parameters.*
- **Xnnn** Steps per mm for the X drive
- **Ynnn** Steps per mm for the Y drive
- **Znnn** Steps per mm for the Z drive
- **Unnn** Steps per mm for the U drive
- **Vnnn** Steps per mm for the V drive
- **Wnnn** Steps per mm for the W drive
- **Ennn** Steps per mm for the extruder drive(s)
- **Snnn** Defines in which microstepping the above steps per unit are given. If omitted it will use the microstepping currently set by M350. This parameter is supported in RRF >=2.03.


### Order dependency

If this command refers to any axes other than X, Y and Z then it must be later in config.g than the M584 command that creates those additional axes.

### Examples


```
M92 X80 Y80 Z80
M92 E420:500

```


### Notes

- Allows programming of steps per mm for motor drives. These values are reset to those set in config.g on power on.
- Sending `M92` without any parameters will report the current steps/mm for each axis.
- RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour.
 Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M92 Z80, not M92 Z80:80
- RepRapFirmware uses floating point maths so it is possible to use floating point numbers for steps/mm.


---

## M906: Set motor currents

Sets the peak currents to send to the stepper motors for each axis. The values are in milliamps.

### Parameters

- **Xnnn** X drive peak motor current
- **Ynnn** Y drive peak motor current
- **Znnn** Z drive peak motor current
- **Ennn** E drive(s) peak motor current(s)
- **Innn** Motor current idle factor (0..100)
- **Tnnn** Idle time-out in seconds (RRF 3.6.0 and later)


### Order dependency

This command must be later in config.g than any [M584](https://docs.duet3d.com/User_manual/Reference/Gcodes/M584) command.

### Examples


```
M906 X300 Y500 Z200 E350:350

```


### Notes

-

RRF uses peak current. Divide by 1.414 for RMS current as used in Marlin implementations for Trinamic drivers
-

Current setting on the various Duet boards are as follows:

  - Duet 2 WiF/Ethernet is done in steps of 100mA and is rounded down.
  - Duet Maestro is in steps of 50mA and rounded down.
  - Duet 3 MB6HC and EXP3HC is in steps of 26.2mA.
  - Duet 3 Mini5+ is in steps of 74mA (provisionally), rounded down.
  - Duet 3 1LC toolboard is in steps of 50mA, rounded down.

-

The **I** parameter is the percentage of normal that the motor currents should be reduced to when the printer becomes idle but the motors have not been switched off. The default value is 30% and will always be at least 100mA - starting from RRF 2.02 setting it to 0 will disable the steppers after timeout like M18|M84 do and if an axis is related to the motor, throw out the "homing" of it, since it is likely that the position cannot be precisely determined anymore. Note that the idle current is applied globally for all motors and cannot be set per axis.
-

Every driver that is assigned must have its current set using M906. Not setting a current will default a low current (approx 1/32 of the driver max current), however M906 will report 0 until a current is assigned. Disable the driver explicitly if you do not want any current sent to a driver that is assigned.
-

As a rule of thumb, the recommendation is to set M906 to use 60-85% of the rated maximum current for the motor. Though you can go above or below as needed, and will have to tune for a balance of motor temperature, motor torque, and noise level. You can also use the EMF calculator ([reprapfirmware.org](https://www.reprapfirmware.org/) and click on EMF calculator) to play with different values to see how it changes behaviour.
-

The **T** parameter (RRF 3.6.0 and later) is used to set the idle timeout for all motors (M84 was previously used for this). For example, M906 T10 will idle the stepper motors after 10 seconds of inactivity. Setting `M906 T0` does NOT mean "never idle hold" (ie motors stay on all the time, at full current), and T0 is an invalid setting. The correct way to set no idle hold (ie motors are 'always on') is to use M906 I parameter to set the idle hold to the required level, eg `M906 I100`.
-

RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour. Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M906 Z200, not M906 Z200:200
-

When using external drivers, the motor current (M906) is not controlled by firmware configuration. It is set by the external stepper driver, usually using jumpers.


---

## M84: Stop idle hold

*Deprecated in RRF 3.6.0 and later. Use M18 to disable motors, and M906 T# to set idle timeout*

### Parameters

- *This command can be used without any additional parameters.*
- **Snnn** Idle Time-out
- X,Y, E0:1.. etc


### Examples


```
M84            ; Disable all motors
M84 S10        ; Set idle time out to 10 seconds
M84 E0:1:2:3:4 ; Disable specific motors

```


### Description

Stops the idle hold on all axis and extruder, effectively disabling the specified motor, or all motors, the same as [M18](https://docs.duet3d.com/User_manual/Reference/Gcodes/M18). Be aware that by disabling idle hold during printing, you will get quality issues.
 Also used to set the idle timeout for all motors. For example, `M84 S10` will idle the stepper motors after 10 seconds of inactivity. The idle current is set by the [M906](https://docs.duet3d.com/User_manual/Reference/Gcodes/M906) I parameter.

### Notes

- For example, `M84 S10` will idle the stepper motors after 10 seconds of inactivity.
- You can disable individual motors with the standard X, Y, Z etc switches.
- Setting `M84 S0` does NOT mean "never idle hold" (ie motors stay on all the time, at full current), and S0 is an invalid setting. The correct way to set no idle hold (ie motors are 'always on') is to use M906 I parameter to set the idle hold to the required level, eg `M906 I100`.


---

## M203: Set maximum feedrate

### Parameters

- **Xnnn** Maximum feedrate for X axis
- **Ynnn** Maximum feedrate for Y axis
- **Znnn** Maximum feedrate for Z axis
- **Unnn** Maximum feedrate for U axis
- **Vnnn** Maximum feedrate for V axis
- **Wnnn** Maximum feedrate for W axis
- **Ennn:nnn...** Maximum feedrates for extruder drives
- **Sn** Optional, S1 changes units to mm/sec, S0 (or any other S value) mm/min (default)
- **Innn** Minimum overall movement speed (firmware 2.03 and later), default 30mm/min


### Order dependency

If this command refers to any axes other than X, Y and Z then it must be later in config.g than the M584 command that creates those additional axes.

### Examples


```
M203 X6000 Y6000 Z300 E10000

```



```
M203 Z10 S1 ;mm/s
M203 X6000 Y6000 ;mm/min

```


### Notes

- Sets the maximum feedrates that your machine can do in mm/min (or mm/s of th option S1 parameter is used)
- RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour.
 Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M203 Z300, not M203 Z300,300
- RepRapFirmware has a default minimum movement speed of 0.5mm/sec, or 30mm/minute. Gcode commands sent with a slower feedrate than this (e.g. drilling) will automatically run at this speed.
 In firmware 2.03 and later this can be changed using the I ('i') parameter of the [M203](https://docs.duet3d.com/User_manual/Reference/Gcodes/M203) command. For example, for a 10mm/minute minimum speed, send:


```
M203 I10 ; set minimum speed to 10mm/min

```

- RRF also has an 'Absolute Minimum Feedrate' of 0.01mm/sec or 0.6mm/minute. Setting M203 I0 will use this as the minimum feedrate. If you need even lower feedrates, eg for micromachining, we recommend scaling (see [Duet3D forum thread here for example](https://forum.duet3d.com/topic/31858/duet2-wifi-generating-polygons-instead-of-circles)).


---

## M201: Set max acceleration

### Parameters

- **Xnnn** Acceleration for X axis
- **Ynnn** Acceleration for Y axis
- **Znnn** Acceleration for Z axis
- **Unnn** Acceleration for U axis
- **Vnnn** Acceleration for V axis
- **Wnnn** Acceleration for W axis
- **Ennn:nnn...** Acceleration for extruder drives
- **Tn.nn** Acceleration time, only available in experimental firmware bulds that support S-curve acceleration


### Order dependency

If this command refers to any axes other than X, Y and Z then it must be later in config.g than the M584 command that creates those additional axes.

### Examples


```
M201 X1000 Y1000 Z100 E2000

```


### Notes

Sets the acceleration that axes can do in mm/second^2 for print moves. For consistency with the rest of GCode movement this should be in mm/(minute^2), but that gives really silly numbers and one can get lost in all the zeros. So for this we use seconds.

To calculate the maximum acceleration values for an axis an online [Maximum Acceleration Calculator](https://wilriker.github.io/maximum-acceleration-calculator) can be used.

RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour. However, each extruder may have a different setting.

Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M201 Z100, not M201 Z100:100.

In experimental 3.6.x firmware builds that support S-curve acceleration, the T parameter (acceleration time) specifies the time in seconds to go from zero to maximum acceleration. The jerk (maximum rate of change of acceleration) for each axis or extruder is then computed as the maximum acceleration for that axis or extruder divided by this acceleration time parameter. If the acceleration time is set to zero (which is the default) then S-curve acceleration is not used. If it is configured nonzero but not all local axes and extruders use phase stepping then S-curve acceleration is not used.


---

## M566: Set allowable instantaneous speed change

### Parameters

- **Xnnn** Maximum instantaneous speed change of the X axis (mm/min)
- **Ynnn** Maximum instantaneous speed change of the Y axis
- **Znnn** Maximum instantaneous speed change of the Z axis
- **Ennn** Maximum instantaneous speed change of the extruder drives
- **Pn** Jerk policy (RepRapFirmware 2.03 and later)


### Examples


```
M566 X600 Y600 Z50 E600

```


### Description

Sets the maximum allowable speed change (sometimes called 'jerk speed') of each motor when changing direction.

The model files and GCode files used by repraps generally render circles and other curves shapes as a sequence of straight line segments. If the motors were not allowed any instantaneous speed change, they would have to come to a stop at the junction between each pair of line segments. By allowing a certain amount of instantaneous speed change, printing speed can be maintained when the angle between the two line segments is small enough.

**X** and **Y** parameter: If you set the X and Y values too low, then the printer will be slow at printing curves. If they are too high then the printer may be noisy when cornering and you may suffer ringing and other print artefacts, or even missed steps.

**Z** parameter: When mesh bed compensation is used, movement may be jerky if the allowed Z jerk is too low, because the Z speed needs to change abruptly as the head moves between squares in the mesh.

**E** parameter: Generally, extruder jerk can be set high, between 3000 and 6000 mm/min, otherwise it will limit the acceleration of other axes.

**P** parameter: The default jerk policy is 0, which replicates the behaviour of earlier versions of RRF (jerk is only applied between two printing moves, or between two travel moves, and only if they both involve XY movement or neither does). Changing the jerk policy to 1 allows jerk to be applied between any pair of moves.

### Notes

- In RRF 3.6.0 and later, jerk limits set using M566 (or the default jerk limits if M566 has never been used) can no longer be exceeded by a subsequent M205 command. In config.g you should use M566 to set the maximum jerk values that the machine can use reliably. You may also set default values using M205 if you want these to be lower. In previous firmware versions, M566 and M205 both adjusted a single set of jerk limits. In this release, RRF maintains separate machine jerk limits and jerk limits for the current job. M566 sets both jerk limits, whereas M205 sets only the jerk limits for the current job. The current job jerk limits are constrained to be no higher than the machine jerk limits. This allows slicers to use M205 to change the allowed jerk without exceeding machine limits.
- The minimum jerk speed supported in as at firmware version 2.02 is 0.1mm/sec.
- RepRapFirmware does not support individual motor settings where an axis has multiple motors connected to different stepper drivers. The first parameter specified will be used for all motors on the axis. You should use identical motors on any axis that has more than one motor to avoid unexpected behaviour.
- Example: If you have two motors on your Z axis, physically connected to Z and E0 stepper drivers, configured with M584 Z2:3, set M566 Z50, not M566 Z50:50


---

## M915: Configure motor stall detection

This sets the stall detection parameters and optionally the low-load current reduction parameters for TMC2660, TMC2130 or similar driver chips. Use either the P parameter to specify which driver number(s) you want to configure, or the axis names of the axes that those motors drive (the parameters will then be applied to all the drivers associated with any of those axes).
- RRF 3.4 and later
- RRF 3.3 and earlier

##### Parameters

- **Pnnn:nnn:...** Drive number(s) to configure
- **X,Y,Z,U,V,W,A,B,C** Axes to configure (alternative to using the P parameter)
- **Snnn** Stall detection threshold (see notes below)
- **Fn** Stall detection filter mode, 1 = filtered (one reading per 4 full steps), 0 = unfiltered (default, 1 reading per full step)
- **Hnnn** (optional) Minimum motor full steps per second for stall detection to be considered reliable, default 200
- **Tnnn** (optional) Coolstep control register, 16-bit unsigned integer
- **Rn** Action to take on detecting a stall from any of these drivers: 0 = no action (default), 1 = just log it, 2 or 3 = create an event (see notes).

##### Notes

- In RRF 3.6.0, a homing move that uses stall detect endstops will be cancelled and an error message generated if the movement speed is too low for stall detection to be definitely feasible (also if it is too high when using TMC2209 or TMC2240 drivers). There are small speed ranges that will be rejected by this release but may in practice have worked on some boards using previous firmware versions, so please test stall homing after upgrading.
- In RRF 3.4.0 thru 3.4.5, motor stalls don't generate events when not printing from SD card. RRF 3.4.6 and later do generate events when not printing from SD card.
- In RRF v3.4 and later, R2 and R3 both cause an event to be created when the driver stalls.
- To handle the event, RRF calls driver-stall.g passing the stalled local driver number in param.D and the CAN address of the board concerned in param.B.
- If file driver-stall.g is not found then the default action is to report it to the console and carry on.
- File rehome.g is no longer used.
- See the [events](https://docs.duet3d.com/User_manual/RepRapFirmware/Events) page for more detail.

##### Parameters

- **Pnnn:nnn:...** Drive number(s) to configure
- **X,Y,Z,U,V,W,A,B,C** Axes to configure (alternative to using the P parameter)
- **Snnn** Stall detection threshold (see notes below)
- **Fn** Stall detection filter mode, 1 = filtered (one reading per 4 full steps), 0 = unfiltered (default, 1 reading per full step)
- **Hnnn** (optional) Minimum motor full steps per second for stall detection to be considered reliable, default 200
- **Tnnn** (optional) Coolstep control register, 16-bit unsigned integer
- **Rn** Action to take on detecting a stall from any of these drivers: 0 = no action (default), 1 = just log it, 2 = pause print, 3 = pause print, execute /sys/rehome.g, and resume print.


### Order dependency

If this command refers to any axes other than X, Y and Z then it must appear later in config.g than the M584 command that creates those additional axes.

### Examples


```
M915 P0:2:3 S10 F1 R0
M915 X Y S5 R2

```


### Notes

- **S parameter** For most drivers, values range from -64 to +63. For TMC2209 drivers (Duet 3 Mini 5+, Duet 3 Toolboard 1LC) values range from -128 to +127. Lower values make stall detection more sensitive. Values below -10 are not recommended. S3 is a good starting point for many motors.
- **T parameter**

  - For all versions of RRF before 3.5.0, on TMC2160/5160/2240, the T parameter is not processed correctly, and might affect whether stalls are recognised instead of setting the coolstep parameters. This is fixed in RRF 3.5.0 and later.
  - Setting incorrect coolstep parameters could result in motor current being reduced too much, which could result in layer shifts. Users should only use the T parameter if they have read the driver datasheet and know what they are doing.

- If any of the S, F, T and R parameters are absent, the previous values for those parameters associated with the specified drivers will continue to be used.
- If all the parameters are absent, the existing settings for the specified drive(s) will be reported.
- See the Trinamic TMC2660 and TMC2130 datasheets for more information about the operation and limitations of motor stall detection.
- See here for more detailed information on [Stall Detection and Sensorless Homing](https://docs.duet3d.com/User_manual/Connecting_hardware/Sensors_stall_detection).
- In RRF 3.6.0 and later, when stall detect endstops are configured, G1 H1/H3/H4 moves are vetted to ensure that stall detection has been configured and suitable parameters and movement speed have been selected to make stall detection possible; otherwise the move is abandoned and an error message generated.
- M915 configures StallGuard, so it does not apply to an encoder endstop (M574 S5, after 3.7.0-beta.3), nor to a driver running in closed loop or assisted open loop mode, which cannot use StallGuard at all.


---

## M208: Set axis max travel

### Parameters

- **Snnn** 0 = set axis maximum (default), 1 = set axis minimum
- **Xnnn** X axis limit
- **Ynnn** Y axis limit
- **Znnn** Z axis limit


Alternative (from RepRapFirmware 2.02/1.23)

- **Xaaa:bbb** X axis minimum and maximum limit
- **Yaaa:bbb** Y axis minimum and maximum limit
- **Zaaa:bbb** Z axis minimum and maximum limit


### Order dependency

If this command refers to any axes other than X, Y and Z then it must be later in config.g than the M584 command that creates those additional axes.

### Examples


```
M208 X200 Y200 Z90 ; set axis maxima
M208 X-5 Y0 Z0 S1 ; set axis minima
M208 X-5:200 Y0:200 Z0:90 ; set axis minima and maxima

```


### Notes

- The values specified set the software limits for axis travel in the specified direction. The axis limits you set are also the positions assumed when an endstop is triggered.
- The min/max axis positions are +/- (2^31 - 1) microsteps. Position accuracy will start to suffer when the positions are outside approx. +/- 2^24 microsteps, because it is held and calculated as a 32-bit float. See also this note on [maximum length of moves](https://docs.duet3d.com/User_manual/Reference/Gcodes#maximum-length-of-moves) in the G1 Gcode entry.
- The M208 minimum Z value applies to deltas. The M208 XY min/max and Z max values don't.
- M208 axis limits for any axis whose values were found by probing or endstops will be saved to config-override.g using `M500`. Applies to Z max for LinearDelta and RotaryDelta if auto calibration was used, and to any axis limits probed using G1 H3 (or G1 S3 in RRF 2.x and earlier) moves.


---

## M574: Set endstop configuration
- M574 - RepRapFirmware 3
- M574 - RepRapFirmware 2.x and earlier

##### Parameters

- **Xnnn** Position of X endstop: 0 = none, 1 = low end, 2 = high end.
- **Ynnn** Position of Y endstop: 0 = none, 1 = low end, 2 = high end.
- **Znnn** Position of Z endstop: 0 = none, 1 = low end, 2 = high end.
- **Ennn** Extruder number (RRF 3.7.0-beta.3 and later). Binds a general purpose input port as the filament endstop for that extruder: the P parameter gives the number of an input port created by M950 J. P-1 reverts the extruder to motor stall detection (the default). Cannot be combined with axis parameters in the same command.
- **P"pin_name"** Defines the pin name(s) that the endstop(s) for the specified axis are connected to, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Needed when S=1. May need ! before pin name to invert signal, or ^ to enable the pullup resistor, for example on the Duet 2 expansion header if using the pins directly without a duex5.
- **Snnn** 1 = switch-type (eg microswitch) endstop input, 2 = Z probe (when used to home an axis other than Z), 3 = single motor load detection, 4 = multiple motor load detection, 5 = encoder position error (see Notes).
- **Knnn** Optional Z probe number (3.5 or later, only for S2, defaults to 0)

##### Order dependency

This command must be later in config.g than the M584 command that creates additional axes, or axes that have multiple motors and endstops. An M574 command with the E parameter must be later in config.g than the M950 J command that creates the input port it refers to.

##### Examples

```
M574 X1 S1 P"io1.in"  ; configure active high endstop switch for low end on X (Duet 3)
M574 Y2 S1 P"!io2.in" ; configure active low endstop switch for high end on Y (Duet 3)
M574 Z1 S1 P"e0stop"  ; configure active high endstop switch for low end on Z (Duet 2)
M574 U1 S2            ; configure Z-probe endstop for low end on U
M574 V2 S3            ; configure sensorless endstop for high end on V
M574 E0 P2            ; use GP input 2 (created by M950 J2) as the filament endstop for extruder 0
M574 E0 P-1           ; revert extruder 0 to motor stall detection

```

To use two Z motors using independent homing switches, declare two Z motors in M584, then declare two pins for Z endstops in a single M574 command. Example


```
M584 X0 Y1 Z2:3 E4
M574 Z1 S1 P"io2.in+io3.in" ; Z axis with two motors, individual min endstops, active high

```

The order of endstop switch pin names in M574 must match the order of Z motor driver numbers in M584. When homing Z, RRF3 homes the motors of the axis at the same time, independently to their defined endstops. See [Axis levelling using endstops](https://docs.duet3d.com/User_manual/Connecting_hardware/Z_probe_auto_levelling#axis-levelling-using-endstops).

##### Notes

- In RRF3, the M574 command allows for more flexibility than in RRF2. This includes supporting axes defined with multiple motors and multiple endstops (one per motor), use of non-default endstop inputs, and re-assigning endstop inputs.
- Use a separate M574 command for each axis. For historical reasons, RRF currently allows multiple endstops to be declared using M574 in some situations, but this facility may be withdrawn in future versions.
- For endstop types other than stall detecton, parameter **P** gives the pin name(s) for the endstop(s) for the specified axis. If the number of pins matches the number of motors assigned to that axis, motors will be stopped individually when their endstop switches trigger.
- For active low endstops, use type S1 and invert the input by prefixing the pin name with '!', for example `M574 X1 S1 P"!xstop"`. Invert the input when using an NPN output normally-open inductive or capacitive sensor, or using a normally-open switch (not recommended, use a normally-closed switch instead).
- The S2 option of M574 is intended for use only when axes other than Z are using the Z probe for homing. The only printers known to do this are the RepRapPro Ormerod, Huxley Duo, and Mendel Tricolour machines. When using the Z probe to home Z, M574 Z has no bearing on the probe setup or usage.
- A Z probe and a Z endstop (e.g. a switch) can both be configured at the same time. G30 commands will use the probe setup with M558, and G1 H1 Z moves use the endstop configured with M574 Z.
- Endstop type S4 means use motor stall detection (like S3) but if there are multiple motors dedicated to a single axis, stop each one individually as it stalls. S3 means use motor stall detection but if there are multiple motors dedicated to a single axis, stop all those motors when the first one stalls.
- Endstop type S5 (after 3.7.0-beta.3) homes against the encoder of a driver on a CAN-connected board, instead of against the driver's StallGuard feature. It triggers when the motor falls behind the commanded position by the first value of the M569.1 E parameter, measured in full motor steps. Because it compares the distance commanded with the distance the encoder measured, it works whether the driver is in open loop, closed loop or assisted open loop mode, it needs no tuning, M915 does not apply to it, and there is no minimum speed for the homing move. All motors of the axis are stopped when the first one triggers.
- Pull up resistors on Duet 2/Duex5 inputs should be configured for connecting a digital inputs (like a switch, BLtouch, etc) only on inputs not labelled "n"Stop (xstop, ystop etc).
- When a filament endstop is bound to an extruder (E and P parameters, RRF 3.7.0-beta.3 and later), a G1 H1 extruder-only move stops when the input reads active during positive extrusion, or inactive during negative extrusion, so the same input terminates both filament loading and unloading moves. Extruders without a bound input use motor stall detection as before. `M574 E0` without P reports the current binding, and M574 without parameters lists all of them.
- To un-configure an endstop and free up any associated input pins, set the endstop position of that axis to 'none'. For example, `M574 X0` will delete the X endstop and free up any inputs that it was using.

##### Parameters

- **Xnnn** Position of X endstop: 0 = none, 1 = low end, 2 = high end.
- **Ynnn** Position of Y endstop: 0 = none, 1 = low end, 2 = high end.
- **Znnn** Position of Z endstop: 0 = none, 1 = low end, 2 = high end.
- **E** Select extruder endstops to define active high or low (RepRapFirmware 1.16 and earlier only)
- **Snnn** Endstop type: 0 = active low endstop input, 1 = active high endstop input, 2 = Z probe, 3 = motor load detection

##### Order dependency

If this command refers to any axes other than X, Y and Z then it must be later in config.g than the M584 command that creates those additional axes.

##### Examples

```
M574 X1 Y2 Z0 S1 ; X endstop at low end, Y endstop at high end, no Z endstop, all active high

```

##### Notes

This defines the type of endstop switch or opto sensor that the printer has for each axis: 0 = none, 1 = low end, 2 = high end. The optional S parameter defines whether the endstop input is active high (S1, the default) or low (S0). A normally-closed endstop switch wired in the usual way produces an active high output (S1).

The S2 and S3 options are supported in firmware 1.20 and later.

This is intended for use with boards that provide a single endstop input for each axis that may be used for either a high or a low end endstop, such as the Duet. On delta printers, the XYZ parameters refer to the towers and the endstops should normally all be high end (i.e. at the top of the towers).

If you have more than one homing switch for an axis because you want to home multiple motors driving that axis individually, you will need to split them into separate axes during homing, and home those axes together. See [Axis levelling using endstops](https://docs.duet3d.com/User_manual/Connecting_hardware/Z_probe_auto_levelling#axis-levelling-using-endstops).

In RepRapFirmware 1.16 and earlier, the M574 command with E parameter was used to specify whether a Z probe connected to the E0 endstop input produces an active high (S1) or active low (S0) output. In RepRapFirmware 1.17 and later, use the I parameter of the M558 command instead.


---

## M950: Create heater, fan, spindle, LED strip or GPIO/servo pin

*Supported in RepRapFirmware 3.*

M950 is used to create heaters, fans, GPIO ports, spindles (3.3 and later) and LED strips (3.5 and later), and to assign pins to them. Each M950 command assigns a pin or pins to a single device. Every M950 command must have **exactly one** of the H, F, J, P, S, D (for Duet 3 MB6HC only) or E (in RRF 3.5 and later) parameters.

If a M950 command has C and/or Q parameters, then the pin allocation and/or frequency will be configured accordingly. Otherwise, the current configuration will be reported.
- RRF 3.5 and later
- RRF 3.4
- RRF 3.3
- RRF 3.0

##### Parameters

- **Hnn** Heater number
- **Fnn** Fan number
- **Jnn** Input pin number. In RRF 3.7.0-beta.3 and later the C parameter may name a virtual input fed by a filament monitor instead of a physical pin. The name is "fmN.switch" or "fmN.motion" where N is the number of the extruder the monitor is configured for (the D parameter of M591): "fm0.switch" follows the filament present indication of the filament monitor of extruder 0, and "fm0.motion" reads active while that monitor has detected filament movement within the last 0.5 seconds. "probeN" follows the triggered state of Z probe N, for example to terminate filament loading moves (see the E parameter of M574) when a load cell probe senses the filament pressing against the nozzle. A leading '!' inverts the state.
- **Pnn** or **Snn** Output/servo pin number. Each P and/or S number needs to be unique, eg P1, P2, S3 P4, S5 etc. Servo pins are GpOut pins with a different default PWM frequency.
- **Rnn** Spindle number
- **Dn** (Duet 3 MB6HC only) SD slot number. The only value supported is 1.
- **En** LED strip number
- **C"name"** Pin name(s) and optional inversion status, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 500 for GpOut pins, 250 for fans and heaters. Max value for heaters 1000, to avoid overheating the mosfets. For LED strips (supported in RRF 3.5.0 and later only) this is the LED clock frequency.
- **Tn** When creating a heater: temperature sensor number, required (see [M308](https://docs.duet3d.com/User_manual/Reference/Gcodes/M308)). When creating a LED strip (supported in RRF 3.5.0 and later only): LED type (optional): 0 = DotStar, 1 = RGB Neopixel (default), 2 = RGBW Neopixel. DotStar LEDs can normally be assigned only to an output intended for them. When creating a spindle, type of spindle control (RRF 3.6.0 and later): T0 (default) = enable/direction inputs, T1 = forward/reverse inputs.
- **Bn** When creating a heater: optional ambient temperature sensor number (supported in RRF 3.7.0-beta.2 and later). For example, when creating a tool heater that operates in a heated chamber, this would be the chamber temperature sensor.
- **Lbbb** or **Laaa:bbb** (optional, for spindles only) RPM values that are achieved at zero PWM (optional) and at maximum PWM.
- **Kaaa(:bbb[:ccc])** (optional, RRF 3.5 and later) For spindles, these are the PWM values (0..1) for spindle control (max [aaa] - or - min, max [aaa:bbb] - or - min, max, idle [aaa:bbb:ccc]).
- **Knn** (optional, RRF 3.5 and later) For fans, number of pulses output by the tacho per revolution of the fan, default: 2. Valid range: 0.5-20, 0.5-200 in RRF 3.6.0 and later.
- **Kn** (optional, RRF 3.5.3 and later) For LEDs, the colour order for Dotstar LED strips: 0 (BGR), 1 (BRG), 2 (RGB), 3 (RBG), 4 (GBR), 5 (GRB)
- **Unnn** (optional, RRF 3.5.0 and later, for LED strips only) The maximum number of LEDs in the strip. Default 60, larger values use more memory.

1 Check the individual hardware pages, some IO pins have permanent pullups.

##### Parameters

- **Hnn** Heater number
- **Fnn** Fan number
- **Jnn** Input pin number
- **Pnn** or **Snn** Output/servo pin number. Each P and/or S number needs to be unique, eg P1, P2, S3 P4, S5 etc. Servo pins are GpOut pins with a different default PWM frequency.
- **Rnn** Spindle number
- **Dn** (Duet 3 MB6HC only) SD slot number. The only value supported is 1.
- **C"name"** Pin name(s) and optional inversion status, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 500 for GpOut pins, 250 for fans and heaters. Max value for heaters 1000, to avoid overheating the mosfets.
- **Tn** When creating a heater: temperature sensor number, required (see [M308](https://docs.duet3d.com/User_manual/Reference/Gcodes/M308)).
- **Lbbb** or **Laaa:bbb** (optional, for spindles only) RPM values that are achieved at zero PWM (optional) and at maximum PWM.

1 Check the individual hardware pages, some IO pins have permanent pullups.

##### Parameters

- **Hnn** Heater number
- **Fnn** Fan number
- **Jnn** Input pin number
- **Pnn** or **Snn** Output/servo pin number. Each P and/or S number needs to be unique, eg P1, P2, S3 P4, S5 etc. Servo pins are GpOut pins with a different default PWM frequency.
- **Rnn** Spindle number
- **C"name"** Pin name(s) and optional inversion status, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 500 for GpOut pins, 250 for fans and heaters. Max value for heaters 1000, to avoid overheating the mosfets.
- **Tn** When creating a heater: temperature sensor number, required (see [M308](https://docs.duet3d.com/User_manual/Reference/Gcodes/M308)).
- **Lbbb** or **Laaa:bbb** (optional, for spindles only) RPM values that are achieved at zero PWM (optional) and at maximum PWM.

1 Check the individual hardware pages, some IO pins have permanent pullups.

##### Parameters

- **Hnn** Heater number
- **Fnn** Fan number
- **Jnn** Input pin number (RRF 3.01 and later only)
- **Pnn** or **Snn** Output/servo pin number. Each P and/or S number needs to be unique, eg P1, P2, S3 P4, S5 etc. Servo pins are GpOut pins with a different default PWM frequency.
- **C"name"** Pin name(s) and optional inversion status, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 500 for GpOut pins, 250 for fans and heaters. Max value for heaters 1000, to avoid overheating the mosfets.
- **Tn** When creating a heater: temperature sensor number, required (see [M308](https://docs.duet3d.com/User_manual/Reference/Gcodes/M308)).

1 Check the individual hardware pages, some IO pins have permanent pullups.

### Order dependency

- When M950 is used to create a heater, the M950 command must come later in config.g than the M308 command that creates the sensor referred to in the T parameter
- M950 must come before any commands that refer to the device being created. For example, when M950 is used to create a heater, it must be earlier than the M307 command used to set the heater parameters, and earlier than any M563 commands that create tools that use that heater. When M950 is used to create a fan, it must come earlier than any M106 commands relating to that fan. When M950 is used to create an LED strip, it must come earlier than any M150 commands that use that strip.


### Configuration examples and notes
- Heaters
- Fans
- Inputs
- Outputs and servos
- Spindles
- SD card slot
- LED strips

```
M950 H1 C"out1" Q100 T1        ; create heater 1
M950 H2 C"nil"                 ; disable heater 2 and free up the associated pin
M950 H1 C"3.out0+out2" Q100 T1 ; create heater 1 using ports OUT0 and OUT2 on CAN board 3 (RRF 3.4 or later)

```


- **Hnn** Heater number
- **C"name"** Pin name(s) and optional inversion status. Pin name "nil" frees up the pin.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 250 for heaters. Max value for heaters 1000, to avoid overheating the mosfets.
- **Tn** When creating a heater, temperature sensor number, required (see [M308](https://docs.duet3d.com/User_manual/Reference/Gcodes/M308)).

##### Notes

In RRF 3.4 and later, when using M950 to create a heater, multiple port names can be provided, separated by the '+' sign. The maximum number of ports that may be used depends on the board. **Any CAN address at the start of the port name string applies to all the port names.**

```
M950 F3 C"heater2" Q100           ; Fan 3 is connected to heater 2 pin, PWM at 100Hz
M950 F2 C"!fan2+^exp.pb6"         ; Fan 2 uses the Fan2 output, but we are using a PWM fan so the output needs to be inverted, also we are using PB6 as a tacho input with pullup resistor enabled
M950 F5 C"!out4+out4.tach" Q450   ; Create Fan 5 on the mainboard on OUT4 with a tacho input
M950 F0 C"!1.out3+out3.tach" Q450 ; Create Fan 0 on expansion board 1, output OUT3 with a tacho input

```


- **Fnn** Fan number
- **C"name"** Pin name(s) and optional inversion status. Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 250 for fans.
- **Knn** (optional, RRF 3.5 and later) For fans, number of pulses output by the tacho per revolution of the fan, default: 2. Valid range: 0.5-20, 0.5-200 in RRF 3.6.0 and later.

##### Notes

When using M950 to create a fan, the port name string may be either a single port, or two ports separated by the '+' sign. The second port is used to read the fan tacho. **Any CAN address at the start of the port name string applies to both port names.**

```
M950 J1 C"!^e1stop"            ; Input 1 uses e1Stop pin, inverted, pullup enabled

```


- **Jnn** Input pin number
- **C"name"** Pin name(s) and optional inversion status. Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.


```
M950 P0 C"exp.heater3"         ; create output/servo port 0 attached to heater 3 pin on expansion connector

```


- **Pnn** or **Snn** Output/servo pin number. Each P and/or S number needs to be unique, eg P1, P2, S3 P4, S5 etc. Servo pins are GpOut pins with a different default PWM frequency.
- **C"name"** Pin name(s) and optional inversion status, see [Pin Names](https://docs.duet3d.com/User_manual/RepRapFirmware/Migration_RRF2_to_RRF3#pin-names). Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535, default: 500 for GpOut pins.

Supported in RRF 3.3 and later.

```
M950 R0 C"!exp.heater3" L12000 ; Spindle 0 uses exp.heater3 as RPM pin and has a max RPM of 12000

```


- **Rnn** Spindle number
- **C"name"** Pin name(s) and optional inversion status. Pin name "nil" frees up the pin. A leading '!' character inverts the input or output. A leading '^' character enables the pullup resistor1. The '^' and '!' characters may be placed in either order.
- **Qnn** (optional) PWM frequency in Hz. Valid range: 0-65535.
- **Lbbb** or **Laaa:bbb** (optional) RPM values that are achieved at zero PWM (optional) and at maximum PWM.
- **Kaaa(:bbb[:ccc])** (optional, RRF 3.5 and later) PWM values (0..1) for spindle control (max [aaa] - or - min, max [aaa:bbb] - or - min, max, idle [aaa:bbb:ccc])
- **Tn** (RRF 3.6.0 and later) Specifies type of spindle control: T0 (default) = enable/direction inputs, T1 = forward/reverse inputs.

##### Notes

- When using M950 to create a spindle (with default T0 in RRF 3.6.0 and later), use the following format:

```
M950 R0 C"pwm_pin + on/off_pin + forward/reverse_pin" Qfff Laa:bb

```

- When using M950 to create a spindle, with T1 in RRF 3.6.0 and later, use the following format:

```
M950 R0 C"pwm_pin + forward_pin + reverse_pin" T1 Qfff Laa:bb

```

- C can have 1, 2 or 3 pins.

  - The first pin defines a pwm-capable pin to set the spindle speed.
  - If a second pin is defined it is used as spindle on/off.
  - If a third pin is defined it is used as spindle forward/reverse.

- **Qfff** is the PWM frequency as usual
- **Laa:bb** sets the RPM range as "aa" to "bb". "Lbb" just sets the max RPM to "bb". Default RPM values are 60 min 10000 max
- In RRF 3.6.0 and later, sending `M950 R#` were R# is the spindle number, reports on that spindle.


```
M950 D1 C"spi.cs0+spi.cs2"     ; on Duet 3 MB6HC support external SD card using pins spi.cs0 and spi.cs2 for the CS and Card Detect pins respectively (RRF 3.4 and later)

```

##### Notes

Duet 3 MB6HC only, configures the SD slot number. The only value supported is 1. (RRF 3.4 and later)

Supported in RRF 3.5.0 and later.

```
M950 E0 C"led" T2              ; create a RGBW Neopixel LED strip on the LED port (RRF 3.5 and later)

```


- **En** LED strip number
- **C"name"** Pin name
- **Qnn** (optional) LED clock frequency, default 3000000Hz.
- **Tn** (optional) LED type: 0 = DotStar, 1 = RGB Neopixel (default), 2 = RGBW Neopixel. DotStar LEDs can normally be assigned only to an output intended for them.
- **Kn** (optional, RRF 3.5.3 and later) For LEDs, the colour order for Dotstar LED strips: 0 (BGR), 1 (BRG), 2 (RGB), 3 (RBG), 4 (GBR), 5 (GRB)
- **Unnn** (optional) The maximum number of LEDs in the strip. Default 60, larger values use more memory.

##### Notes

- The **Qnn** parameter sets the LED clock frequency. This is 4x the bit rate. Most datasheets for LEDs (at least SK6812 and WS2812B based LEDs) suggest a maximum data rate of 800Kbps, so 800000 * 4 = 3200000. The default of 3000000 appears to work well with most LEDs.
- The **Unn** parameter defines the maximum number of LEDs in a strip, and the default is 60. It can be increased using the M950 U parameter, subject to
 (a) available RAM and
 (b) on the 6HC and 6XD there is an additional limit because the DMA buffer has to be in non-cached memory. For 6HC and 6XD the max LEDs for a strip connected to the dedicated LED port is currently 240 Neopixel RGBW or 320 RGB. It might reduce in future.
- When configuring a LED strip on a tool board or 1XD (which have very little free RAM), or configuring multiple LED strips, using a lower U parameter (ie set U to the number of LEDs) is advised to save RAM.


---

## M563: Define or remove a tool

### Parameters

- **Pnnn** Tool number (0 to 49 in RRF 3.x)
- **S"name"** Tool name (optional)
- **Dnnn** Extruder drive(s)
- **Hnnn** Heater(s)
- **Fnnn** Fan number(s) to use as print cooling fans for this tool (RepRapFirmware 1.16 and later)
- **Xnnn** Axis or axes to map X movement to (RepRapFirmware 1.16 and later)
- **Ynnn** Axis or axes to map Y movement to (RepRapFirmware 1.19 and later)
- **Znnn** Axis or axes to map Z movement to (RepRapFirmware 3.5 and later)
- **Lnnn** Drive to use for filament mapping. By default RRF will use the first and only extruder drive if this parameter is not specified (supported by RRF >= 2.02)
- **Rnn** Spindle number (RepRapFirmware 3.3 and later)


### Examples


```
M563 P0 D0:2:3 H1:3 ; create a tool using extruder drives 0, 2 and 3 and heaters 1 and 3
M563 P1 D1 H2 X3 ; create a tool using extruder drive 1 and heater 2 with X movement mapped to the U axis
M563 P2 D0:1 H1:2 X0:3 F0:2 ; create a tool using extruder drives 0 and 1, heaters 1 and 2, with X movement mapped to both X and U axes and fan 0 mapped to fans 0 and 2
M563 P3 D0 H1 S"Chocolate extruder" ; create a named tool using extruder drive 0 and heater 1
M563 P1 D-1 H-1 ; Delete tool 1

```


### Description

Tools are usually (though not necessarily) extruders. Normally an M563 command to define a tool is immediately followed by a G10 command to set the tool's offsets and temperatures (temperatures can also be set with M568).

**P** The 'P' field specifies the tool number. In RRF3, tool numbers may be between 0 and 49. In RRF2 they may be between 0 and 65535. If you use the M563 command with a P value for a tool that has already been defined, and you provide any other parameters, that tool is redefined using the new values you provide.

**D** The 'D' field specifies the drive(s) used by the tool - in the first example drives 0, 2 and 3. The 'D' field number corresponds to the 'E' parameter defined in the M584 command. '0' means first 'E' driver in M584 and so on. Drive 0 is the first drive in the machine after the movement drives (usually X, Y and Z). If there is no 'D' field the tool has no drives. Tools are driven using multiple values in the 'E' field of G1 commands, each controlling the corresponding drive in the 'D' field above, as follows:



```
G1 X90.6 Y13.8 E2.24:2.24:15.89
G1 X70.6 E0:0:42.4

```


The first line moves straight to the point (90.6, 13.8) extruding a total of 2.24mm of filament from both drives 0 and 2 and 15.98mm of filament from drive 3. The second line moves back 20mm in X extruding 42.4mm of filament from drive 3.

Alternatively, if the slicer does not support generating G1 commands with multiple values for the extrusion amount, the M567 command can be used to define a tool mix ratio.

**H** The 'H' field specifies the tool's heaters - in the first example heaters 1 and 3. Heater 0 is usually the hot bed (if any) so the first extruder heater is usually 1. If there is no H field the tool has no heaters. It is permissible for different tools to share some (or all) of their drives and heaters. So, for example, you can define two tools with identical hardware, but that just operate at different temperatures.

**F** The print cooling fan number(s) of the tool, default 0. Use this parameter if you are not using fan 0 as the print cooling fan for the tool you are defining. **You do not need to, and must not, list the fan numbers of thermostatic hot end fans here**. To use more than one print cooling fan for the tool, the definition would typically look like this:



```
M563 P0 D0 H1 F0:1 ; tool 0 uses extruder drive 0 and heater 1. Fan 0 and Fan 1 are use by tool 0 as print cooling fans.

```


**R** The spindle number mapped to this tool. (RRF >= 3.3)



```
M563 P0 R0 ; assign spindle 0 to tool 0

```


**X, Y, Z** The X, Y and Z mapping options are used to create tools on machines with multiple independent X, Y and/or Z carriages. The additional carriages are set up as axes U, V etc. (see M584) and the X/Y/Z mapping option in M563 defines which carriage or carriages are used. Axes are mapped in the order XYZUVWABC, where X=0, Y=1, Z=2, U=3 etc, not by driver number.

**S** As shown in the example above the S parameter can be used to give a tool a name.

RepRapFirmware maps the loaded filament on a per-extruder basis so if you have a mixing tool (one with more than one extruder), the **L** parameter tells the web interface which filament to display. If there is more than one extruder and the L parameter is omitted, no filament is displayed at all.

### Notes

- In **RepRapFirmware 3.x**, in order to avoid the serialised object model getting very large, the P parameter (tool number) may not exceed 49.
- M563 with just a P parameter just reports the existing configuration of the tool. Therefore, if you want to create a tool with no heaters and no extruders, you must provide at least one other parameter. For example, you can use the S parameter to name the tool.
- RepRapFirmware allows the deletion of existing tools if M563 is called in this way:


```
M563 P1 D-1 H-1

```

- RepRapFirmware 3.0 and earlier supports an additional form of the M563 command. The command:


```
M563 S1

```
 means add 1 (the value of the S parameter) to all tool numbers found in the remainder of the current input stream (e.g. the current file if the command is read from a file on the SD card), or until a new M563 command of this form is executed. The purpose of this is to provide compatibility between systems in which tool numbers start at 1, and programs such as slic3r that assume tools are numbered from zero. This functionality has been deprecated and removed from RRF 3.1.0 and later.


---

## M453: Select CNC Device Mode

Supported by RRF 1.20 and later.
- M453 in RepRapFirmware 3.3 and later
- M453 in RepRapFirmware 3.2
- M453 in RepRapFirmware 3.0 and 3.1.x
- M453 in RepRapFirmware 1.x and 2.x

Switches to CNC mode. All other parameters have been removed and moved into M950.

##### Parameters

none

##### Examples

```
; Old code
M453 S0 T1 C"!exp.heater3" R12000 ; Assign tool 1 to spindle index 0, with PWM pin on heater 3 and 12000 RPM achieved at full PWM

; New code
M950 R0 C"!exp.heater3" L12000 ; Create spindle index 0, with PWM pin on heater 3 and 12000 RPM achieved at full PWM
M563 P1 S"Spindle 1" R0 ; Create tool 1 with spindle 0 and call it "Spindle 1"
M453

```


```
; Old code
M453 S0 T1 C"exp.heater3+exp.heater4+exp.heater5" Q100 ; spindle PWM on heater 3 pin, on/off on heater 4, reverse/forward on heater 5, PWM frequency 100Hz

; New code
M950 R0 C"exp.heater3+exp.heater4+exp.heater5" Q100
M563 P1 S"Spindle 1" R0 ; Create tool 1 with spindle 0 and call it "Spindle 1"
M453

```

##### Parameters

- **Snnn** (optional) Spindle index, defaults to 0. Duet 2 supports 4 spindles max
- **C"aaa+bbb+ccc"** Names of the ports used to drive the spindle motor. "aaa" is the PWM port used to control the speed. "bbb" (optional) is the digital port used to turn the spindle motor on. "ccc" (optional) is the name of the port used to command reverse instead of forward spindle rotation.
- **Rbbb** or **Raaa:bbb** (optional) RPM values that are achieved at zero PWM and at maximum RPM. Used to convert the S parameter in M3 and M4 commands to a PWM value.
- **Qnnn** (optional) The PWM frequency to use
- **Tnnn** (optional) Assign spindle to a tool allowing better control in DWC

##### Examples

```
M453 C"exp.heater3+exp.heater4+exp.heater5" Q100 T1 ; spindle PWM on heater 3 pin, on/off on heater 4, reverse/forward on heater 5, PWM frequency 100Hz

```

##### Parameters

- **Snnn** (optional) Spindle index, defaults to 0. Duet 2 supports 4 spindles max
- **C"fff+rrr"** Names of the ports used to drive the spindle motor in clockwise and counterclockwise directions. Omit the "+rrr" part if the spindle turns clockwise only.
- **Rnnn** Spindle RPM that is achieved at full PWM. Used to convert the S parameter in M3 and M4 commands to a PWM value.
- **Fnnn** (optional) The PWM frequency to use
- **Tnnn** (optional) Assign spindle to a tool allowing better control in DWC

##### Examples

```
M453 C"exp.heater3+exp.heater4" F100 T1 ; spindle forward/reverse on heater 3&4 pins, PWM frequency 100Hz

```

##### Parameters

- **Snnn** (optional) Spindle index, defaults to 0. Duet 2 supports 4 spindles max
- **Pfff:rrr** Logical pin numbers used to drive the spindle motor in clockwise and counterclockwise directions. Omit the ":rrr" part if the spindle turns clockwise only. (Not supported in RRF3, see notes)
- **In** Invert (I1) or don't invert (I0, default) the output polarity. (Not supported in RRF3, see notes)
- **Rnnn** Spindle RPM that is achieved at full PWM. Used to convert the S parameter in M3 and M4 commands to a PWM value.
- **Fnnn** (optional) The PWM frequency to use
- **Tnnn** (optional) Assign spindle to a tool allowing better control in DWC

##### Examples

```
M453 P2 R5000 ; switch to CNC mode using heater 2 (E1 heater) pins to control the spindle motor

```

Logical pin numbers for the P parameters are as defined for the M42 and M208 commands. If you wish to assign a heater or fan output to control the spindle motor as in the above example, you must first disable the corresponding heater (see M307) or fan (see M106).

### Notes

- Switches to CNC mode. In this mode M3/M4/M5 control the pins defined for the milling device. By default, no output is assigned to a spindle motor, so it must be configured.
- In CNC mode, it is valid in a Gcode file to send G0 or G1 on one line, and then just send co-ordinates on the following lines.
- In CNC mode, comments can be enclosed in a **single** pair of parentheses, e.g. `(comment)`. Comments cannot include double or nested parentheses, e.g. `(comment (a bit more comment))`, and they must start and end on the same line. This complies with NIST Gcode interpreter guidelines. e.g. `G28 (here come the axes to be homed) X Y`
- When using [Gcode meta commands](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands), sub-expressions may be enclosed in { } or in ( ). However, standard CNC GCode uses ( ) to enclose comments (see note above). So in CNC mode, RepRapFirmware treats ( ) as enclosing subexpressions when they appear inside { } and as enclosing comments when they do not. Therefore, when RepRapFirmware is running in CNC mode, any use of ( ) to enclose a subexpression or function parameter list must be within an expression enclosed in { }.
- See also [Configuring RepRapFirmware for a CNC machine](https://docs.duet3d.com/User_manual/Machine_configuration/Configuration_CNC).


---

## M42: Switch I/O pin
- RepRapFirmware 3.x
- RepRapFirmware 2.x

##### Parameters

- **Pnnn** GPIO port number (set by M950)
- **Snnn** Pin value

##### Examples

```
M950 P0 C"exp.heater3" Q500  ; allocate GPIO port 0 to heater3 on expansion connector, 500Hz
...
M42 P0 S0.5  ; set 50% PWM on GPIO port 0

```

##### Description

M42 switches a general purpose I/O pin which is defined by M950. Use M42 Px Sy to set pin x to value y. The S field may be in the range 0.0-1.0 or >1.0-255. 0 is off in both cases.

##### Notes

- Before you can use M42 you must create a GPIO port using M950. Then in the M42 command, the P parameter is the GPIO port number.
- The F (PWM frequency) and I (invert PWM) parameters are no longer supported in M42. Instead, use the Q (PWM frequency) and C (pin name, with ! to invert) parameters in M950 when you create the GPIO port.
- No GPIO ports are allocated by default.
- See [Firmware configuration limits](https://docs.duet3d.com/User_manual/RepRapFirmware/RepRapFirmware_overview#firmware-configuration-limits) for the number of inputs and outputs each Duet board and firmware version supports.

##### Parameters

- **Pnnn** Logical pin number
- **Snnn** Pin value
- **Fnnn** PWM frequency (optional)
- **Innn** Invert PWM (optional). I0 (no inversion) is default, I1 inverts.

##### Examples

```
M42 P3 I1 S0.5 F500  ; set Heater 3 pin to 50% PWM at 500Hz, inverted

```

M42 switches a general purpose I/O pin. Use M42 Px Sy to set pin x to value y. The S field may be in the range 0.0-1.0 or >1.0-255. 0 is off in both cases.

##### Notes

In RRF 2.x, the 'P' pin number reference is an internal firmware reference named "digital pin" which It maps on different connector pins depending the hardware. See [Controlling unused IO pins](https://docs.duet3d.com/User_manual/Connecting_hardware/IO_GPIO) for all the unused pin mappings in RRF 2.x.

For Duet 0.8.5 and 0.6, along with pre 1.16 versions of RepRapFirmware, see the [RepRap GCode dictionary M42 entry](http://reprap.org/wiki/G-code#M42:_Switch_I.2FO_pin).

**See also**

[M280](https://docs.duet3d.com/User_manual/Reference/Gcodes/M280), [M950](https://docs.duet3d.com/User_manual/Reference/Gcodes/M950)


---

## M552: Set IP address, enable/disable network interface
- WiFi interfaces (Duet 2/3 WiFi)
- Ethernet interfaces (Duet 2/3 Ethernet and 06/085)

##### Parameters

- **Innn** (Optional) Number of the network interface to manage (defaults to 0). Only needed if the board supports more than one network interface, such as Duet 3 MB6HC revision 1.02 or later with the optional WiFi interface. On that board, I0 is the Ethernet interface and I1 is the WiFi interface.
- **P"ssid"** (optional, RepRapFirmware 1.20 and later) SSID of network to connect to. The SSID and password must already have been registered using M587. If this parameter is not present, the WiFi will try to connect to the strongest network that is broadcasting its SSID and whose SSID has been registered using M587.
- **Snnn** 0 = disable networking, 1 = enable networking as a client, 2 = enable networking as an access point , -1 = disable WiFi module

##### Examples

```
M552 S1 P"MyNetwork"

```

Enables networking as a client, and joins the network with the SSID 'MyNetwork', using the parameters (password, IP/gateway address, netmask) configured in [M587](https://docs.duet3d.com/User_manual/Reference/Gcodes/M587).

##### Notes

- Also works with the WiFi interface on an attached SBC. See M587 for configuration limitation.
- On Duet boards with WiFi interfaces running firmware 1.19 and later, the IP address is set in the M587 command when you configure the access point details.
- In SBC mode, sending this command makes a persistent change. It does not need to be added to dsf-config.g. It should NOT be included in config.g.

##### Parameters

- **Innn** (Optional) Number of the network interface to manage (defaults to 0).
- **Pnnn** IP address, 0.0.0.0 means acquire an IP address using DHCP
- **Snnn** 0 = disable networking, 1 = enable networking
- **Rnnn** (Optional) HTTP port, default 80 (Deprecated, RepRapFirmware 1.17 and earlier only)

##### Examples

**Duet 2 Ethernet:**


```
M552 S1 P192.168.1.14

```

Sets the IP address of the machine to (in this case) 192.168.1.14. If the S parameter is not present then the enable/disable state of the network interface is not changed.

**Duet 3 in SBC mode:**

- M552 I1 S1 P0.0.0.0 ; set the second interface on the SBC to use DHCP and enable it.

The I1 setting here specifies the second network interface on the SBC. This uses the [DuetPi Management Plugin](https://github.com/Duet3D/DuetSoftwareFramework/tree/v3.3-dev/src/DuetPiManagementPlugin#readme) (installed by default from RRF 3.3 onwards) to set the address on the SBC. To determine which interface is which on the SBC the object model explorer can be used to see the current settings of each interface.

##### Notes

- M552 with no parameters reports the current network state and IP address.
- In firmware 1.18 and later the HTTP port address is set using the M586 command, so the R parameter of this command is no longer supported.
- In SBC mode, sending this command makes a persistent change. It does not need to be added to dsf-config.g. It should NOT be included in config.g.


---

## M586: Configure network protocols

### Parameters

- **Inn** Interface number (RRF 3 and later, defaults to 0, only supported in standalone mode)
- **Pnn** Protocol: 0 = HTTP or HTTPS, 1 = FTP or SFTP, 2 = Telnet or SSH (which of the two choices depends on the T parameter), 3 = multicast discovery (OEM-specific), 4 = MQTT (see M586.4 below)
- **Snn** 0 = disable this protocol, 1 = enable this protocol
- **Hnn** Remote server IP address (only applicable for MQTT, see also M586.4)
- **Rnn** TCP port number to use for the specified protocol. Ignored unless S = 1. If this parameter is not provided then the default port for that protocol and TLS setting is used. When S=0 the default port numbers are 80, 21 and 23 respectively.
- **Tnn** 0 = don't use TLS, 1 = use TLS. Ignored unless S = 1. If this parameter is not provided, then TLS will be used if the firmware supports it and a security certificate has been configured. If T1 is given but the firmware does not support TLS or no certificate is available, then the protocol will not be enabled and an error message will be returned.
- **C"<site>"** (RRF 3.2 and later only) Set or reset allowed site for Cross-Origin Resource Sharing (CORS) HTTP requests


**Note**: TLS has not yet been implemented in RepRapFirmware, therefore T1 will not work.

### Examples


```
; standalone mode
M586 P0 S1 ; enable HTTP
M586 P1 S0 ; disable FTP
M586 P2 S1 ; enable Telnet
; SBC mode
; NOTE: In SBC mode sending these makes a persistant change, do not add to config.g
M586 P0 T1 S1 ; enable HTTPS
M586 P1 T1 S1 ; disable SFTP
M586 P2 T1 S1 ; enable SSH

```


### Notes

- Standalone mode does not support any secure protocols (M586 ... T1), ie HTTP, FTP and Telnet only. SBC mode can support HTTPS, SFTP and SSH.
- In SBC mode, sending this command makes a persistent change. It does not need to be added to dsf-config.g. It should NOT be included in config.g.
- In SBC mode, `M586 I` is not supported. Configure ufw or another firewall to restrict protocol access per adapter if required.
- M586 with no S parameter reports the current support for the available protocols.
- RepRapFirmware 1.18 and later enable only HTTP (or HTTPS if supported) protocol by default. If you wish to enable FTP and/or Telnet, enable them using this command once or twice in config.g.
- To connect via FTP, use an FTP client such as FileZilla. In FileZilla, create a 'New site', give it a name, then set the 'Host' to the Duet's IP address or .local hostname. Set 'Logon Type' to 'Anonymous', and in 'Transfer Settings' check 'Limit number of simultaneous connections' and set 'Maximum number of connections' to 1. Then connect.

---

## G1: Controlled linear move

### Usage

-

RRF2.02 and later, RRF3

  - G0 Xnnn Ynnn Znnn Ennn Fnnn Snnn Hnnn
  - G1 Xnnn Ynnn Znnn Ennn Fnnn Snnn Hnnn

-

RRF2.01 and earlier

  - G0 Xnnn Ynnn Znnn Ennn Fnnn Snnn
  - G1 Xnnn Ynnn Znnn Ennn Fnnn Snnn



### Parameters

- *Not all parameters need to be used, but at least one of XYZEF must be used*
- **Xnnn** The position to move to on the X axis
- **Ynnn** The position to move to on the Y axis
- **Znnn** The position to move to on the Z axis
- **Ennn** The amount to extrude between the starting point and ending point 1
- **Fnnn** The feed rate per minute of the move between the starting point and ending point (if supplied)
- **Hnnn** Move type (RRF2.02 and later, RRF3)
- **Snnn**

  - In **RRF3**, the S parameter is used to set laser power, when switched into Laser mode (see [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452)); its use for defining move type is deprecated, use 'H' parameter instead.
  - In **RRF 3.5.0** and later, in the form **Snnn:nnn:...**, it is additionally used for laser raster clustering, see S parameter description below.
  - In **RRF2.02** and later, when switched into Laser mode (see [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452)), this parameter sets the laser power. When not switched into Laser mode, and always in firmware 2.01 and earlier, it defines the move type (see the description of the H parameter).

- **Rn** Return to the coordinates stored in restore point #n (see [G60](https://docs.duet3d.com/User_manual/Reference/Gcodes/G60)). Any X, Y, Z and other axis parameters in the command are used as offsets from the stored position. Axes not mentioned are not moved, so use offset 0 for axes you want to restore to the stored value. For example, G1 R2 X0 Y0 Z2 will move to 2mm above the position stored in restore point 2 (i.e. after a toolchange).
- **Pnnnn** (supported only in some builds of RepRapFirmware) IOBITS parameter. Defines the states of output pins while this command is executed. See the M670 command.


1Where a tool has more than one extruder drive then Ennn:nnn:nnn etc is supported to allow for the individual movement of each to be controlled directly. This overrides the extruder mix ratio set with M567

**Very important!** If you use M452 to put your machine into Laser mode, when upgrading firmware from 2.01 or earlier to 2.02 or later you must replace all S parameters in G0/G1 commands in homing files etc. by H parameters. This is because S is now used to control laser power, for compatibility with programs that generate GCode files for laser cutters.

### Examples


```
G0 X12               ; (move to 12mm on the X axis)
G0 F1500             ; (Set the feedrate to 1500mm/minute)
G1 X90.6 Y13.8 E22.4 ; (Move to 90.6mm on the X axis and 13.8mm on the Y axis while extruding 22.4mm of material)
G1 E10:10:5:0:0 F300 ; with a tool that has 5 extruder drives, extrude 10mm on drive 0, 10mm on drive 1, 5mm on drive 2 and 0mm on drive 3 and 4.

```


### Notes

RepRapFirmware treats G0 and G1 in the same way **except** as follows:

- On SCARA and similar architectures that normally require linear motion to be approximated by short segments, a single continuous non-segmented movement will be used if this can be done without the print head dropping below the current Z height.
- In Laser and CNC mode, G0 moves are executed at the maximum feed rate available, to comply with the NIST GCode standard, This feed rate is set by the M203 command.
- RRF maintains a flag for feed rate (F parameter). For all G1/2/3 moves (and G0 moves in FDM mode) the following is true:

  - Each input channel (SD card, USB, http, telnet etc) has its own flag for feed rate.
  - At the end of running config.g at startup, the flag state is copied to all input channels. If no feed rate is specified in config.g, the default of 3000mm/min (50mm/s) is used.
  - The feed rate stored by the flag is used if the next G0/1/2/3 command doesn't include an F parameter.
  - The flag state is saved when a macro starts and is restored when a macro ends.



#### G0/G1 H and S parameter

The meaning of the H parameter is as follows:

- **H0** no special action (default)
- **H1** terminate the move when the endstop switch is triggered and set the axis position to the axis limit defined by M208. On delta printers, H1 also selects individual motor mode as for H2. Normally used with relative motor coordinates (see G91).
- **H2** Individual motor mode. X refers to the X motor or motors, Y refers to the Y motor or motors, and so on. Normally used with relative motor coordinates (see G91).
- **H3** terminate the move when the endstop switch is triggered and set the axis limit to the current position, overriding the value that was set by M208.
- **H4** terminate the move when the endstop switch is triggered and update the current position (supported in RRF 3.2 or later)


The meaning of the S parameter has changed over successive versions of RepRapFirmware. It currently sets the laser power when M452 Laser mode is set, but was also used for homing behaviour. See below.
- RRF 3
- RRF 2.02 to 2.05.1
- RRF 2.01 and earlier

In **RRF 3.x**:

- **H** parameter controls movement type
- **S** parameter sets laser power with range of 0-255 when [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452) Laser mode set, otherwise ignored. M452 R[0-255] parameter sets the maximum laser power, the G1 S parameter sets a proportion of this.


| RRF 3, G0/G1 H parameter BEFORE and AFTER M452 Laser Mode. |  |
|---|---|
| **Parameter** | **Meaning** |
| G1 Xnnn Ynnn Znnn H0 (default) | Ignore endstops while moving but apply axis limits. Don't allow movement if the axis has not previously been homed unless M564 has been used to allow it. |
| G1 Xnnn Ynnn Znnn H1 | Sense endstops while moving (ignoring the axis limits) and stop when the endstop is hit. On Delta, Scara and Polar machines, axis letters refer to individual motors. |
| G1 Xnnn Ynnn Znnn H2 | Ignore endstops and axis limits while moving. Also ignore if axis has not been homed. On Delta, Scara, Polar and Core XY machines axis letters refer to individual towers (delta) or individual joint motors (scara) or A/B motors (CoreXY). |
| G1 Xnnn Ynnn Znnn H3 | Sense endstops while measuring axis length, setting the appropriate M208 limit to the measured position at which the endstop switch triggers. |
| G1 Xnnn Ynnn Znnn H4 | Sense endstops while moving, update the current position at which the endstop switch triggers (supported in RRF 3.2 and later). |


| RRF 3, G0/G1 S parameter BEFORE M452 Laser Mode. |
|---|
| S parameter is ignored |


| RRF 3, G0/G1 S parameter AFTER M452 Laser Mode. |
|---|
| S parameter sets laser power with range of 0-255. |

Note: a G1 Snnn command without axis movement will not trigger the laser, there must be some movement. For example:
 `G1 S128 ; laser does not turn on`
 `G1 X10 S128 ; laser turns on`

In **RRF 3.5.0 and later**:

- **Snnn:nnn:...** parameter is additionally used for 'Raster clustering' mode. Up to 8 S parameters are supported.

To increase the speed of raster engraving, raster clustering mode has been implemented. A single G1 move is split up into equal portions by multiple values in the S parameter, eg `G1 X50 S100:50:25:50:100` would move 50mm and change the laser power every 10mm. This allows more commands to fit in the command buffer, to keep speed up. Laser cutter software such as Lightburn supports raster clustering.

In **RRF 2.02 to 2.05.1**:

- **H** parameter controls movement type.
- **S** parameter controls movement type BEFORE M452 Laser Mode is set. S parameter sets laser power with range of 0-255 AFTER [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452) Laser mode set. M452 R[0-255] parameter sets the maximum laser power, the G1 S parameter sets a proportion of this.


| RRF 2.02 to 2.05.1, G0/G1 H parameter BEFORE and AFTER M452 Laser Mode. |  |
|---|---|
| **Parameter** | **Meaning** |
| G1 Xnnn Ynnn Znnn H0 | Ignore endstops while moving. |
| G1 Xnnn Ynnn Znnn H1 | Sense endstops while moving (ignoring the axis limits). On Delta (only), axis letters refer to individual towers. |
| G1 Xnnn Ynnn Znnn H2 | Ignore endstops while moving. Also ignore if axis has not been homed. On Delta and Core XY, axis letters refer to individual towers. |
| G1 Xnnn Ynnn Znnn H3 | Sense endstops while measuring axis length, setting the appropriate M208 limit to the measured position at which the endstop switch triggers. |


| RRF 2.02 to 2.05.1, G0/G1 S parameter BEFORE M452 Laser Mode. |  |
|---|---|
| **Parameter** | **Meaning** |
| G1 Xnnn Ynnn Znnn S0 | Ignore endstops while moving. |
| G1 Xnnn Ynnn Znnn S1 | Sense endstops while moving. On Delta (only), axis letters refer to individual towers. |
| G1 Xnnn Ynnn Znnn S2 | Ignore endstops while moving. Also ignore if axis has not been homed. On Delta and CoreXY, axis letters refer to individual towers. |
| G1 Xnnn Ynnn Znnn S3 | Sense endstops while measuring axis length, and set the appropriate M208 limit to the measured position at which the endstop switch triggers. |


| RRF 2.02 to 2.05.1, G0/G1 S parameter AFTER M452 Laser Mode. |
|---|
| S parameter sets laser power with range of 0 to 255. |

In **RRF 2.01 and earlier**:

- **S** parameter controls the movement type. There is no H parameter or M452 Laser Mode.


| RRF_2.01 and earlier, G0/G1 S parameter |  |
|---|---|
| **Parameter** | **Meaning** |
| G1 Xnnn Ynnn Znnn S0 | Ignore endstops while moving. |
| G1 Xnnn Ynnn Znnn S1 | Sense endstops while moving. On Delta (only), axis letters refer to individual towers. |
| G1 Xnnn Ynnn Znnn S2 | Ignore endstops while moving. Also ignore if axis has not been homed. On Delta and CoreXY, axis letters refer to individual motors. |
| G1 Xnnn Ynnn Znnn S3 | Sense endstops while measuring axis length, and set the appropriate M208 limit to the measured position at which the endstop switch triggers. |


#### Feedrate


```
G1 F1500
G1 X50 Y25.3 E22.4

```


In the above example, we set the feedrate to 1500mm/minute on line 1, then move to 50mm on the X axis and 25.3mm on the Y axis while extruding 22.4mm of filament between the two points.



```
G1 F1500
G1 X50 Y25.3 E22.4 F3000

```


However, in the above example, we set a feedrate of 1500mm/minute on line 1, then do the move described above accelerating to a feedrate of 3000 mm/minute as it does so. The extrusion will accelerate along with the X and Y movement, so everything stays synchronized.

Feedrate is treated as simply another variable (like X, Y, Z, and E) to be linearly interpolated. This gives complete control over the acceleration and deceleration of the printer head in such a way that ensures that everything moves smoothly together, and the right volume of material is extruded at all points. The feedrate specified may not be reached due to a lower feedrate limit being configured, or the move being too short for the axis to accelerate and decelerate in time.

**For CNC users especially: RRF has a default minimum movement speed of 0.5mm/sec.** In firmware 2.03 and later this can be changed using the I ('i') parameter of the M203 command.

#### Maximum Length of Moves

##### Microstep counter limit

The firmware keeps track of the exact number of microsteps sent to each movement axis using a 32-bit signed integer microstep counter, this limits the maximum absolute move and axis length to (2^31 - 1) microsteps. This does not apply to extruder drives. The firmware multiplies the requested axis position (after adding any offsets) by the steps/mm to get the required microstep position and the microstep counter accumulates across multiple moves, as the axis position increases it increments, as it decreases it decrements. The maximum size of the microstep counter is only an issue for situations where an axis needs to accommodate one or more moves or an overall axis length that would overflow the counter (i.e. an extremely long axis, or an extremely high resolution axis). In typical uses this is not a concern, for example on a standard linear axis using 160 microsteps/mm an axis of over 13km is supported. In cases where the microstep counter is not sufficient (e.g. a very high resolution rotary axis moving for a very long time) G92 can be used to set the origin to a new point on the axis and thus reset the counter.

In a similar manner, if the requested axis position gets very large then accuracy will suffer, because it is held and calculated as a 32-bit float.

##### Move time limit

The maximum duration of a single move that RRF can handle is about 47 minutes on Duet 3 (which is 2^31 cycles of the 750kHz clock) and 38 minutes on Duet 2. If very long running moves are required (e.g. a long running rotary axis) then split the move into several commands each taking no more than about 30 minutes.


---

## G4: Dwell

Pause the machine for a period of time.

### Parameters

- **Pnnn** Time to wait, in milliseconds
- **Snnn** Time to wait, in seconds


### Examples


```
G4 P200 ; wait for 200 milliseconds

```


In this case, sit still doing nothing for 200 milliseconds. The state of the machine, for example the bed and extruder temperatures, will still be preserved and controlled during the delay.


---

## M3: Spindle On, Clockwise

Supported in RepRapFirmware version 1.20 and later when the device mode is set to CNC mode (for CNC mode, see [M453](https://docs.duet3d.com/User_manual/Reference/Gcodes/M453)).
 Supported in RepRapFirmware version 2.01 and later when the device mode is set to CNC and laser mode (for laser mode, see [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452)).
 Supported in RepRapFirmware version 3.5 and later when the device mode is set to CNC, laser and FFF mode (for FFF mode, see [M451](https://docs.duet3d.com/User_manual/Reference/Gcodes/M451)).

### Parameters

- **Snnn** Spindle RPM (CNC/FFF mode), laser power 0-255 (laser mode).
- **Pnnn** Spindle slot (CNC/FFF mode). Directly address a spindle slot.


### Examples


```
M3 S4000 ; CNC mode, turn on spindle at speed of 4000 RPM, clockwise
M3 S255  ; laser mode, set laser power to full on

```


### Notes
- M3 in RepRapFirmware 3.5 and later
- M3 in RepRapFirmware 3.0 and 3.4
- M3 in RepRapFirmware 2.01 to 2.05.1
- M3 in RepRapFirmware 1.20 to 2.0

- **M3** commands are now supported in FFF/FDM mode as well as CNC and laser mode. This will allow mixing of additive and subtractive tools without switching mode.
- **FFF mode:**

  - In FFF mode, M3 will control a predefined spindle, as 'CNC mode' below. Lasers are not supported.

- **CNC mode:**

  - M3 can be called without any parameters and will start the spindle of the current tool turning clockwise at the spindle RPM of that tool.
  - Using the S parameter will additionally set the spindle RPM of the current tool.
  - It is an error if there is no tool active or the active tool does not have a spindle assigned and there is no P parameter provided to define which spindle this should be applied to.

- **Laser mode:**

  - In 'non-sticky' mode (M452 S0), M3 commands are redundant, as all G1 commands need an S parameter to fire the laser, otherwise it just defaults to S0.
  - In 'sticky' mode (M452 S1), you can set the laser with, for example, `M3 S255`, then subsequent G1 moves will use that setting without needing an S parameter. Alternatively set the laser power with the first G1 S command, and subsequent G1 commands will use that setting, until either an `M3 S0`, `G1 S0` or `M5` is sent.
  - M3 can't be used to fire the laser on its own; the laser will only fire with a G1 movement command.
  - All M3 commands must have an S parameter. Sending M3 on its own generates an error.
  - The relationship between the S parameter and laser power depends on the R parameter that was specified in the M452 command.
  - Note there can be issues using this mode as the M-command queue is only 8 commands long, while the G-command queue is 20 commands long. You may get stuttering, particularly when raster engraving. Better to use G1 with S parameter, and the 'raster clustering' format for even better performance (see G1 entry, S parameter section).



- CNC mode:

  - M3 can be called without any parameters and will start the spindle of the current tool turning clockwise at the spindle RPM of that tool.
  - Using the S parameter will additionally set the spindle RPM of the current tool.
  - It is an error if there is no tool active or the active tool does not have a spindle assigned and there is no P parameter provided to define which spindle this should be applied to.

- Laser mode:

  - In 'non-sticky' mode (M452 S0), M3 commands are redundant, as all G1 commands need an S parameter to fire the laser, otherwise it just defaults to S0.
  - In 'sticky' mode (M452 S1), you can set the laser with, for example, `M3 S255`, then subsequent G1 moves will use that setting without needing an S parameter. Alternatively set the laser power with the first G1 S command, and subsequent G1 commands will use that setting, until either an `M3 S0` or `M5` is sent.
  - M3 can't be used to fire the laser on its own; the laser will only fire with a G1 movement command.
  - All M3 commands must have an S parameter. Sending M3 on its own generates an error.
  - The relationship between the S parameter and laser power depends on the R parameter that was specified in the M452 command.
  - Note there can be issues using this mode as the M-command queue is only 8 commands long, while the G-command queue is 20 commands long. You may get stuttering, particularly when raster engraving. Better to use G1 with S parameter.



- CNC mode:

  - M3 can be called without any parameters and will start the spindle of the current tool turning clockwise at the spindle RPM of that tool.
  - Using the S parameter will additionally set the spindle RPM of the current tool.
  - It is an error if there is no tool active or the active tool does not have a spindle assigned and there is no P parameter provided to define which spindle this should be applied to.

- Laser mode:

  - M3 turns the laser on, with the S parameter setting the laser power (0 to 255), before a series corresponding G1 move.
  - The relationship between the S parameter and laser power depends on the R parameter that was specified in the M452 command.
  - Note there can be issues using this mode as the M-command queue is only 8 commands long, while the G-command queue is 20 commands long. You may get stuttering, particularly when raster engraving. Better to use G1 with S parameter.



- CNC mode:

  - M3 can be called without any parameters and will start the spindle of the current tool turning clockwise at the spindle RPM of that tool.
  - Using the S parameter will additionally set the spindle RPM of the current tool.
  - It is an error if there is no tool active or the active tool does not have a spindle assigned and there is no P parameter provided to define which spindle this should be applied to.


---

## M5: Spindle Off

Supported in RepRapFirmware version 1.20 and later when the device mode is set to CNC mode (for CNC mode, see [M453](https://docs.duet3d.com/User_manual/Reference/Gcodes/M453)).
 Supported in RepRapFirmware version 2.01 and later when the device mode is set to CNC and laser mode (for laser mode, see [M452](https://docs.duet3d.com/User_manual/Reference/Gcodes/M452)).
 Supported in RepRapFirmware version 3.5 and later when the device mode is set to CNC, laser and FFF mode (for FFF mode, see [M451](https://docs.duet3d.com/User_manual/Reference/Gcodes/M451)).

### Parameters

- none


### Examples


```
M5 ; turn off spindle/laser

```


### Notes
- M5 in RepRapFirmware 3.5 and later
- M5 in RepRapFirmware 3.0 to 3.4
- M5 in RepRapFirmware 2.01 to 2.05.1
- M5 in RepRapFirmware 1.20 to 2.0

- **M5** commands are now supported in FFF/FDM mode as well as CNC and laser mode. This will allow mixing of additive and subtractive tools wihtout switching mode.
- **FFF mode:**

  - In FFF mode, M5 will control a predefined spindle, as 'CNC mode' below. Lasers are not supported.

- **CNC mode:**

  - M5 will stop the spindle of the current tool (if any) or all defined spindles if the current tool has no spindle assigned or there is no active tool.

- **Laser mode:**

  - In 'non-sticky' mode (M452 S0), M5 commands are redundant, as all G1 commands need an S parameter to fire the laser, otherwise it just defaults to S0.
  - In 'sticky' mode (M452 S1), `M5` (or `M3 S0` or `G1 S0`) will turn off the laser, and subsequent G1 commands (without an S parameter) will not fire the laser until another M3 S# or G1 S# command is sent.



- **CNC mode:**

  - M5 will stop the spindle of the current tool (if any) or all defined spindles if the current tool has no spindle assigned or there is no active tool.

- **Laser mode:**

  - In 'non-sticky' mode (M452 S0), M5 commands are redundant, as all G1 commands need an S parameter to fire the laser, otherwise it just defaults to S0.
  - In 'sticky' mode (M452 S1), `M5` (or `M3 S0` or `G1 S0`) will turn off the laser, and subsequent G1 commands (without an S parameter) will not fire the laser until another M3 S# or G1 S# command is sent.



- **CNC mode:**

  - M5 will stop the spindle of the current tool (if any) or all defined spindles if the current tool has no spindle assigned or there is no active tool.

- **Laser mode:**

  - M5 (or M3 S0 or G1 S0) will turn off the laser, and subsequent G1 commands (without an S parameter) will not fire the laser until another M3 S# or G1 S# command is sent.



- **CNC mode:**

  - M5 will stop the spindle of the current tool (if any) or all defined spindles if the current tool has no spindle assigned or there is no active tool.


---

## M98: Call Macro/Subprogram

### Parameters

- **P"nnn"** Macro filename. If no path is specified, the default folder is /sys.
- **Rn** When M98 is used inside a macro and no P parameter is provided, indicates whether the macro can be paused from this point onwards and subsequently restarted from the beginning. (RRF 3.4 and later, see Notes for usage).


### Examples


```
M98 P"mymacro.g" ; Runs the macro in the file /sys/mymacro.g
M98 P"macro.g" S100 Y"string" ; Runs /sys/macro.g, passes the values for parameters S and Y to the macro

; within macros
M98 R1 ; macro can be paused from this point onwards

```


### Notes

- Macro calls can be nested (i.e. a macro can call another macro). From RRF v3.4.0, the maximum stack depth is 10. This is the maximum number of macro calls and M120 commands that may be nested. Deamon.g will also use up one of them. However, there is also a limit on the number of open files, which is 20 on Duet 3 and 10 on Duet 2. For example, on Duet 2 if you have a print running from SD card and logging enabled, you will be limited to a macro nesting depth of 8.
- **P** parameter:

  - In RRF 3.x and later, quotation marks around the filename are mandatory. In RRF2.x and earlier, the filename can be enclosed in quotes if required. See [Quoted Strings](https://docs.duet3d.com/User_manual/Reference/Gcodes#quoted-strings) for details.
  - The filename may include a path to a subdirectory. For relative paths, the default folder is /sys. Absolute file paths are also supported starting with "0:/" for the internal SD card or "1:/" for the external SD card if fitted.
  - If the P parameter is provided then any additional parameters will be passed to the macro. In RRF 3.3 and later M98 supports additional parameters used to pass information to the macro being called. See the [GCode Meta Commands, Macro parameters](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands#macro-parameters) documentation for the details.

- **R** parameter: this is used within a macro file to indicate whether the macro can be paused from this point on.

  - 0 = (default) remainder of current macro cannot be paused. By default, a macro cannot be paused except in the case of power failure.
  - 1 = remainder of current macro can be paused **and the macro restarted from the beginning after resuming**,
  - **Do not use R1 in system macros** such as tool change macros, homing macros, pause.g or resume.g.


---

## M112: Emergency Stop

### Examples


```
M112

```


Any moves in progress are immediately terminated, then Duet shuts down. All motors and heaters are turned off. PSU power (if controlled by the Duet via the PS_ON pin) is NOT turned off, to allow any always-on fans to continue to run. The Duet can be started again by pressing the reset button or power cycling the board. See also [M0 - stop or unconditional stop](https://docs.duet3d.com/User_manual/Reference/Gcodes/M0) and [M1 - sleep or conditional stop](https://docs.duet3d.com/User_manual/Reference/Gcodes/M1). To turn off PSU power via the PS_ON pin in an emergency stop, make a trigger macro that includes M81 before M112; see [User manual: Connecting an emergency stop](https://docs.duet3d.com/User_manual/Connecting_hardware/IO_E_stop).


---

## M118: Send Message to Specific Target

Supported in RepRapFirmware 1.21 and later.

### Parameters

- **Pnnn** Message type: 0 = Generic [default], 1 = USB, 2 = PanelDue/UART, 3 = HTTP, 4 = Telnet, 5 = second UART, 6 = MQTT Client [RRF 3.5 and later on WiFi-equipped Duet 3 boards, or RRF 3.6 on all Duet 3 boards], 7 = second USB channel [RRF 3.7 and later on Duet 3 boards] (optional)
- **S"msg"** Message to send , limit of 100 characters
- **Lnnn** Log level of this message (0 = do not log this line, 1 = log as WARN, 2 = log as INFO, 3 = log as DEBUG (default)) (RRF 3.2 and later)
- **T"topic"** The topic to publish the message under (only valid on MQTT Client message).
- **Qnn** The QOS level of the message to publish, from `0` to `2` (only valid for MQTT Client message, optional). Defaults to `0` if not specified.
- **Rn** Set publish retain flag, `1` or `0` (only valid for MQTT Client message, optional). Defaults to `0` if not specified.
- **Dn** Set publish duplicate flag, `1` or `0` (only valid for MQTT Client message, optional). Defaults to `0` if not specified.


### Examples


```
M118 S"Hello Duet"
M118 S"Hello Logfile" L1
M118 P0 S"Hello Logfile and DWC" L1
M118 S"Don't log me" L0
M118 S"My MQTT Message" T"My-MQTT-Topic"

```


This code may be used to send messages to a specific target. Basically it is a simple wrapper for RepRapFirmware's Platform::Message method.

Note that the implementation in RepRapFirmware always requires the S-parameter to be passed. If it is omitted, an error will be reported.

The second example shows how to send a message to the log file in log level WARN instead of the default log level DEBUG.

The third example shows how to prevent a message from being logged.

Note that a message only having the **Lnnn** parameter but no **Pnnn** parameter will only go to the log file (if the log level matches the current log level of the system) and will not be sent to other outputs. If you want it to show on DWC as well then send:



```
M118 P0 S"message" L1

```


**Note**: messages that exceed **100 characters** will be truncated.


---

## M260: i2c Send and/or request Data

Send and/or receive data over the i2c bus. Supported in RepRapFirmware 1.21 and later.

### Parameters

- **Ann** I2C address
- **Rnn** Number of bytes to receive (optional) - firmware 2.02 and later only
- **Bnn:nn:nn...** Bytes to send (optional in firmware 2.02 and later)
- **S"ascii data"** data to send (alternative to B parameter). Each character is converted to the corresponding ASCII value. Ignored if **B** parameter is present.
- **V"name"** (optional, from RRF 3.6.0) name of a new variable to receive data into. If this parameter is not present then the data read is output to the console.


### Examples


```
M260 A5 B65                   ; send 'A' to address 5 now
M260 A"x7F" B65               ; send 'A' to address 7F (hex)
M260 A0 B82:101:112:82:97:112 ; send 'RepRap' to address 0
M260 A"x71" B19 R2            ; send 19 to address 71 (hex) and read 2 bytes back
M260 A5 R2                    ; read 2 bytes of data from address 5
M260 A5 S"Hello world"        ; send "Hello world" to address 5

```


Hex addresses are only supported in firmware 2.02 and later.


---

## M260.1: Modbus write registers or coils

*Supported from firmware version 3.6*

Write data to a Modbus slave device using standard Modbus protocol. If the device you wish to commuicatre with does not use the standard Modbus-RTU command set then you may be able to communicate with it using M260.4 instead.

### Parameters

- **Pnn** Serial port to send/receive through, numbered as in M575 (RRF 3.7 and later: 2 = first aux port, 3 = second aux port; RRF3.6.x and earlier: 1 = first aux port, 2 = second aux port).
- **Ann** Modbus slave device address
- **Fn** (optional) Modbus function code, must be one of: 5 (Write Single Coil), 6 (Write Single Register), 15 (Write Multiple Coils), 16 (Write Multiple Registers, default)
- **Rnn** First Modbus coil or register number to write to
- **Bnn:nn:nn...** One value per coil or register to write. If writing registers, each value is a 16-bit word to write. If writing coils, each value is zero to set coil off, nonzero to set coil on.
- **S"ascii data"** data to send (alternative to B parameter). Each character is converted to the corresponding ASCII value. Ignored if **B** parameter is present.


### Order dependency

The port used by the P parameter must already have been set to Device mode using [M575](https://docs.duet3d.com/User_manual/Reference/Gcodes/M575).

### Examples


```
M260.1 P1 A5 R10 B956               ; write 956 to register 10 of the device at address 5
M260.1 P1 A8 R20 B123:456           ; write 123 to register 20 and 456 to register 21 of the device at address 8

```


---

## M260.2: UART write

*Supported from firmware version 3.6*

Write data to a generic UART device.

### Parameters

- **Pnn** Serial port to send/receive through, numbered as in M575 (RRF 3.7 and later: 2 = first aux port, 3 = second aux port; RRF3.6.x and earlier: 1 = first aux port, 2 = second aux port).
- **Bnn:nn:nn...** Array of data to send to the UART. Each element is 1 byte, if a value is greater than 0xFF (255) then it will be truncated to the lowest byte.
- **S"ascii data"** data to send (alternative to B parameter). Each character is converted to the corresponding ASCII value. Ignored if **B** parameter is present.


### Order dependency

The port used by the P parameter must already have been set to Device mode using [M575](https://docs.duet3d.com/User_manual/Reference/Gcodes/M575).

### Examples


```
M260.2 P1 B20                                         ; write 20 to register 10 of the device at address 5
M260.2 P1 B72:101:108:108:111:32:119:111:114:108:100  ; write "Hello world" (when converted to ascii)
M260.2 P1 B{0x02, 0x30, 0x03}                         ; writing data as hex
M260.2 P1 B{0xFF01, 257}                              ; write 0x01:0x01 to UART as data is truncated to 1 byte
M260.2 P1 S"Hello world"                              ; write "Hello world" to UART

```


---

## M260.4: Raw Modbus transaction

*Supported from firmware version 3.6*

Perform a non-standard transaction with a Modbus slave device. The request and response must both start with the slave address and end with two CRC-16 bytes, but the data between them need not conform to the Modbus-RTU specification. RepRapFirmware prepends the slave address to the data and appends the CRC when sending. After receiving the specified number of bytes, RepRapFirmware checks that the received slave address and CRC are correct and removes them from the returned data. It is up to the user to check the other values in the response.

### Parameters

- **Pnn** Serial port to send/receive through, numbered as in M575 (RRF 3.7 and later: 2 = first aux port, 3 = second aux port; RRF3.6.x and earlier: 1 = first aux port, 2 = second aux port).
- **Ann** Modbus slave device address
- **Rnn** Number of bytes to receive excluding the slave address and the CRC
- **Bnn:nn:nn...** Values to send excluding the slave address and the CRC
- **S"ascii data"** data to send (alternative to B parameter). Each character is converted to the corresponding ASCII value. Ignored if **B** parameter is present.
- **V"name"** (optional) name of a new variable to receive data into. If this parameter is not present then the data read is output to the console.


### Order dependency

The port used by the P parameter must already have been set to Device mode using [M575](https://docs.duet3d.com/User_manual/Reference/Gcodes/M575).

### Examples


```
M260.4 P1 A1 B{0x06, 0x00, 0x01, 0x12, 0x34} R5 ; send data as hex

```


---

## M261.1: Modbus read registers, coils or inputs

*Supported from firmware version 3.6*

Request data (synchronously) from a Modbus slave device.

### Parameters

- **Pnn** Port to send/receive through, numbered as in M575 (RRF 3.7 and later: 2 = first aux port, 3 = second aux port; RRF3.6.x and earlier: 1 = first aux port, 2 = second aux port).
- **Ann** Modbus device address
- **Rnn** Register number to start from
- **Bnn** How many registers,coils or inputs to request
- **Fn** (optional) Modbus function code, must be one of: 1 (Read Coils), 2 (Read Discrete Inputs), 3 (Read Holding Registers), 4 (Read Input Registers, default)
- **V"name"** (optional) name of a new variable to receive data into. If this parameter is not present then the data read is output to the console.


### Order dependency

The port used by the P parameter must already have been set to Device mode using [M575](https://docs.duet3d.com/User_manual/Reference/Gcodes/M575).

### Examples


```
M261.1 P1 A80 R10 B2 V"modbusData" ; (RepRapFirmware) Read registers 10 and 11 from Modbus station 80 via the first aux port and store the result in var.modbusData

```


---

## M261.2: UART read

*Supported from firmware version 3.6*

Request data (synchronously) from a UART device.

### Parameters

- **Pnn** Port to send/receive through, numbered as in M575 (RRF 3.7 and later: 2 = first aux port, 3 = second aux port; RRF3.6.x and earlier: 1 = first aux port, 2 = second aux port).
- **Bnn** How many bytes to read
- **V"name"** (optional) name of a new variable to receive data into. If this parameter is not present then the data read is output to the console.


### Order dependency

The port used by the P parameter must already have been set to Device mode using [M575](https://docs.duet3d.com/User_manual/Reference/Gcodes/M575).

### Examples


```
M261.2 P1 B2 V"data" 	; (RepRapFirmware) Read 2 bytes from the first aux port and store the result in var.data
M261.2 P1 B0			; Clear UART buffer

```


---

## M291: Display message and optionally wait for response

Supported in firmware version 1.19 and later.

### Parameters

- **P"message"** The message to display, which must be enclosed in double quotation marks. If the message itself contains a double quotation mark, use two double quotation marks to represent it. Maximum length <250 chars. Limited by total gcode length limit of 256 characters.
- **R"message"** Optional title for the message box. Must be enclosed in double quotation marks too. Maximum length 60 chars
- **Sn** Message box mode (see below), default 1
- **Tn** Timeout in seconds, only used for types 0, 1, and those with a cancel button (type 3 or higher with J1 or J2 parameter; the message box is cancelled upon timeout). The message will be cancelled after this amount of time if the user does not cancel it before then. A zero or negative value means that the message does not time out (it may still be cancelled by the user if it has a Cancel button). For modes 0 and 1 there is a default timeout of 10 seconds if no T parameter is provided. For other modes the default is no timeout.
- **X, Y, Z,,,** 0 = no special action (default), 1 = display jog buttons alongside the message to allow the user to adjust the head position on the specified axis. Only valid in with message box modes S2 and S3.
- **Jn** (RRF 3.5 and later only, optional) If message box mode >= 4: 0 = no Cancel button (default), 1 = display a Cancel button (job/macro is cancelled immediately when pressed or when it times out); 2 (RRF 3.6.0 and later) = display a Cancel button (result variable is set to -1 when pressed or when timeout is reached).
- **K{"choice1","choice1",...}** (RRF 3.5 and later only) List of choices, required (and only used) when S=4.
- **Lnnn** (RRF 3.5 and later only, optional) Minimum accepted value (S=5 or S=6), or minimum number of characters (S=7).
- **Hnnn** (RRF 3.5 and later only, optional) Maximum accepted value (S=5 or S=6), or maximum number of characters (S=7).
- **Fnnn** or **F"text"** (RRF 3.5 and later only, optional) default choice number (counting from 0) when S=4, or default value when S>=5.


### Description

This command provides a more flexible alternative to M117, in particular messages that time out, messages that suspend execution until the user acknowledges them, and messages that allow the user to adjust the height of the print head before acknowledging them.

Messages can be non-blocking, i.e. are for information and/or don't need interaction from the user, or blocking, i.e. require input from the user. Message box mode (S parameter) 0 and 1 are non-blocking, all others are blocking. Allowed message box modes are:

S0: No buttons are displayed (non-blocking)
 S1: Only "Close" is displayed (non-blocking)
 S2: Only "OK" is displayed (blocking, send M292 to resume the execution)
 S3: "OK" and "Cancel" are displayed (blocking, send M292 to resume the execution or M292 P1 to cancel the operation in progress)
 S4: Display a number of choices. The names of the choices are given by the K parameter as an array of strings. The choice selected by the user, as the array index, is available to be used in the ["input" constant](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands#named-constants) (blocking, RRF 3.5 and later only)
 S5: Prompt for an integer value. L is the minimum accepted value (default 0), H is the maximum accepted value (default unlimited), and F is the default value. The integer is available to be used in the ["input" constant](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands#named-constants) (blocking, RRF 3.5 and later only)
 S6: Prompt for a floating point value. L is the minimum accepted value (default 0.0), H is the maximum accepted value, and F is the default value. The floating point value is available to be used in the ["input" constant](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands#named-constants) (blocking, RRF 3.5 and later only)
 S7: Prompt for a string value. L is the minimum number of characters (default 1), H is the maximum number of characters (default 10), and F is the default value. The string is available to be used in the ["input" constant](https://docs.duet3d.com/User_manual/Reference/Gcode_meta_commands#named-constants) (blocking, RRF 3.5 and later only)

### Notes

- The combination S0 T0 is not permitted, because that would generate a message box with no close button and that never times out, which would lock up the user interface.
- Duet Web Control 2.03 and later support HTML messages but those may not be displayed correctly on an attached PanelDue.
- When using Duet 3 with attached SBC, DSF versions before v3.1.1 support only non-blocking calls are supported in DuetSoftwareFramework. M291 is fully supported in DSF v3.1.1 and later.
- The limit in RRF 3.4 and later is 256 characters in the entire GCode command. Before 3.4 is was 200 characters, in RRF2 it's 160 characters.
- For message box modes 4 and higher The J parameter specifies whether a Cancel button is provided and what action is taken when that button is pressed or the timeout (see T parameter) expires. J1 causes execution of the entire file stack from which the M291 command was executed to be terminated. J2 (supported in RRF 3.6.0 and later) causes the message box to be cancelled but execution to continue as normal with **result** set to -1 and the value of **input** undefined. Therefore when J2 is used the value of **result** must be tested in the line that follows the M291 command.


### Examples


```
M291 R"Title" P"Message" K{"Yes","No"} S4
if (input == 1)
    echo "No chosen"

```



```
M291 R"Title" P"Request for string" S7 L5 H40 F"default string"
echo {input^" entered by user"}

```


---

## M400: Wait for current moves to finish

### Parameters

- **Sn** (RRF 3.5.0 and later only, optional, default 0) 0 = release all axes and extruders owned by the current motion system except for axes/extruders needed by the current tool, 1 = do not release axes or extruders


### Examples


```
M400     ; wait until motion stops, in RRF 3.5.0 and later with multiple motion systems release owned axes and extruders
M400 S1  ; wait until motion stops, do not release any axes or extruders

```


### Notes

Finishes all current moves and and thus clears the buffer. That's identical to G4 P0 except that G4 P0 does not release any axes or extruders.
