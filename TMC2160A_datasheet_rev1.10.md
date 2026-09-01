*POWER DRIVER FOR STEPPER MOTORS*

*INTEGRATED CIRCUITS*

# TMC2160 / TMC2160A DATASHEET

**_Universal high voltage driver for two-phase bipolar stepper motor. StealthChop™ for quiet movement. External MOSFETs for 1A to several 10A coil current. With Step/Dir Interface and SPI._**

coolStep™

##### APPLICATIONS

Robotics & Industrial Drives Textile, Sewing Machines Packing Machines Factory & Lab Automation High-speed 3D Printers Liquid Handling Medical

Office Automation CCTV

ATM, Cash Recycler Pumps and Valves

##### FEATURES AND BENEFITS

**2-phase** stepper motors from 1A to several 10A coil current **Step/Dir Interface** with microstep interpolation **MicroPlyer™ Voltage Range** 8 … 60V DC

**SPI** Interface

**Highest Resolution** 256 microsteps per full step **StealthChop2™** for quiet operation and smooth motion **Resonance Dampening** for mid-range resonances **SpreadCycle™** highly dynamic motor control chopper

**DcStep™** load dependent speed control

**StallGuard2™** high precision sensorless motor load detection **CoolStep™** current control for energy savings up to 75% **Passive Braking** and freewheeling mode

**Full Protection & Diagnostics**

**Compact Size** 7x7mm<sup>2</sup> (body) TQFP48 package

##### DESCRIPTION

The TMC2160 / TMC2160A is a high-power stepper motor driver IC with SPI interface. It features industries’ most advanced stepper motor driver with simple Step / Direction interface. Using external transistors, highly dynamic, high torque drives can be realized. Based on TRINAMICs sophisticated SpreadCycle and StealthChop choppers, the driver ensures absolutely noiseless operation combined with maximum efficiency and best motor torque. High integration, high energy efficiency and a small form factor enable miniaturized and scalable systems for cost effective solutions. The fully compatible TMC5160 offers an additional motion controller to make stepper motor control even easier.

##### BLOCK DIAGRAM

TRINAMIC Motion Control GmbH & Co. KG Hamburg, Germany

##### APPLICATION EXAMPLES: HIGH VOLTAGE – MULTIPURPOSE USE

The TMC2160 scores with advanced motor commutation algorithms, combined with powerful external MOSFET driver stages, and high-quality current regulation. It offers a versatility that covers a wide spectrum of applications from battery powered high efficiency systems up to embedded applications with 20A motor current per coil. Based on TRINAMICs unique features StallGuard2, CoolStep, DcStep, SpreadCycle, and StealthChop, the TMC2160 optimizes drive performance. It trades off velocity vs. motor torque, optimizes energy efficiency, smoothness of the drive, and noiselessness. The small form factor of the TMC2160 keeps costs down and allows for miniaturized layouts. Extensive support at the chip, board, and software levels enables rapid design cycles and fast time-to-market with competitive products. High energy efficiency and reliability deliver cost savings in related systems such as power supplies and cooling. For smaller designs, the software compatible, fully integrated TMC2130 driver provides up to 1.4A of motor current.

In this application, the CPU initializes the TMC2160 motor driver via SPI interface and controls motor movement by sending step and direction signals. A real time software realizes motion control.

The CPU initializes the TMC4361 motion controller and the TMC2160. Thereafter, it sends target positions to the TMC4361. Now, the TMC4361 takes control over the TMC2160. Combining the TMC4361 and the TMC2160 offers diverse possibilities for demanding applications including servo drive features.

The TMC2160-EVAL is part of TRINAMICs universal evaluation board system which provides a convenient handling of the hardware as well as a user-friendly software tool for evaluation. The TMC2160 evaluation board system consists of three parts: LANDUNGSBRÜCKE (base board), ESELSBRÜCKE (connector board including several test points), and TMC2160-EVAL.

_Hint_ : TMC2160 in this manual always refers to both, the TMC2160A and TMC2160, unless explicitly noted with “ _non-A-version_ ” or “ _A-version_ ”. The _A-version_ compatibly replaces the _non-A-version_ .

##### ORDER CODES

|**Order code**|**Description**|**Size**[mm<sup>2</sup>]|
|---|---|---|
|TMC2160A-TA|Stepper Motor Driver IC, SPI, Step/Dir, UART, 8-60V Supply, 1.4A,<br>TQFP48,Tray|<br>7 x 7 (body)|
|TMC2160A-TA-T|Stepper Motor Driver IC, SPI, Step/Dir, UART, 8-60V Supply, 1.4A,<br>TQFP48,Tape & Reel|<br>7 x 7 (body)|
|TMC2160-EVAL-KIT|Full Evaluation Kit for TMC2160|126 x 85|
|TMC2160-EVAL|Evaluation Board for TMC2160 (excl. Landungsbrücke and Eselsbrücke)|85 x 55|
|TMC2160-BOB|Breakout Board with TMC2160|38 x 28|

## Table of Contents

- [1 Principles of Operation](#1-principles-of-operation)
  - [1.1 Key Concepts](#11-key-concepts)
  - [1.2 Control Interfaces](#12-control-interfaces)
    - [1.2.1 SPI Interface](#121-spi-interface)
  - [1.3 Software](#13-software)
  - [1.4 Moving the Motor](#14-moving-the-motor)
    - [1.4.1 STEP/DIR Interface](#141-stepdir-interface)
    - [1.4.2 SPI direct mode](#142-spi-direct-mode)
  - [1.5 Automatic Standstill Power Down](#15-automatic-standstill-power-down)
  - [1.6 StealthChop2 & SpreadCycle Driver](#16-stealthchop2-spreadcycle-driver)
  - [1.7 StallGuard2 – Mechanical Load Sensing](#17-stallguard2-mechanical-load-sensing)
  - [1.8 CoolStep – Load Adaptive Current](#18-coolstep-load-adaptive-current)
  - [1.9 DcStep – Load Dependent Speed](#19-dcstep-load-dependent-speed)
- [2 Pin Assignments](#2-pin-assignments)
  - [2.1 Package Outline](#21-package-outline)
  - [2.2 Signal Descriptions](#22-signal-descriptions)
- [3 Sample Circuits](#3-sample-circuits)
  - [3.1 Standard Application Circuit](#31-standard-application-circuit)
  - [3.2 External Gate Voltage Regulator](#32-external-gate-voltage-regulator)
  - [3.3 Choosing MOSFETs and Slope](#33-choosing-mosfets-and-slope)
  - [3.4 Tuning the MOSFET Bridge](#34-tuning-the-mosfet-bridge)
- [4 SPI Interface](#4-spi-interface)
  - [4.1 SPI Datagram Structure](#41-spi-datagram-structure)
    - [4.1.1 Selection of Write / Read (WRITEnotREAD)](#411-selection-of-write-read-writenotread)
    - [4.1.2 SPI Status Bits Transferred with Each Datagram Read Back](#412-spi-status-bits-transferred-with-each-datagram-read-back)
    - [4.1.3 Data Alignment](#413-data-alignment)
  - [4.2 SPI Signals](#42-spi-signals)
  - [4.3 Timing](#43-timing)
- [5 Register Mapping](#5-register-mapping)
  - [5.1 General Configuration Registers](#51-general-configuration-registers)
    - [5.1.1 OTPREAD – OTP configuration memory](#511-otpread-otp-configuration-memory)
  - [5.2 Velocity Dependent Driver Feature Control Register Set](#52-velocity-dependent-driver-feature-control-register-set)
    - [5.2.1 DcStep Minimum Velocity Register](#521-dcstep-minimum-velocity-register)
  - [5.3 Motor Driver Registers](#53-motor-driver-registers)
    - [5.3.1 MSLUTSEL – Look up Table Segmentation Definition](#531-mslutsel-look-up-table-segmentation-definition)
    - [5.3.2 CHOPCONF – Chopper Configuration](#532-chopconf-chopper-configuration)
    - [5.3.3 COOLCONF – Smart Energy Control CoolStep and StallGuard2](#533-coolconf-smart-energy-control-coolstep-and-stallguard2)
    - [5.3.4 PWMCONF – Voltage PWM Mode StealthChop](#534-pwmconf-voltage-pwm-mode-stealthchop)
    - [5.3.5 DRVSTATUS – StallGuard2 Value and Driver Error Flags](#535-drvstatus-stallguard2-value-and-driver-error-flags)
- [6 StealthChop™](#6-stealthchop)
  - [6.1 Automatic Tuning](#61-automatic-tuning)
  - [6.2 StealthChop Options](#62-stealthchop-options)
  - [6.3 StealthChop Current Regulator](#63-stealthchop-current-regulator)
    - [6.3.1 Lower Current Limit](#631-lower-current-limit)
  - [6.4 Velocity Based Scaling](#64-velocity-based-scaling)
  - [6.5 Combine StealthChop and SpreadCycle](#65-combine-stealthchop-and-spreadcycle)
  - [6.6 Flags in StealthChop](#66-flags-in-stealthchop)
    - [6.6.1 Open Load Flags](#661-open-load-flags)
    - [6.6.2 PWMSCALESUM Informs about the Motor State](#662-pwmscalesum-informs-about-the-motor-state)
  - [6.7 Freewheeling and Passive Braking](#67-freewheeling-and-passive-braking)
- [7 SpreadCycle and Classic Chopper](#7-spreadcycle-and-classic-chopper)
  - [7.1 SpreadCycle Chopper](#71-spreadcycle-chopper)
  - [7.2 Classic Constant Off Time Chopper](#72-classic-constant-off-time-chopper)
- [8 Selecting Sense Resistors](#8-selecting-sense-resistors)
- [9 Velocity Based Mode Control](#9-velocity-based-mode-control)
- [10 Diagnostics and Protection](#10-diagnostics-and-protection)
  - [10.1 Temperature Sensors](#101-temperature-sensors)
  - [10.2 Short Protection](#102-short-protection)
  - [10.3 Open Load Diagnostics](#103-open-load-diagnostics)
- [11 StallGuard2 Load Measurement](#11-stallguard2-load-measurement)
  - [11.1 Tuning StallGuard2 Threshold SGT](#111-tuning-stallguard2-threshold-sgt)
    - [11.1.1 Variable Velocity Limits TCOOLTHRS and THIGH](#1111-variable-velocity-limits-tcoolthrs-and-thigh)
    - [11.1.2 Small Motors with High Torque Ripple and Resonance](#1112-small-motors-with-high-torque-ripple-and-resonance)
    - [11.1.3 Temperature Dependence of Motor Coil Resistance](#1113-temperature-dependence-of-motor-coil-resistance)
    - [11.1.4 Accuracy and Reproducibility of StallGuard2 Measurement](#1114-accuracy-and-reproducibility-of-stallguard2-measurement)
  - [11.2 StallGuard2 Update Rate and Filter](#112-stallguard2-update-rate-and-filter)
  - [11.3 Detecting a Motor Stall](#113-detecting-a-motor-stall)
  - [11.4 Homing with StallGuard](#114-homing-with-stallguard)
  - [11.5 Limits of StallGuard2 Operation](#115-limits-of-stallguard2-operation)
- [12 CoolStep Operation](#12-coolstep-operation)
  - [12.1 User Benefits](#121-user-benefits)
  - [12.2 Setting up for CoolStep](#122-setting-up-for-coolstep)
  - [12.3 Tuning CoolStep](#123-tuning-coolstep)
    - [12.3.1 Response Time](#1231-response-time)
    - [12.3.2 Low Velocity and Standby Operation](#1232-low-velocity-and-standby-operation)
- [13 STEP/DIR Interface](#13-stepdir-interface)
  - [13.1 Timing](#131-timing)
  - [13.2 Changing Resolution](#132-changing-resolution)
  - [13.3 MicroPlyer and Stand Still Detection](#133-microplyer-and-stand-still-detection)
- [14 DIAG Outputs](#14-diag-outputs)
- [15 DcStep](#15-dcstep)
  - [15.1 User Benefits](#151-user-benefits)
  - [15.2 Designing-In DcStep](#152-designing-in-dcstep)
  - [15.3 Stall Detection in DcStep Mode](#153-stall-detection-in-dcstep-mode)
  - [15.4 DcStep with STEP/DIR Interface](#154-dcstep-with-stepdir-interface)
    - [15.4.1 Using LOSTSTEPS for DcStep Operation](#1541-using-loststeps-for-dcstep-operation)
    - [15.4.2 DCO Interface to Motion Controller](#1542-dco-interface-to-motion-controller)
- [16 Sine-Wave Look-up Table](#16-sine-wave-look-up-table)
  - [16.1 User Benefits](#161-user-benefits)
  - [16.2 Microstep Table](#162-microstep-table)
- [17 Emergency Stop](#17-emergency-stop)
- [18 Quick Configuration Guide](#18-quick-configuration-guide)
- [19 Getting Started](#19-getting-started)
  - [19.1 Initialization Examples](#191-initialization-examples)
- [20 Standalone Operation](#20-standalone-operation)
- [21 Power-Up Reset](#21-power-up-reset)
- [22 Clock Oscillator and Input](#22-clock-oscillator-and-input)
  - [22.1 Using the Internal Clock](#221-using-the-internal-clock)
  - [22.2 Using an External Clock](#222-using-an-external-clock)
    - [22.2.1 Considerations on the Frequency](#2221-considerations-on-the-frequency)
- [23 Absolute Maximum Ratings](#23-absolute-maximum-ratings)
- [24 Electrical Characteristics](#24-electrical-characteristics)
  - [24.1 Operational Range](#241-operational-range)
  - [24.2 DC and Timing Characteristics](#242-dc-and-timing-characteristics)
  - [24.3 Thermal Characteristics](#243-thermal-characteristics)
- [25 Layout Considerations](#25-layout-considerations)
  - [25.1 Exposed Die Pad](#251-exposed-die-pad)
  - [25.2 Wiring GND](#252-wiring-gnd)
  - [25.3 Wiring Bridge Supply](#253-wiring-bridge-supply)
  - [25.4 Supply Filtering](#254-supply-filtering)
  - [25.5 Layout Example](#255-layout-example)
- [26 Package Mechanical Data](#26-package-mechanical-data)
  - [26.1 Dimensional Drawings TQFP48-EP](#261-dimensional-drawings-tqfp48-ep)
  - [26.2 Package Codes](#262-package-codes)
- [27 Disclaimer](#27-disclaimer)
- [28 ESD Sensitive Device](#28-esd-sensitive-device)
- [29 Designed for Sustainability](#29-designed-for-sustainability)
- [30 Table of Figures](#30-table-of-figures)
- [31 Revision History](#31-revision-history)
- [32 References](#32-references)

## 1 Principles of Operation

The TMC2160 driver chip is an intelligent power component interfacing between a motion controller and a high-power stepper motor. It uses StealthChop, DcStep, CoolStep, and StallGuard2 automatically to optimize every motor movement. The TMC2160 ideally extends the TMC2100 and TMC2130 family to higher voltages and higher motor currents.

##### THE TMC2160 OFFERS TWO BASIC MODES OF OPERATION:

##### MODE 1: Step & Direction Driver

An external high-performance S-ramp motion controller like the TMC4361 or a central CPU generates step & direction signals synchronized to other components like additional motors within the system. The TMC2160 takes care of intelligent current and mode control and delivers feedback on the state of the motor. The MicroPlyer automatically smoothens motion.

##### MODE 2: Simple Step & Direction Driver

The TMC2160 positions the motor based on step & direction signals. The MicroPlyer automatically smoothens motion. No CPU interaction is required; configuration is done by hardware pins. Basic standby current control can be done by the TMC2160. Optional feedback signals allow error detection and synchronization. Enable this mode by tying pin SPI_MODE low.

**Figure 1.1 TMC2160 STEP/DIR application diagram**

**Figure 1.2 TMC2160 standalone driver application diagram**

### 1.1 Key Concepts

The TMC2160 implements advanced features which are exclusive to TRINAMIC products. These features contribute toward greater precision, greater energy efficiency, higher reliability, smoother motion, and cooler operation in many stepper motor applications.

- **_StealthChop2_ ™** No-noise, high-precision chopper algorithm for inaudible motion and inaudible standstill of the motor. Allows faster motor acceleration and deceleration than StealthChop™ and extends StealthChop to low stand still motor currents.

- **_SpreadCycle_ ™** High-precision chopper algorithm for highly dynamic motion and absolutely clean current wave. Low noise, low resonance and low vibration chopper.

- **_DcStep™_** Load dependent speed control. The motor moves as fast as possible and never loses a step.

- **_StallGuard2_ ™** Sensorless stall detection and mechanical load measurement. **_CoolStep_ ™** Load-adaptive current control reducing energy consumption by as much as 75%. **_MicroPlyer™_** Microstep interpolator for obtaining full 256 microstep smoothness with lower resolution step inputs starting from fullstep

In addition to these performance enhancements, TRINAMIC motor drivers offer safeguards to detect and protect against shorted outputs, output open circuit, overtemperature, and undervoltage conditions for enhancing safety and recovery from equipment malfunctions.

### 1.2 Control Interfaces

The TMC2160 supports an SPI interface for parameter setting and diagnostics. Additionally, a standalone mode is provided for pure STEP/DIR operation without use of the serial interface. Selection of the actual interface is done via the configuration pin SPI_MODE, which can be hardwired to GND or VCC_IO depending on the desired interface.

#### 1.2.1 SPI Interface

The SPI interface is a bit-serial interface synchronous to a bus clock. For every bit sent from the bus master to the bus node another bit is sent simultaneously from the node to the master. Communication between an SPI master and the TMC2160 node always consists of sending one 40-bit command word and receiving one 40-bit status word.

The SPI command rate typically is a few commands per complete motor motion.

### 1.3 Software

From a software point of view the TMC2160 is a peripheral with a number of control and status registers. Most of them can either be written only or read only. Some of the registers allow both read and write access. In case read-modify-write access is desired for a write only register, a shadow register can be realized in master software.

### 1.4 Moving the Motor

#### 1.4.1 STEP/DIR Interface

The motor is controlled by a step and direction input. Active edges on the STEP input can be rising edges or both rising and falling edges as controlled by another mode bit ( _dedge_ ). Using both edges cuts the toggle rate of the STEP signal in half, which is useful for communication over slow interfaces such as optically isolated interfaces. On each active edge, the state sampled from the DIR input determines whether to step forward or back. Each step can be a fullstep or a microstep, in which there are 2, 4, 8, 16, 32, 64, 128, or 256 microsteps per fullstep. A step impulse with a low state on DIR increases the microstep counter and a high state decreases the counter by an amount controlled by the microstep resolution. An internal table translates the counter value into the sine and cosine values which control the motor current for microstepping.

#### 1.4.2 SPI direct mode

The direct mode allows control of both motor coil currents and polarity via SPI. It mainly is intended for use with a dedicated external motion controller IC with integrated sequencer. The sequencer applies sine and cosine waves to the motor coils. This mode is specially designed for combination with the TMC4361 motion controller.

### 1.5 Automatic Standstill Power Down

An automatic current reduction drastically reduces application power dissipation and cooling requirements. Modify stand still current, delay time and decay via register settings. Automatic freewheeling and passive motor braking are provided as an option for stand still. Passive braking reduces motor standstill power consumption to zero, while still providing effective dampening and braking! An option for faster detection of standstill is provided for use with highly frequent motion commands.

**Figure 1.3 Automatic Motor Current Power Down**

### 1.6 StealthChop2 & SpreadCycle Driver

StealthChop is a voltage chopper-based principle. It especially guarantees that the motor is absolutely quiet in standstill and in slow motion, except for noise generated by ball bearings. Unlike other voltage mode choppers, StealthChop2 does not require any configuration. It automatically learns the best settings during the first motion after power up and further optimizes the settings in subsequent motions. An initial homing sequence is sufficient for learning. Optionally, initial learning parameters can be pre-configured via the interface. StealthChop2 allows high motor dynamics, by reacting at once to a change of motor velocity.

For highest dynamic applications, SpreadCycle is an option to StealthChop2. It can be enabled via input pin (standalone mode) or via SPI interface. StealthChop2 and SpreadCycle may even be used in a combined configuration for the best of both worlds: StealthChop2 for no-noise stand still, silent and smooth performance, SpreadCycle at higher velocity for high dynamics and highest peak velocity at low vibration.

SpreadCycle is an advanced cycle-by-cycle chopper mode. It offers smooth operation and good resonance dampening over a wide range of speed and load. The SpreadCycle chopper scheme automatically integrates and tunes fast decay cycles to guarantee smooth zero crossing performance.

##### Benefits of using StealthChop2:

- Significantly improved microstepping with low-cost motors

- Motor runs smooth and quiet

   - Absolutely no standby noise

- Reduced mechanical resonance yields improved torque

### 1.7 StallGuard2 – Mechanical Load Sensing

StallGuard2 provides an accurate measurement of the load on the motor. It can be used for stall detection as well as other uses at loads below those which stall the motor, such as CoolStep loadadaptive current reduction. This gives more information on the drive allowing functions like sensorless homing and diagnostics of the drive mechanics.

### 1.8 CoolStep – Load Adaptive Current

CoolStep drives the motor at the optimum current. It uses the StallGuard2 load measurement information to adjust the motor current to the minimum amount required in the actual load situation. This saves energy and keeps the components cool.

##### Benefits are:

- _Energy efficiency_ power consumption decreased up to 75%

- _Motor generates less heat_ improved mechanical precision

- - _Less or no cooling_ improved reliability

- _Use of smaller motor_ less torque reserve required → cheaper motor does the job

Figure 1.4 shows the efficiency gain of a 42mm stepper motor when using CoolStep compared to standard operation with 50% of torque reserve. CoolStep is enabled above 60RPM in the example.

**Figure 1.4 Energy efficiency with CoolStep (example)**

### 1.9 DcStep – Load Dependent Speed

DcStep allows the motor to run near its load limit and at its velocity limit without losing a step. If the mechanical load on the motor increases to the stalling load, the motor automatically decreases velocity so that it can still drive the load. With this feature, the motor will never stall. In addition to the increased torque at a lower velocity, dynamic inertia will allow the motor to overcome mechanical overloads by decelerating. DcStep directly integrates with the ramp generator, so that the target position will be reached, even if the motor velocity needs to be decreased due to increased mechanical load. A dynamic range of up to factor 10 or more can be covered by DcStep without any step loss. By optimizing the motion velocity in high load situations, this feature further enhances overall system efficiency.

##### Benefits are:

   - Motor does not loose steps in overload conditions

- Application works as fast as possible

- Highest possible acceleration automatically

- Highest energy efficiency at speed limit

- Highest possible motor torque using fullstep drive

- Cheaper motor does the job

## 2 Pin Assignments

### 2.1 Package Outline

**Figure 2.1 TMC2160-TA package and pinning TQFP-EP 48 (7x7mm² body, 9x9mm² with leads)**

### 2.2 Signal Descriptions

|**Pin**|**TQFP**|**Type **|**Function**|
|---|---|---|---|
|HB1|1||High sidegate driver output.|
|CB1|2||Bootstrapcapacitorpositive connection.|
|12VOUT|3||Output of internal 11.5V gate voltage regulator and supply pin<br>of low side gate drivers. Attach 2.2µF to 10µF ceramic<br>capacitor to GND plane near to pin for best performance. Use<br>at least 10 times more capacity than for bootstrap capacitors.<br>In case an external gate voltage supply is available, tie VSA<br>and 12VOUT to the external supply.|
|VSA|4||Analog supply voltage for 11.5V and 5V regulator. Normally<br>tied to VS. Provide a 100nF filteringcapacitor.|
|5VOUT|5||Output of internal 5V regulator. Attach 2.2µF to 10µF ceramic<br>capacitor to GNDA near to pin for best performance. Output<br>for VCC supplyof the chip.|
|GNDA|6||AnalogGND. Connect to GNDplane nearpin.|
|SRAL|7|AI|Sense resistor GND connection for phase A. Connect to the<br>GND side of the sense resistor to compensate for voltage drop<br>on the GND interconnection.|
|SRAH|8|AI|Sense resistor for phase A. Connect to the upper side of the<br>sense resistor. A Kelvin connection is preferred with high<br>motor currents. Symmetrical RC-Filtering may be added for<br>SRAL and SRAH to eliminate high frequency switching spikes<br>from other drives or switchingof coil B.|
|SRBH|9|AI|Sense resistor for phase B. Connect to the upper side of the<br>sense resistor. A Kelvin connection is preferred with high<br>motor currents. Symmetrical RC-Filtering may be added for<br>SRBL and SRBH to eliminate high frequency switching spikes<br>from other drives or switchingof coil A.|
|SRBL|10|AI|Sense resistor GND connection for phase B. Connect to the<br>GND side of the sense resistor to compensate for voltage drop<br>on the GND interconnection.|
|TST_MODE|11|DI|Test mode input. Tie to GND usingshort wire.|
|CLK|12|DI|CLK input. Tie to GND using short wire for internal clock or<br>supply external clock. Internal clock-fail over circuit protects<br>against loss of external clock signal.|
|CSN_CFG3|13|DI|SPI chip select input (negative active) (SPI_MODE=1) or<br>Configuration input (SPI_MODE=0)|
|SCK_CFG2|14|DI|SPI serial clock input (SPI_MODE=1) or<br>Configuration input(SPI_MODE=0)|
|SDI_CFG1|15|DI|SPI data input (SPI_MODE=1) or<br>Configuration input (SPI_MODE=0) or<br>Next address input (NAI) for single wire interface.|
|SDO_CFG0|16|DIO|SPI data output (tristate) (SPI_MODE=1) or<br>Configuration input (SPI_MODE=0) or<br>Next address output(NAO)for single wire interface.|
|STEP|17|DI|STEP input|
|DIR|18|DI|DIR input|
|GNDD|19,30||Digital GND. Connect to GNDplane nearpin.|
|VCC_IO|20, 21||3.3V to 5V IO supply voltage for all digital pins. Does not<br>supplyinternal logic circuitry.|
|SPI_MODE|22|DI<br>(pd)|Mode selection input. When tied low, the chip is in standalone<br>mode and pins have their CFG functions. When tied high, the<br>SPI interface is enabled. Integratedpull down resistor.|
|DCEN_<br>CFG4|23|DI<br>(pd)|DcStep enable input (SPI_MODE=1) – leave open or tie to GND<br>for normal operation in this mode (no DcStep).<br>Configuration input (SPI_MODE=0)|
|DCIN_<br>CFG5|24|DI<br>(pd)|DcStep gating input for axis synchronization (SPI_MODE=1) or<br>Configuration input(SPI_MODE=0)|
|DCO_<br>CFG6|25|DIO|DcStep ready output.<br>Configuration input(SPI_MODE=0)|
|DIAG0|26|DO<br>(pu+<br>pd)|Diagnostics output DIAG0.<br>Interrupt output<br>Use external pullup resistor with 47k or less in open drain<br>mode.|
|DIAG1|27|DO<br>(pd)|Diagnostics output DIAG1.<br>Use external pullup resistor with 47k or less in open drain<br>mode.|
|DRV_ENN|28|DI|Enable input. The power stage becomes switched off (all<br>motor outputs floating) when this pin becomes driven to a<br>high level.|
|VCC|29||5V supply input for digital circuitry within chip. Provide 100nF<br>or bigger capacitor to GND (GND plane) near pin. Shall be<br>supplied by 5VOUT. A 2.2 or 3.3 Ohm resistor is recommended<br>for decouplingnoise from 5VOUT.|
|CPO|31||Chargepumpcapacitor output.|
|CPI|32||Charge pump capacitor input. Tie to CPO using 22nF, 100V<br>capacitor.|
|VS|33||Motor supply voltage. Provide filtering capacity near pin with<br>short loop to GND plane. Must be tied to the positive bridge<br>supplyvoltage.|
|VCP|34||Chargepumpvoltage. Tie to VS using100nF capacitor.|
|CA2|35||Bootstrapcapacitorpositive connection.|
|HA2|36||High sidegate driver output.|
|BMA2|37||Bridge Center and bootstrapcapacitor negative connection.|
|LA2|38||Low sidegate driver output.|
|LA1|39||Low sidegate driver output.|
|BMA1|40||Bridge Center and bootstrapcapacitor negative connection.|
|HA1|41||High sidegate driver output.|
|CA1|42||Bootstrapcapacitorpositive connection.|
|CB2|43||Bootstrapcapacitorpositive connection.|
|HB2|44||High sidegate driver output.|
|BMB2|45||Bridge Center and bootstrapcapacitor negative connection.|
|LB2|46||Low sidegate driver output.|
|LB1|47||Low sidegate driver output.|
|BMB1|48||Bridge Center and bootstrapcapacitor negative connection.|
|Exposed die pad|-||Connect the exposed die pad to a GND plane. Provide as many<br>as possible vias for heat transfer to GND plane. Serves as GND<br>pin for the low side gate drivers. Ensure low loop inductivity<br>to sense resistor GND.|

- *(pd) denominates a pin with pulldown resistor

- All digital pins DI, DIO and DO use VCC_IO level and contain protection diodes to GND and VCC_IO

- All digital inputs DI and DIO have internal Schmitt-Triggers

## 3 Sample Circuits

The following sample circuits show the required external components in different operation and supply modes. The connection of the bus interface and further digital signals are left out for clarity.

### 3.1 Standard Application Circuit

**Figure 3.1 Standard application circuit**

The standard application circuit uses a minimum set of additional components. Eight MOSFETs are selected for the desired current, voltage and package type. Two sense resistors set the motor coil current. See chapter 8 to choose the right value for sense resistors. Use low ESR capacitors for filtering the power supply. A minimum capacity of 100µF per ampere of coil current near to the power bridge is recommended for best performance. The capacitors need to cope with the current ripple caused by chopper operation. Current ripple in the supply capacitors also depends on the power supply internal resistance and cable length. VCC_IO can be supplied from 5VOUT, or from an external source, e.g., a 3.3V regulator. To minimize linear voltage regulator power dissipation of the internal 5V and 11.5V voltage regulators in applications where VM is high, a different (lower) supply voltage should be used for VSA (see chapter 3.2).

##### Basic layout hints

Place sense resistors and all filter capacitors as close as possible to the power MOSFETs. Place the TMC2160 near to the MOSFETs and use short interconnection lines to minimize parasitic trace inductance. Use a solid common GND for all GND, GNDA and GNDD connections, also for sense resistor GND. Connect 5VOUT filtering capacitor directly to 5VOUT and GNDA pin. See layout hints for more details. Low ESR electrolytic capacitors are recommended for VS filtering.

> **Hint:** In safety critical applications, VS and the bridge may be supplied by a separate, switched supply to realize safe torque off. Make sure that the slope at VS does not exceed 1V/µs.

> **Attention:** Provide overvoltage protection in case the motor could be manually turned at a high velocity, or in case the driver could become cut off from the main supply capacitors. Significant energy can be fed back from motor coils to the power supply in the event of quick deceleration, or when the driver becomes disabled.

> **Attention:** In addition to filtering capacity near to the power bridges, provide sufficient capacity on VS located close to the VS pin and the connection of the VCP capacitor, to ensure that high-frequency ripple, caused by the switching edges of the power bridge transistors are kept well below 0.5V. An RC filter may be required (see Figure 3.5).

Keep power on/off slopes below 1V/µs.

Failure to do so can result in destructive currents via the charge pump circuit.

> **Hint:** In cases where supply ripple exceeds 0.5V, a resistor of 100 to 220Ω in series with the 22nF capacitor reduces sensitivity of the charge pump circuit, but also leads to a slightly lower charge pump voltage.

### 3.2 External Gate Voltage Regulator

At high supply voltages like 48V, the internal gate voltage regulator and the internal 5V regulator have considerable power dissipation, especially with high MOSFET gate charges, high chopper frequency or high system clock frequency >12MHz. A good thermal coupling of the heat slug to the system PCB GND plane is required to dissipate heat. Still, the thermal thresholds will be lowered significantly by self-heating. To reduce power dissipation, supply an external gate driver voltage to the TMC2160. Figure 3.2 shows the required connection. The internal gate voltage regulator becomes disabled in this constellation. 12V +/-1V are recommended for best results.

12V Gate Voltage

**Figure 3.2 External gate voltage supply**

> **Hint:** With MOSFETs above 50nC of total gate charge, chopper frequency >40kHz, or at clock frequency >12MHz, it is recommended to use a VSA supply not higher than 40V.

> **Attention:** In case VSA is supplied by a different voltage source, make sure that VSA does not drop out during motor operation. Stop and disable the motor before VSA power down. This is not necessary, when VSA voltage is derived from VS supply, as both supplies go down in parallel in this case.

### 3.3 Choosing MOSFETs and Slope

The selection of power MOSFETs depends on several factors, like package size, on-resistance, voltage rating and supplier. It is not true, that larger, lower RDSon MOSFETs will always be better, as a larger device also has higher capacitances and may add more ringing in trace inductance and power dissipation in the gate drive circuitry. Adapt the MOSFETs to the required motor voltage (adding 5-10V of reserve to the peak supply voltage) and to the desired maximum current, in a way that resistive power dissipation still is low for the thermal capabilities of the chosen MOSFET package. The TMC2160 drives the MOSFET gates with roughly 10V, so normal, 10V specified types are sufficient. Logic level FETs (4.5V specified RDSon) will also work, but may be more critical with regard to bridge crossconduction due to lower VGS(th).

The gate drive current and MOSFET gate resistors RG (optional) determine switching behavior and should basically be adapted to the MOSFET gate-drain charge (Miller charge). Figure 3.3 shows the influence of the Miller charge on the switching event. Figure 3.4 additionally shows the switching events in different load situations (load pulling the output up or down), and the required bridge brake-before-make time.

The following table shall serve as a thumb rule for programming the MOSFET driver current ( _DRVSTRENGTH_ setting) and the selection of gate resistors:

**MOSFET MILLER CHARGE VS. DRVSTRENGTH AND RG**

|**Miller Charge**<br>**[nC] (typ.)**|_DRVSTRENGTH_<br>setting|**Value of RG [Ω]**|
|---|---|---|
|<10|0|≤ 15|
|10…20|0 or 1|≤ 10|
|20…40|1 or 2|≤ 7.5|
|40…60|2 or 3|≤ 5|
|>60|3|≤ 2.7|

The TMC2160 provides increased gate-off drive current to avoid bridge cross-conduction induced by high dV/dt. This protection will be less efficient with gate resistors exceeding the values given in the table. Therefore, for larger values of RG, a parallel diode may be required to ensure keeping the MOSFET safely off during switching events.

**Figure 3.3 Miller charge determines switching slope**

- _Hints_

- Choose modern MOSFETs with fast and soft recovery bulk diode and low reverse recovery charge.

- A small, SMD MOSFET package allows compacter routing and reduces parasitic inductance effects.

**Figure 3.4 Slopes, Miller plateau and blank time**

The following _DRV_CONF_ parameters allow adapting the driver to the MOSFET bridge:

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_BBMTIME_|Break-before-make time setting to ensure non-<br>overlapping switching of high-side and low-side<br>MOSFETs._BBMTIME_allows fine tuning of times in<br>increments shorter than a clock period.<br>For higher times,use BBMCLKS.|<br> <br>0…24|time[ns]<br>100ns*32/(32-_BBMTIME_)<br>_Ensure ~30% headroom_<br>_Reset Default: 0_|
|_BBMCLKS_|Like_BBMTIME_, but in multiple of a clock cycle.<br>The longer settingrules(_BBMTIME_vs._BBMCLKS_).|0…15|0: off<br>_Reset Default: OTP 4 or 2_|
|_DRV_<br>_STRENGTH_|Selection of gate driver current. Adapts the gate<br>driver current to the gate charge of the external<br>MOSFETs.|<br>0…3|_Reset Default = 0_|
|_FILT_ISENSE_|Filter time constant of sense amplifier to suppress<br>ringing and coupling from second coil operation<br>_Hint:_Increase setting if motor chopper noise<br>occurs due to cross-coupling of both coils.<br>_(Reset Default = %00)_|<br> <br>0…3|00: ~100ns (_reset default_)<br>01: ~200ns<br>10: ~300ns<br>11: ~400ns|

##### DRVCONF Parameters

Use the lowest gate driver strength setting _DRVSTRENGTH_ giving favorable switching slopes, before increasing the value of the gate series resistors. A slope time of nominal 40ns to 80ns is sufficient and will normally be covered by the shortest possible Break-Before-Make time setting ( _BBMTIME_ =0, _BBMCLKS_ =0).

In case slower slopes have to be used, e.g., with large MOSFETs, ensure that the break-before-make time ( _BBMTIME_ , optionally use _BBMCLKS_ for times >200ns) sufficiently covers the switching event, in order to avoid bridge cross conduction. The shortest break-before-make time, safely covering the switching event, gives best results. Add roughly 30% of reserve, to cover production stray of MOSFETs and driver.

### 3.4 Tuning the MOSFET Bridge

A clean switching event is favorable to ensure low power dissipation and good EMC behavior. Unsuitable layout or components endanger stable operation of the circuit. Therefore, it is important to understand the effect of parasitic trace inductivity and MOSFET body diode reverse recovery.

Stray inductance in power routing will cause ringing whenever the opposite MOSFET is in diode conduction prior to switching on a low-side or high-side MOSFET. Diode conduction occurs during break-before make time while the load current is inverse to the following bridge polarity. The MOSFET bulk diode has a certain, type specific reverse recovery time and charge. This time typically is in the range of a few 10ns. During reverse recovery time, the bulk diode will cause high current flow across the bridge. This current is taken from the power supply filter capacitors (see thick lines Figure 3.5). Once the diode opens, parasitic inductance tries to keep the current flowing. A high, fast slope results and leads to ringing in parasitic inductivities in the current path (see Figure 3.6). This may lead to bridge voltage undershooting the GND level as well as short pulses on VS and all MOSFET connections. It must be ensured, that the driver IC does not see spikes on its BM pins undershooting GND more than 5V. Severe VS ripple might overload the charge-pump circuitry. Measure the voltage directly at the driver pins to driver GND. The amount of undershooting depends on energy stored in parasitic inductivities from low side drain to low side source and via the sense resistor RS to GND.

When using relatively small MOSFETs, a soft slope control requires a high gate series resistance. This endangers safe MOSFET switch off. Add additional diodes to ensure safe MOSFET off conditions in this case (shown for right MOSFET pair in Figure 3.5).

Figure 3.7 shows performance of the basic circuit after adapting switching slope and adding 1nF bridge output capacitors.

**Figure 3.5 Bridge protection options for power routing inductivity**

##### ENSURE RELIABLE OPERATION

- Use SMD MOSFETs and short interconnections

- Provide sufficient power filtering capacity close to the bridge and close to VS pin & VCP capacitor

- Tune MOSFET switching slopes (measure switch-on event at MOSFET gate) to be slower than the MOSFET bulk diode reverse recovery time. This will reduce cross conduction.

- Add optional gate resistors close to MOSFET gate and output capacitors to ensure clean switching and reliable operation by minimizing ringing. Figure 3.5  shows the options plus some variations.

   - Some MOSFETs eliminate reverse recovery charge by integrating a fast diode from source to drain.

**Figure 3.6 Ringing of output (blue) and Gate voltages (Yellow, Purple) with untuned brige**

**Figure 3.7 Switching event with optimized components (without / after bulk diode conduction)**

##### BRIDGE OPTIMIZATION EXAMPLE

A stepper driver for 6A of motor current has been designed using the MOSFET AOD4126 in the standard schematic.

The MOSFETs have a low gate capacitance and offer roughly 50ns slope time at the lowest driver strength setting. At lowest driver strength setting, switching quality is best (Figure 3.6), but still shows a lot of ringing. Low side gate resistors have been added to slightly increase switching slope time following high-side bulk diode conduction by increasing the effect of Gate-Drain (Miller) charge. High side gate resistors have been added for symmetry. Tests showed, that 1nF output capacitors dramatically reduce ringing of the power bridge following bulk diode conduction (Figure 3.7). Figure 3.8 shows the actual components and values after optimization.

**Figure 3.8 Example for bridge with tuned components (see scope shots)**

##### BRIDGE LAYOUT CONSIDERATIONS

- Tune the bridge layout for minimum loop inductivity. A compact layout is best.

- Keep MOSFET gate connections short and straight and avoid loop inductivity between BM and corresponding HS driver pin. Loop inductance is minimized with parallel traces, or adjacent traces on adjacent layers. A wider trace reduces inductivity (don’t use minimum trace width).

- Minimize the length of the sense resistor connection to low-side MOSFET source and place the TMC2160 near the sense resistor’s GND connection, with its GND connections directly connected to the same GND plane.

- Optimize switching behavior by tuning gate current setting and gate resistors. Add MOSFET bridge output capacitors (470pF to a few nF) to reduce ringing.

- Measure the performance of the bridge by probing BM pins directly at the bridge or at the TMC2160 using a short GND tip on the scope probe rather than a GND cable, if available.

## 4 SPI Interface

### 4.1 SPI Datagram Structure

The TMC2160 uses 40-bit SPI™ (Serial Peripheral Interface, SPI is Trademark of Motorola) datagrams for communication with a microcontroller. Microcontrollers which are equipped with hardware SPI are typically able to communicate using integer multiples of 8 bit. The CSN line of the device must be handled in a way, that it stays active (low) for the complete duration of the datagram transmission.

Each datagram sent to the device is composed of an address byte followed by four data bytes. This allows direct 32-bit data word communication with the register set. Each register is accessed via 32 data bits even if it uses less than 32 data bits.

For simplification, each register is specified by a one-byte address:

- For a read access the most significant bit of the address byte is 0.

- For a write access the most significant bit of the address byte is 1.

Most registers are write-only registers, some can be read additionally, and there are also some read only registers.

**SPI DATAGRAM STRUCTURE**

|MSB (transmitted first)|||40|bit|||LSB (transmitted last)|
|---|---|---|---|---|---|---|---|
|39 ...|||||||... 0|
|→**8 bit address**<br>**8 bit SPI status**|| →|**32 bit dat**|**a**||||
|39 ... 32||||31|... 0|||
|→toTMC2160<br>RW + 7 bit address<br>fromTMC2160<br>8 bit SPI status|8 bit|data|8 bit|data|8 bit|data|8 bit data|
|39 / 38 ... 32|31 ..|. 24|23 ..|. 16|15 .|.. 8|7 ... 0|
|**W**<br>38...32|31...28|27...24|23...20|19...16|15...12|11...8|7...4<br>3...0|
|3<br>9<br>3<br>8<br>3<br>7<br>3<br>6<br>3<br>5<br>3<br>4<br>3<br>3<br>3<br>2|<br>3<br>1<br>3<br>0<br>2<br>9<br>2<br>8|<br>2<br>7<br>2<br>6<br>2<br>5<br>2<br>4|2<br>3<br>2<br>2<br>2<br>1<br>2<br>0|<br>1<br>9<br>1<br>8<br>1<br>7<br>1<br>6|<br>1<br>5<br>1<br>4<br>1<br>3<br>1<br>2|<br>1<br>1<br>1<br>0<br>9<br>8|7<br>6<br>5<br>4<br>3<br>2<br>1<br>0|

#### 4.1.1 Selection of Write / Read (WRITEnotREAD)

The read and write selection is controlled by the MSB of the address byte (bit 39 of the SPI datagram). This bit is 0 for read access and 1 for write access. So, the bit named W is a WRITE_notREAD control bit. The active high write bit is the MSB of the address byte. So, 0x80 has to be added to the address for a write access. The SPI interface always delivers data back to the master, independent of the W bit. The data transferred back is the data read from the address, which was transmitted with the _previous_ datagram, if the previous access was a read access. If the previous access was a write access, then the data read back mirrors the previously received write data. So, the difference between a read and a write access is that the read access does not transfer data to the addressed register, but it transfers the address only and its 32 data bits are dummies, and, further the following read or write access delivers back the data read from the address transmitted in the preceding read cycle.

A read access request datagram uses dummy write data. Read data is transferred back to the master with the subsequent read or write access. Hence, reading multiple registers can be done in a <u>pipelined fashion.</u>

Whenever data is read from or written to the TMC2160, the MSBs delivered back contain the SPI status, _SPI_STATUS_ , a number of eight selected status bits.

##### Example :

For a read access to the register ( _TSTEP_ ) with the address 0x12, the address byte has to be set to 0x12 in the access preceding the read access. For a write access to the register ( _IHOLD_IRUN_ ), the address byte has to be set to 0x80 + 0x10 = 0x90. For read access, the data bits might have any value (-). So, one can set them to 0.

|action|data sent to TMC2160|data received from TMC2160|
|---|---|---|
|read_TSTEP_|→ `0x1200000000`| `0xSS & unused data`|
|read_TSTEP_|→ `0x1200000000`| `0xSS & TSTEP`|
|write_IHOLD_IRUN_:=`0x00011F10`|→ `0x9000ABCDEF`| `0xSS & TSTEP`|
|write_IHOLD_IRUN_:=`0x00021807`|→ `0x9000123456`| `0xSS00011F10`|

- `*)S:` is a placeholder for the status bits _SPI_STATUS_

#### 4.1.2 SPI Status Bits Transferred with Each Datagram Read Back

New status information becomes latched at the end of each access and is available with the next SPI transfer.

**_SPI_STATUS –_ status flags transmitted with each SPI access in bits 39 to 32**

|**Bit**|**Name**|**Comment**|
|---|---|---|
|7|_Unused_|Ignore this bit|
|6|_Unused_|Ignore this bit|
|5|_Unused_|Ignore this bit|
|4|_Unused_|Ignore this bit|
|3|_standstill_|_DRV_STATUS_[31]– 1: Signals motor stand still|
|2|_sg2 _|_DRV_STATUS_[24]– 1:  Signals StallGuard flagactive|
|1|_driver_error_|_GSTAT_[1]– 1:  Signals driver 1 driver error(clear_GSTAT_to reset)|
|0|_reset_flag_|_GSTAT_[0]– 1: Signals,that a reset has occurred(clear_GSTAT_to reset)|

#### 4.1.3 Data Alignment

All data are right aligned. Some registers represent unsigned (positive) values, some represent integer values (signed) as two’s complement numbers, single bits or groups of bits are represented as single bits respectively as integer groups.

### 4.2 SPI Signals

The SPI bus on the TMC2160 has four signals:

- SCK – bus clock input

- SDI – serial data input

- SDO – serial data output

- CSN – chip select input (active low)

The node is enabled for an SPI transaction by a low on the chip select input CSN. Bit transfer is synchronous to the bus clock SCK, with the node latching the data from SDI on the rising edge of SCK and driving data to SDO following the falling edge. The most significant bit is sent first. A minimum of 40 SCK clock cycles is required for a bus transaction with the TMC2160.

If more than 40 clocks are driven, the additional bits shifted into SDI are shifted out on SDO after a 40-clock delay through an internal shift register. This can be used for daisy chaining multiple chips.

CSN must be low during the whole bus transaction. When CSN goes high, the contents of the internal shift register are latched into the internal control register and recognized as a command from the master to the node. If more than 40 bits are sent, only the last 40 bits received before the rising edge of CSN are recognized as the command.

### 4.3 Timing

The SPI interface is synchronized to the internal system clock, which limits the SPI bus clock SCK to half of the system clock frequency. If the system clock is based on the on-chip oscillator, an additional 10% safety margin must be used to ensure reliable data transmission. All SPI inputs as well as the DRV_ENN input are internally filtered to avoid triggering on pulses shorter than 20ns. Figure 4.1 shows the timing parameters of an SPI bus transaction, and the table below specifies their values.

**Figure 4.1 SPI timing**

_Hint_ Usually this SPI timing is referred to as SPI MODE 3

|**SPI interface timing**|**AC-Chara**<br>clockperi|**cteristics**<br>od: tCLK|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|SCK valid before or after change<br>of CSN|tCC||10|||ns|
|CSN high time|tCSH|*) Min time is for<br>synchronous CLK<br>with SCK high one<br>tCHbefore CSN high<br>only|tCLK<br>*)|>2tCLK+10||ns|
|SCK low time|tCL|*) Min time is for<br>synchronous CLK<br>only|tCLK<sup>*)</sup>|>tCLK+10||ns|
|SCK high time|tCH|*) Min time is for<br>synchronous CLK<br>only|tCLK<sup>*)</sup>|>tCLK+10||ns|
|SCK frequency using internal<br>clock|fSCK|assumes minimum<br>OSC frequency|||4|MHz|
|SCK frequency using external<br>16MHz clock|fSCK|assumes<br>synchronous CLK|||8|MHz|
|SDI setup time before rising<br>edge of SCK|tDU||10|||ns|
|SDI hold time after rising edge<br>of SCK|tDH||10|||ns|
|Data out valid time after falling<br>SCK clock edge|tDO|no capacitive load<br>on SDO|||tFILT+5|ns|
|SDI, SCK and CSN filter delay<br>time|tFILT|rising and falling<br>edge|12|20|30|ns|

## 5 Register Mapping

This chapter gives an overview of the complete register set. Some of the registers bundling a number of single bits are detailed in extra tables. The functional practical application of the settings is detailed in dedicated chapters.

_Note_

- All registers become reset to 0 upon power up, unless otherwise noted. - Add 0x80 to the address **Addr** for write accesses!

**NOTATION OF HEXADECIMAL AND BINARY NUMBERS**

|0x|precedes a hexadecimal number,e.g. 0x04|
|---|---|
|%|precedes a multi-bit binarynumber,e.g. %100|
|**NOTATION OFR/W FIELD**||
|R|Read only|
|W|Write only|
|R/W|Read- and writable register|
|R+WC|Clear bywriting“1” bit|

##### OVERVIEW REGISTER MAPPING

**REGISTER DESCRIPTION**

|General Configuration Registers|These registers contain<br>-<br>global configuration<br>-<br>global status flags<br>-<br>interface configuration<br>-<br>and I/O signal configuration|
|---|---|
|Velocity Dependent Driver Feature Control Register<br>Set|This register set offers registers for<br>-<br>driver current control<br>-<br>setting thresholds for CoolStep operation<br>-<br>setting thresholds for different chopper modes<br>-<br>settingthresholds for DcStepoperation|
|Motor Driver Register Set|This register set offers registers for<br>-<br>setting / reading out microstep table and<br>counter<br>-<br>chopper and driver configuration<br>-<br>CoolStep and StallGuard2 configuration<br>-<br>DcStep configuration<br>-<br>reading out StallGuard2 values and driver error<br>flags|

### 5.1 General Configuration Registers

**GENERAL CONFIGURATION REGISTERS (0X00…0X0F)**

|**R/W**|**Addr**|**n**|**_Register_**|**Descri**|**ption /****_bit names_**|
|---|---|---|---|---|---|
|||||**Bit**|**_GCONF_ – Global configuration flags **|
|||||0<br>|_recalibrate_<br>1:<br>Zero crossing recalibration during driver disable<br>(via DRV_ENN or via_TOFF_setting)<br>|
|||||1|_faststandstill_<br>Timeout for step execution until standstill detection:<br>1:<br>Short time: 2^18 clocks<br>0:<br>Normal time: 2^20 clocks|
|||||2|_en_pwm_mode_|
||||||1:<br>StealthChop<br>voltage<br>PWM<br>mode<br>enabled<br>(depending on velocity thresholds). Switch from<br>off to on state while in stand-still and at IHOLD=<br>nominal IRUN current,only.|
|||||3|_multistep_filt_<br>1:<br>Enable step input filtering for StealthChop<br>optimization with external stepsource(default=1)|
|||||4|_shaft_<br>1:<br>Inverse motor direction|
|||||5|_diag0_error_<br>1:<br>Enable DIAG0 active on driver errors:<br>Over temperature (_ot_), short to GND (_s2g_)<br>DIAG0 always shows the reset-status, i.e., is active low<br>duringreset condition.|
|||||6|_diag0_otpw_|
|RW|0x00|18|_GCONF_||1:<br>Enable DIAG0 active on driver over temperature<br>prewarning(_otpw_)|
|||||7|_diag0_stall_<br>1:<br>Enable DIAG0 active on motor stall (set<br>_TCOOLTHRS_before usingthis feature)|
|||||8|_diag1_stall_<br>1:<br>Enable DIAG1 active on motor stall (set<br>_TCOOLTHRS_before usingthis feature)|
|||||9|_diag1_index_<br>1:<br>Enable DIAG1 active on index position (microstep<br>look uptableposition 0)|
|||||10|_diag1_onstate_<br>1:<br>Enable DIAG1 active when chopper is on (for the<br>coil which is in the second half of the fullstep)|
|||||11|_diag1_steps_skipped_<br>1:<br>Enable output toggle when steps are skipped in<br>DcStep mode (increment of_LOST_STEPS_). Do not<br>enable in conjunction with other DIAG1 options.|
|||||12|_diag0_int_pushpull_<br>0:<br>DIAG0 is open collector output (active low)<br>1:<br>Enable DIAG0pushpull output(active high)|
|||||13|_diag1_pushpull_<br>0:<br>DIAG1 is open collector output (active low)<br>1:<br>Enable DIAG1pushpull output (active high)|
|||||14|_small_hysteresis_<br>0:<br>Hysteresis for step frequency comparison is 1/16<br>1:<br>Hysteresis for stepfrequencycomparison is 1/32|
|||||15|_stop_enable_|
||||||<br>0:<br>Normal operation<br>1:<br>Emergency stop: ENCA_DCIN stops the sequencer<br>when tied high (no steps become executed by<br>the sequencer,motorgoes to standstill state).|
|||||16|_direct_mode_<br>0:<br>Normal operation<br>1:<br>Motor<br>coil<br>currents<br>and<br>polarity<br>directly<br>programmed via serial interface: Register_XDIRECT_<br>(0x2D) specifies signed coil A current (bits 8..0)<br>and coil B current (bits 24..16). In this mode, the<br>current is scaled by_IHOLD_setting. Velocity based<br>current regulation of StealthChop is not available<br>in this mode. The automatic StealthChop current<br>regulation will work only for low stepper motor<br>velocities.|
|||||17|_test_mode_<br>0:<br>Normal operation<br>1:<br>Enable<br>analog<br>test output<br>on<br>pin<br>DCO.<br>_IHOLD_[1..0]<br>selects<br>the<br>function<br>of<br>DCO:<br>0…2: T120, DAC, VDDH<br>|
||||||_Hint:_Not for user,set to 0 for normal operation!|
|||||**Bit**<br>|**_GSTAT_ – Global status flags**<br>(Re-Write with ‘1’ bit to clear respective flags)<br>|
|||||0|_reset_|
||||||1:<br>Indicates that the IC has been reset. All registers<br>have been cleared to reset values.|
|R+<br>WC|0x01|3|_GSTAT_|1|_drv_err_<br>1:<br>Indicates, that the driver has been shut down<br>due to overtemperature or short circuit detection.<br>Read DRV_STATUS for details. The flag can only<br>be cleared when the temperature is below the<br>limit again.|
|||||2|_uv_cp_<br>1:<br>Indicates an undervoltage on the charge pump.<br>The driver is disabled during undervoltage. This<br>flagis latched for information.|
|||||**Bit**|**_INPUT_**|
||||||Reads the state of all inputpins available|
|||||0<br>|STEP<br>|
|||||1|DIR|
|||||2|DCEN_CFG4|
|||||3|DCINCFG5|
|||8||4|_<br>DRV_ENN|
|R|0x04|<br>+|_IOIN_|5|DCO_CFG6|
|||<br>8||6|1|
|||||7|unused|
|||||31..|_VERSION_: 0x30=first version of the IC|
|||||24|Identical numbers mean full digital compatibility.|
|W|0x06||_OTP_PROG_|**Bit**<br>2..0<br>5..4|**_OTP_PROGRAM_– OTP programming**<br>Write access programs OTP memory (one bit at a time),<br>Read access refreshes read data from OTP after a write<br>_OTPBIT_<br>Selection of OTP bit to be programmed to the selected<br>byte location(n=0..7:programs bit n to a logic 1)<br>_OTPBYTE_<br>Set to 00|
|||||15..8|_OTPMAGIC_<br>Set to_0xbd_to enable programming. A programming<br>time of minimum 10ms per bit is recommended (check<br>byreading _OTPREAD_).|
|R|0x07||_OTP_READ_|**Bit**<br>|___<br>**_OTP_READ_**(Access to OTP memory result and update)<br>_See separate table!_<br>|
|||||7..0|_OTP0_byte 0 read data|
|RW|0x08|5|_FACTORY__<br>_CONF_|4..0|_FCLKTRIM_(_Reset default: OTP_)<br>0…31: Lowest to highest clock frequency. Check at<br>charge pump output. The frequency span is not<br>guaranteed, but it is tested, that tuning to 12MHz<br>internal clock is possible. The devices come preset to<br>12MHz clock frequency by OTP programming.<br>_(Reset Default: OTP)_|
|||||**Bit**|**_SHORT_CONF_**|
|||||3..0|_S2VS_LEVEL_:<br>Short to VS detector level for lowside FETs. Checks for<br>voltage drop in LS MOSFET and sense resistor.<br>4 (highest sensitivity) … 15 (lowest sensitivity)<br>_Hint:_Settings from 1 to 3 will trigger during normal<br>operation due to voltage drop on sense resistor.<br>_(Reset Default: OTP 6 or 12)_|
|W|0x09|19|_SHORT__<br>_CONF_|11..8|_S2G_LEVEL_:<br>Short to GND detector level for highside FETs. Checks<br>for voltage drop on high side MOSFET<br>2 (highest sensitivity) … 15 (lowest sensitivity)<br>_Attention: Settings below 6 not recommended at >52V_<br>_operation – false detection might result_<br>_(Reset Default: OTP 6 or 12)_|
|||||17..16|_SHORTFILTER_:<br>Spike filtering bandwidth for short detection<br>0 (lowest, 100ns), 1 (1µs), 2 (2µs) 3 (3µs)<br>_Hint:_A good PCB layout will allow using setting 0.<br>Increase value, if erroneous short detection occurs.<br>_(Reset Default = %01)_|
|||||18|_shortdelay_: Short detection delay<br>0=750ns: normal, 1=1500ns: high<br>The short detection delay shall cover the bridge<br>switching time. 0 will work for most applications.<br>_(Reset Default = 0)_|

|**GENER**<br>|**AL CONFIG**<br>|**URATI**|**ON REGISTERS**<br>|**(0X00…0X**<br>|**0F)**<br>|
|---|---|---|---|---|---|
|**R/W**|**Addr**|**n**|**_Register_**|**Descri**|**tion /****_bit names_**|
|||||**Bit**|**DRV_CONF**|
|||||4..0|_BBMTIME:_<br>Break-Before make delay<br>0=shortest (100ns) … 16 (200ns) … 24=longest (375ns)<br>>24 not recommended, use_BBMCLKS_instead<br>_Hint:_Choose the lowest setting safely covering the<br>switching event to avoid bridge cross-conduction. Add<br>roughly 30% of reserve.<br>_(Reset Default = 0)_|
|||||11..8|_BBMCLKS_:<br>0..15: Digital BBM time in clock cycles (typ. 83ns).<br>The longer setting rules (_BBMTIME_vs._BBMCLKS_).<br>_(Reset Default: OTP 4 or 2)_|
|||||17..16|_OTSELECT_:<br>Selection of over temperature level for bridge disable,<br>switch on after cool down to 120°C / OTPW level.<br>00: 150°C<br>01: 143°C<br>10: 136°C (not recommended when VSA > 24V)<br>11: 120°C (not recommended, no hysteresis)|
|W|0x0A|22|_DRV_CONF_||_Hint:_Adapt overtemperature threshold as required to<br>protect the MOSFETs or other components on the PCB.<br>_(Reset Default = %00)_|
|||||19..18|_DRVSTRENGTH_:<br>Selection of gate driver current. Adapts the gate driver<br>current to the gate charge of the external MOSFETs.<br>00: weak<br>01: weak+TC (medium above OTPW level)<br>10: medium<br>11: strong|
||||||_Hint:_Choose the lowest setting giving slopes <100ns.<br>_(Reset Default = %00)_|
|||||21..20|_FILT_ISENSE_:<br>Filter time constant of sense amplifier to suppress<br>ringing and coupling from second coil operation<br>00: low – 100ns<br>01:<br>– 200ns<br>10:<br>– 300ns<br>11: high– 400ns|
||||||_Hint:_Increase setting if motor chopper noise occurs<br>due to cross-coupling of both coils.<br>_(Reset Default = %00)_|
|**R/W**|**Addr**|**n**|**_Register_**|**Descrip**|**tion /****_bit names_**|
|W|0x0B|8|_GLOBAL_<br>_SCALER_|7..0|Global scaling of Motor current. This value is multiplied<br>to the current scaling in order to adapt a drive to a<br>certain motor type. This value should be chosen before<br>tuning other settings because it also influences<br>chopper hysteresis.<br>0:<br>Full Scale (or write 256)<br>1 … 31:<br>Not allowed for operation<br>32 … 255: 32/256 … 255/256 of maximum current.|
||||||_Hint:_Values >128 recommended for best results<br>_(Reset Default = 0)_|
|R|00C|16|_OFFSET__|15..8|Offset calibration resultphase A (signed)|
||x||_READ_|7..0|Offset calibration resultphase B(signed)|

#### 5.1.1 OTPREAD – OTP configuration memory

The OTP memory holds power up defaults for certain registers. All OTP memory bits are cleared to 0 by default. Programming only can set bits, clearing bits is not possible. Factory tuning of the clock frequency affects _otp0.0_ to _otp0.4_ . The state of these bits therefore may differ between individual ICs.

|**0X07**<br>|**: ****_OTP_REA_**<br>|**_D – _OTP MEMORY MAP**<br>||
|---|---|---|---|
|**Bit**|**Name**|**Function**|**Comment**|
|7|_otp0.7_|_otp_TBL_|Reset default for_TBL_:<br>0:_TBL_=%10 (~3µs)<br>1:_TBL_=%01 (~2µs)|
|6|_otp0.6_|_otp_BBM_|Reset default for_DRVCONF.BBMCLKS_<br>0:_BBMCLKS_=4<br>1:_BBMCLKS_=2|
|5|_otp0.5_|_otp_S2_LEVEL_|Reset default for_short-detection Levels_:<br>0:_S2G_LEVEL = S2VS_LEVEL = 6_<br>1:_S2G_LEVEL = S2VS_LEVEL = 12_|
|4|_otp0.4_|_OTP_FCLKTRIM_|Reset default for_FCLKTRIM_|
|3|_otp0.3_||0: lowest frequency setting|
|2|_otp0.2_||31: highest frequency setting|
|1|_otp0.1_||_Attention: This value is pre-programmed by factory clock_|
|0|_otp0.0_||_trimming to the default clock frequency of 12MHz and_<br>_differs between individual ICs! It should not be altered._|

### 5.2 Velocity Dependent Driver Feature Control Register Set

**VELOCITY DEPENDENT DRIVER FEATURE CONTROL REGISTER SET (0X10…0X1F)**

|**R/W**|**Addr**|**n**|**_Register_**|**Description /****_bit names_**<br> <br>|
|---|---|---|---|---|
|||||**Bit**<br>**_IHOLD_IRUN_– Driver current control**|
|W|0x10|5<br>+<br>5<br>+<br>4|_IHOLD_IRUN_|4..0_IHOLD_<br>Standstill current (0=1/32…31=32/32)<br>In combination with StealthChop mode, setting<br>_IHOLD_=0 allows to choose freewheeling or coil<br>short circuit for motor stand still.<br>12..8_IRUN_<br>Motor run current (0=1/32…31=32/32)<br>_Hint:_Choose sense resistors in a way, that normal<br>IRUN is 16 to 31 for best microstep performance.<br>19..16_IHOLDDELAY_<br>Controls the number of clock cycles for motor<br>power down after a motion as soon as standstill is<br>detected (_stst_=1) and_TPOWERDOWN_has expired.<br>The smooth transition avoids a motor jerk upon<br>power down.|
|||||0:<br>instant power down<br>1..15:  Delay per current reduction step in multiple<br>of 2^18 clocks|
|W|0x11|8|_TPOWER_<br>_DOWN_|_TPOWERDOWN_sets the delay time after stand still (_stst_) of the<br>motor to motor current power down. Time range is about 0 to<br>4 seconds.<br>_Attention: A minimum setting of 2 is required to allow_<br>_automatic tuning of StealthChop PWM_OFS_AUTO._<br>_Reset Default = 10_<br>_0…((2^8)-1) *_2^18_tCLK_|
|R|0x12|20|_TSTEP_|Actual measured time between two 1/256 microsteps derived<br>from the step input frequency in units of 1/fCLK. Measured<br>value is (2^20)-1 in case of overflow or stand still.<br>All TSTEP related thresholds use a hysteresis of 1/16 of the<br>compare value to compensate for jitter in the clock or the step<br>frequency. The flag_small_hysteresis_modifies the hysteresis to<br>a smaller value of 1/32.<br>(_Txxx_*15/16)-1 or<br>(_Txxx_*31/32)-1 is used as a second compare value for each<br>comparison value.<br>This means, that the lower switching velocity equals the<br>calculated setting, but the upper switching velocity is higher as<br>defined by the hysteresis setting.<br>In DcStep mode_TSTEP_will not show the mean velocity of the<br>motor, but the velocities for each microstep, which may not be<br>stable and thus does not represent the real motor velocity in<br>case it runs slower than the target velocity.|
|W|0x13|20|_TPWMTHRS_|This is the upper velocity for StealthChop voltage PWM mode.<br>_TSTEP_≥_TPWMTHRS_<br>-<br>StealthChop PWM mode is enabled, if configured<br>-<br>DcStepis disabled|

**VELOCITY DEPENDENT DRIVER FEATURE CONTROL REGISTER SET (0X10…0X1F)**

|**R/W**|**Addr**|**n**|**_Register_**|**Description /****_bit names_**|
|---|---|---|---|---|
|W|0x14|20|_TCOOLTHRS_|This is the lower threshold velocity for switching on smart<br>energy CoolStep and StallGuard feature. (unsigned)<br>Set this parameter to disable CoolStep at low speeds, where it<br>cannot work reliably. The stall output signal becomes enabled<br>when exceeding this velocity. In non-DcStep mode, it becomes<br>disabled again once the velocity falls below this threshold.<br>_TCOOLTHRS_≥_TSTEP_≥_THIGH_:<br>-<br>CoolStep is enabled, if configured<br>-<br>StealthChop voltage PWM mode is disabled<br>_TCOOLTHRS_≥_TSTEP_<br>-<br>Stall output signal (DIAG0/1) is enabled,if configured|
|||||This velocity setting allows velocity dependent switching into<br>a different chopper mode and fullstepping to maximize torque.<br>(unsigned)<br>The stall detection feature becomes switched off for 2-3<br>electrical periods whenever passing_THIGH_threshold to<br>compensate for the effect of switching modes.|
|W|0x15|20|_THIGH_|_TSTEP_≤_THIGH_:<br>-<br>CoolStep is disabled (motor runs with normal current<br>scale)<br>-<br>StealthChop voltage PWM mode is disabled<br>-<br>If_vhighchm_is set, the chopper switches to_chm_=1<br>with_TFD_=0 (constant off time with slow decay, only).<br>-<br>If_vhighfs_is set, the motor operates in fullstep mode<br>and the stall detection becomes switched over to<br>DcStepstall detection.|
|RW|0x2D|9+9|_XDIRECT_|This register is used in direct coil current<br>mode, only (_direct_mode_= 1). It bypasses the<br>internal sequencer. Specifies signed coil A<br>current (bits 8..0) and coil B current (bits<br>24..16). In this mode, the current is scaled by<br>_IHOLD_<br>setting.<br>Velocity<br>based<br>current<br>regulation of StealthChop is not available in<br>this mode. The automatic StealthChop current<br>regulation will work only for low stepper<br>motor velocities.<br>2x<br>-255…+255|

Microstep velocity time reference t for velocities: _TSTEP_ = f CLK / f STEP256 . _TSTEP_ is related to 1/256 microstep resolution independent of actual resolution set by _MRES_ .

#### 5.2.1 DcStep Minimum Velocity Register

|**DCSTEP**<br>|**MINIMUM**<br>|**VELO**|**CITY REGISTER(**<br>|**0X33) **<br>|
|---|---|---|---|---|
|**R/W**|**Addr**|**n**|**_Register_**|**Description /****_bit names_**|
|W|0x33|23|_VDCMIN_|Automatic commutation DcStep minimum velocity. Enable<br>DcStep by DCEN pin.<br>In this mode, the actual position is determined by the sensor-<br>less motor commutation and becomes fed back to the external<br>motion controller. In case the motor becomes heavily loaded,<br>_VDCMIN_is used as the minimum step velocity.|
|||||_Hint:_Also set_DCCTRL_parameters to operate DcStep.|
|||||(Only bits 22… 8 are used for value and for comparison)|

Time reference t for _VDCMIN_ : t = 2^24 / f CLK

### 5.3 Motor Driver Registers

**MICROSTEPPING CONTROL REGISTER SET (0X60…0X6B)**

|**R/W**|**Addr**|**n**|**_Register_**|**Description /****_bit names_**|**Range [Unit]**|
|---|---|---|---|---|---|
|W|0x60|32|_MSLUT[0]_<br>microstep<br>table entries<br>0…31|Each bit gives the difference between entry x<br>and entry x+1 when combined with the cor-<br>responding_MSLUTSEL_ _W_bits:<br>0:_W_= %00: -1<br>%01: +0<br>|32x 0 or 1<br>_reset default=_<br>_sine wave_<br>_table_|
||0x61|7|_MSLUT[1...7]_|%10: +1<br>%11: +2<br>1:_W_= %00: +0<br>%01: +1<br>%10: +2<br>%11: +3|7x<br>32x 0 or 1<br>_reset default=_<br>_sine wave_<br>_table_|
|W|…<br>0x67|x<br>32|microstep<br>table entries<br>32…255|This is the differential coding for the first<br>quarter of a wave. Start values for_CUR_A_and<br>_CUR_B_are stored for_MSCNT_position 0 in<br>_START_SIN_and_START_SIN90_.<br>_ofs31, ofs30, …, ofs01, ofs00_||
|||||…<br>_ofs255, ofs254, …, ofs225, ofs224_||
|W|0x68|32|**_MSLUTSEL_**|This register defines four segments within<br>each quarter_MSLUT_wave. Four 2-bit entries<br>determine the meaning of a 0 and a 1 bit in<br>the corresponding segment of_MSLUT_.<br>_See separate table!_|_0_<_X1_<_X2_<_X3_<br>_reset default=_<br>_sine wave_<br>_table_|
|W|0x69|8<br>+<br>8|_MSLUTSTART_|bit 7… 0:<br>_START_SIN_<br>bit 23… 16:_START_SIN90_<br>_START_SIN_gives the absolute current at<br>microstep table entry 0.<br>_START_SIN90_gives the absolute current for<br>microstep table entry at positions 256.<br>Start values are transferred to the microstep<br>registers_CUR_A_and_CUR_B_, whenever the<br>referenceposition_MSCNT_=0 ispassed.|_START_SIN_<br>_reset default_<br>_=0_<br>_START_SIN90_<br>_reset default_<br>_=247_|
|R|0x6A|10|_MSCNT_|Microstep counter. Indicates actual position<br>in the microstep table for_CUR_B_._CUR_A_uses<br>an offset of 256 (2 phase motor).<br>_Hint:_Move to a position where_MSCNT_is<br>zero before re-initializing_MSLUTSTART_or<br>_MSLUT_and_MSLUTSEL_.|0…1023|
|||9||bit 8… 0:<br>_CUR_B_(signed):<br>Actual<br>microstep<br>current<br>for<br>motor phase B (sine wave) as<br>read from MSLUT (not scaled by<br>|+/-0...255|
|R|0x6B|+<br>9|_MSCURACT_|current)<br>bit 24… 16:_CUR_A_(signed):<br>Actual<br>microstep<br>current<br>for<br>motor phase A (co-sine wave) as<br>read from_MSLUT_(not scaled by<br>current)||

**DRIVER REGISTER SET (0X6C…0X7F)**

|**R/W**|**Addr**|**n**|**_Register_**|**Description /****_bit names_**|**Range [Unit]**|
|---|---|---|---|---|---|
|RW|0x6C|32|**_CHOPCONF_**|chopper and driver configuration<br>_See separate table!_|_reset default=_<br>_0x10410150_|
|W|0x6D|25|**_COOLCONF_**|CoolStep smart current control register<br>and StallGuard2 configuration<br>_See separate table!_||
|||||DcStep<br>(_DC_)<br>automatic<br>commutation<br>configuration register (enable via pin DCEN<br>or via_VDCMIN_):<br>bit 9… 0:<br>_DC_TIME_: Upper PWM on time<br>limit for commutation (_DC_TIME_*<br>1/fCLK). Set slightly above effective<br>blank time_TBL_.<br>bit 23… 16:_DC_SG_: Max. PWM on time for<br>step loss detection using DcStep||
|W|0x6E|24|_DCCTRL_|StallGuard2<br>in<br>DcStep<br>mode.<br>(_DC_SG_* 16/fCLK)<br>Set<br>slightly<br>higher<br>than<br>_DC_TIME_/16<br>0=disable<br>_Hint:_Using a higher microstep resolution or<br>interpolated operation, DcStep delivers a<br>better StallGuard signal.<br>DC_SG is also available above VHIGH if<br>vhighfs is activated. For best result also set<br>vhighchm.||
|R|0x6F|32|**_DRV__**<br>**_STATUS_**|StallGuard2 value and driver error flags<br>_See separate table!_||
|W|0x70|32|**_PWMCONF_**|Voltage PWM mode chopper configuration<br>_See separate table!_|_reset default=_<br>_0xC40C001E_|
|||||Results of StealthChop amplitude regulator.<br>These values can be used to monitor<br>automatic PWM amplitude scaling (255=max.<br>voltage).||
|R|0x71|9+8|_PWM_SCALE_|bit 7… 0<br>_PWM_SCALE_SUM_:<br>Actual PWM duty cycle. This<br>value is used for scaling the<br>values_CUR_A_and_CUR_B_read<br>from the sine wave table.<br>bit 24… 16<br>_PWM_SCALE_AUTO_:<br>9 Bit signed offset added to the<br>calculated PWM duty cycle. This<br>is the result of the automatic<br>amplitude regulation based on<br>current measurement.|0…255<br>signed<br>-255…+255|
|R|0x72|8+8|_PWM_AUTO_|These automatically generated values can be<br>read out in order to determine a default /<br>power up setting for_PWM_GRAD_and<br>_PWM_OFS_.||
|||||bit 7… 0<br>_PWM_OFS_AUTO_:<br>Automatically determined offset<br>value|0…255|

|**DRIVER**<br>**R/W**|**REGISTE**<br>**Addr**|**R SET**<br>**n**|**(0X6C…0X7F) **<br>**_Register_**|**Description /****_bit names_**|**Range [Unit]**|
|---|---|---|---|---|---|
|||||bit 23… 16<br>_PWM_GRAD_AUTO_:<br>Automatically<br>determined<br>gradient value|0…255|
|R|0x73|20|_LOST_STEPS_|Number of input steps skipped due to higher<br>load in DcStep operation, if step input does<br>not stop when DC_OUT is low. This counter<br>wraps around after 2^20 steps. Counts up or<br>down dependingon direction.||

##### MICROSTEP TABLE CALCULATION FOR A SINE WAVE EQUIVALENT TO THE POWER ON DEFAULT

𝑖 𝑃𝐼 + 1024 1024 𝑟𝑜𝑢𝑛𝑑 (248 ∗ 𝑠𝑖𝑛(2 ∗𝑃𝐼∗ )) −1 - _i_ : [0… 255] is the table index - The amplitude of the wave is 248. The resulting maximum positive value is 247 and the maximum negative value is -248.

- The round function rounds values from 0.5 to 1.4999 to 1

#### 5.3.1 MSLUTSEL – Look up Table Segmentation Definition

**0X68: MSLUTSEL – LOOK UP TABLE SEGMENTATION DEFINITION**

|**Bit**|**Name**|**Function**|**Comment**|
|---|---|---|---|
|31<br>30<br>29|_X3_|LUT segment 3 start|The sine wave look-up table can be divided into up to<br>four segments using an individual step width control<br>entry_Wx_. The segment borders are selected by_X1_,_X2_|
|28|||and_X3_.|
|27<br>26|||Segment 0 goes from 0 to_X1_-1.|
|25|||Segment 1 goes from_X1_to_X2_-1.|
|24|||Segment 2 goes from_X2_to_X3_-1.|
|23<br>22<br>21|_X2_|LUT segment 2 start|Segment 3 goes from_X3_to 255.<br>For defined response the values shall satisfy:|
|20|||0<_X1_<_X2_<_X3_|
|19||||
|18<br>17||||
|16||||
|15|_X1_|LUT segment 1 start||
|14||||
|13||||
|12||||
|11||||
|10<br>9||||
|8||||
|7<br>6|_W3_|LUT width select from<br>_ofs(X3)_to_ofs255_|Width control bit coding_W0_…_W3_:<br>%00:<br>MSLUT entry 0, 1 select: -1, +0|
|5|_W2_|LUT width select from|%01:<br>MSLUT entry 0, 1 select: +0, +1|
|4||_ofs(X2)_to_ofs(X3-1)_|%10:<br>MSLUT entry 0, 1 select: +1, +2|
|3<br>2|_W1_|LUT width select from<br>_ofs(X1)_to_ofs(X2-1)_|%11:<br>MSLUT entry 0, 1 select: +2, +3|
|1|_W0_|LUT width select from||
|0||_ofs00_to_ofs(X1-1)_||

#### 5.3.2 CHOPCONF – Chopper Configuration

|**0X6C**<br>|**: ****_CHOPCONF_**<br>|**_– _CHOPPERCONFIGURATI**<br>|**ON**<br>|
|---|---|---|---|
|**Bit**|**Name**|**Function**|**Comment**|
|31|_diss2vs_|short to supply<br>protection disable|0: Short to VS protection is on<br>1: Short to VSprotection is disabled|
|30|_diss2g_|short to GND<br>protection disable|0: Short to GND protection is on<br>1: Short to GNDprotection is disabled|
|29|_dedge_|enable double edge<br>step pulses|1: Enable step impulse at each step edge to reduce step<br>frequencyrequirement.|
|28|_intpol_|interpolation to 256<br>microsteps|1: The actual microstep resolution (_MRES_) becomes<br>extrapolated to 256 microsteps for smoothest motor<br>operation (useful for STEP/DIR operation,only)|
|27|_mres3_|_MRES_|%0000:|
|26<br>25|_mres2_<br>_mres1_|micro step resolution|Native 256 microstep setting. Normally use this setting<br>with the internal motion controller.|
|24|_mres0_||%0001 … %1000:<br>128, 64, 32, 16, 8, 4, 2, FULLSTEP<br>Reduced microstep resolution esp. for STEP/DIR operation.<br>The resolution gives the number of microstep entries per<br>sine quarter wave.<br>The driver automatically uses microstep positions which<br>result in a symmetrical wave, when choosing a lower<br>microstep resolution.<br>stepwidth=2^_MRES_ [microsteps]|
|23|_tpfd3_|_TPFD_|_TPFD_allows dampening of motor mid-range resonances.|
|22|_tpfd2_|passive fast decay time|Passive fast decay time setting controls duration of the|
|21|_tpdf1 _||fast decay phase inserted after bridge polarity change|
|20|_tpfd0_||NCLK= 128*_TPFD_<br>%0000: Disable<br>%0001 … %1111: 1 … 15|
|19|_vhighchm_|high velocity chopper<br>mode|This bit enables switching to_chm_=1 and_fd_=0, when_VHIGH_<br>is exceeded. This way, a higher velocity can be achieved.<br>Can be combined with_vhighfs_=1. If set, the_TOFF_setting<br>automatically becomes doubled during high velocity<br>operation in order to avoid doubling of the chopper<br>frequency.|
|18|_vhighfs_|high velocity fullstep<br>selection|This bit enables switching to fullstep, when_VHIGH_is<br>exceeded. Switching takes place only at 45° position.<br>The fullstep target current uses the current value from<br>|
||||the microsteptable at the 45°position.|
|17|_-_|reserved|reserved,set to 0|
|16|_tbl1_|_TBL_|%00 … %11:|
|15|_tbl0_|blank time select|Set comparator blank time to 16, 24, 36 or 54 clocks<br>_Hint_: %01 or %10 is recommended for most applications<br>_(Reset Default: OTP %01 or %10)_|
|14|_chm_|chopper mode|0<br>Standard mode (SpreadCycle)|
||||1<br>Constant off time with fast decay time.<br>Fast decay time is also terminated when the<br>negative nominal current is reached. Fast decay is<br>|
||||after on time.|
|13|_-_|reserved|Reserved,set to 0|
|12|_disfdcc_|fast decay mode|_chm_=1:<br>_disfdcc_=1 disables current comparator usage for termi-<br>nation of the fast decaycycle|

|11|_fd3_|_TFD [3]_|_chm_=1:<br>MSB of fa|st decaytime setting _TFD_|
|---|---|---|---|---|
|10|_hend3_|_HEND_<br>|_chm_=0|%0000 … %1111:<br>|
|9|_hend2_|hysteresis low value||Hysteresis is -3, -2, -1, 0, 1, …, 12|
|8|_hend1_|_OFFSET_||(1/512 of this setting adds to current setting)|
|7|_hend0_|sine wave offset||This is the hysteresis value which becomes<br>used for the hysteresis chopper.|
||||_chm_=1|%0000 … %1111:<br>Offset is -3, -2, -1, 0, 1, …, 12<br>This is the sine wave offset and 1/512 of the<br>value becomes added to the absolute value<br>of each sine wave entry.|
|6|_hstrt2_|_HSTRT_|_chm_=0|%000 … %111:|
|5|_hstrt1_|hysteresis start value||Add 1, 2, …, 8 to hysteresis low value_HEND_|
|4|_hstrt0_|added to_HEND_||(1/512 of this setting adds to current setting)<br>_Attention: Effective HEND+HSTRT ≤ 16._<br>_Hint:_Hysteresis decrement is done each 16<br>clocks|
|||_TFD [2..0]_<br>fast decay time setting|_chm_=1|Fast decay time setting (MSB:_fd3_):<br>%0000 … %1111:<br>Fast decay time setting_TFD_with<br>NCLK= 32*_TFD_ (%0000: slow decayonly)|
|3|_toff3 _|_TOFF_off time|Off time|setting controls duration of slow decay phase|
|2|_toff2_|and driver enable|NCLK= 24 +|32*_TOFF_|
|1|_toff1_||%0000: D|river disable, all bridges off|
|0|_toff0_||%0001: 1<br>%0010 …|– use only with_TBL_≥ 2<br>%1111: 2 … 15|

#### 5.3.3 COOLCONF – Smart Energy Control CoolStep and StallGuard2

**0X6D: COOLCONF – SMARTENERGY CONTROLCOOLSTEP ANDSTALLGUARD2**

|**Bit**|**Name**|**Function**|**Comment**|
|---|---|---|---|
|…|_-_|reserved|set to 0|
|24|_sfilt_|StallGuard2 filter<br>enable|0<br>Standard<br>mode,<br>high<br>time<br>resolution<br>for<br>StallGuard2|
||||1<br>Filtered mode, StallGuard2 signal updated for each<br>four fullsteps (resp. six fullsteps for 3 phase motor)<br>onlyto compensate for motorpole tolerances|
|23|_-_|reserved|set to 0|
|22|_sgt6_|StallGuard2 threshold|This signed value controls StallGuard2 level for stall|
|21|_sgt5_|value|output and sets the optimum measurement range for|
|20|_sgt4_||readout. A lower value gives a higher sensitivity. Zero is|
|19|_sgt3_||the starting value working with most motors.|
|18|_sgt2_||-64 to +63:  A higher value makes StallGuard2 less|
|17|_sgt1_||sensitive and requires more torque to|
|16|_sgt0_||indicate a stall.|
|15|_seimin_|minimum current for<br>smart current control|0: 1/2 of current setting (_IRUN_)<br>1: 1/4 of current setting(_IRUN_)|
|14|_sedn1_|current down step|%00: For each 32 StallGuard2 values decrease by one|
|13|_sedn0_|speed|%01: For each 8 StallGuard2 values decrease by one<br>%10: For each 2 StallGuard2 values decrease by one<br>%11: For each StallGuard2 value decrease byone|
|12|_-_|reserved|set to 0|
|11<br>10|_semax3_<br>_semax2_|StallGuard2 hysteresis<br>value for smart current|If the StallGuard2 result is equal to or above<br>(_SEMIN_+_SEMAX+_1)*32,<br>the<br>motor<br>current<br>becomes|
|9|_semax1_|control|decreased to save energy.|
|8|_semax0_||%0000 … %1111: 0 … 15|
|7|_-_|reserved|set to 0|
|6|_seup1 _|current up step width|Current increment steps per measured StallGuard2 value|
|5|_seup0 _||%00 … %11: 1,2,4,8|
|4|_-_|reserved|set to 0|
|3|_semin3_|minimum StallGuard2|If the StallGuard2 result falls below_SEMIN_*32, the motor|
|2|_semin2_|value for smart current|current becomes increased to reduce motor load angle.|
|1|_semin1_|control and|%0000: smart current control CoolStep off|
|0|_semin0_|smart current enable|%0001 … %1111: 1 … 15|

#### 5.3.4 PWMCONF – Voltage PWM Mode StealthChop

**0X70: PWMCONF– VOLTAGE MODEPWMSTEALTHCHOP**

|**Bit**|**Name**|**Function**|**Comment**|
|---|---|---|---|
|31<br>30<br>29<br>28|_PWM_LIM_|PWM automatic scale<br>amplitude limit when<br>switching on|Limit for_PWM_SCALE_AUTO_when switching back from<br>SpreadCycle to StealthChop. This value defines the upper<br>limit for bits 7 to 4 of the automatic current control<br>when switching back. It can be set to reduce the current<br>jerk during mode change back to StealthChop.<br>It does not limit_PWM_GRAD_or_PWM_GRAD_AUTO_offset.<br>(Default = 12)|
|27<br>26<br>25<br>24|_PWM_REG_|Regulation loop<br>gradient|User defined maximum PWM amplitude change per half<br>wave when using_pwm_autoscale_=1_._(1…15):<br>1: 0.5 increments (slowest regulation)<br>2: 1 increment<br>3: 1.5 increments<br>4: 2 increments_(Reset default)_)<br>…<br>8: 4 increments<br>...<br>15: 7.5 increments (fastest regulation)|
|23|_-_|reserved|set to 0|
|22|_-_|reserved|set to 0|
|21<br>20|_freewheel1_<br>_freewheel0_|Allows different<br>standstill modes|Stand still option when motor current setting is zero<br>(_I_HOLD_=0).<br>%00:  Normal operation<br>%01:  Freewheeling<br>%10:  Coil shorted using LS drivers<br>%11:  Coil shorted usingHS drivers|
|19|_pwm__<br>_autograd_|PWM automatic<br>gradient adaptation|0<br>Fixed value for_PWM_GRAD_<br>(_PWM_GRAD_AUTO_=_PWM_GRAD_)<br>1<br>Automatic tuning (only with_pwm_autoscale_=1)<br>(_Reset default_)<br>_PWM_GRAD_AUTO_is initialized with_PWM_GRAD_<br>while_pwm_autograd_=0 and becomes optimized<br>automatically during motion.<br>Preconditions<br>1. _PWM_OFS_AUTO_has been automatically<br>initialized. This requires standstill at_IRUN_for<br>>130ms to a) detect standstill b) wait > 128<br>chopper cycles at_IRUN_and c) regulate<br>_PWM_OFS_AUTO_so that<br>-1 <_PWM_SCALE_AUTO_< 1<br>2. Motor running and_PWM_SCALE_SUM_< 255 and<br>1.5 *_PWM_OFS_AUTO_* (_IRUN_+1)/32<br><_PWM_SCALE_SUM_<<br>4*_PWM_OFS_AUTO_* (_IRUN_+1)/32.<br>Time required for tuning_PWM_GRAD_AUTO_<br>About 8 fullsteps per change of +/-1.<br>Also enables use of reduced chopper frequency for<br>tuning _PWM_OFS_AUTO._|
|18|_pwm__<br>_autoscale_|PWM automatic<br>amplitude scaling|0<br>User defined feed forward PWM amplitude. The<br>current settings_IRUN_and_IHOLD_are not enforced<br>by regulation, but scale the PWM amplitude, only!<br>The resulting PWM amplitude (limited to 0…255) is:<br>_PWM_OFS * ((CS_ACTUAL+1) / 32)_<br>+_PWM_GRAD_* 256 /_TSTEP_<br>1<br>Enable automatic current control_(Reset default)_|
|17<br>16|_pwm_freq1 _<br>_pwm_freq0_|PWM frequency<br>selection|%00:  fPWM=2/1024 fCLK _(Reset default)_<br>%01:  fPWM=2/683 fCLK<br>%10:  fPWM=2/512 fCLK<br>%11:  fPWM=2/410 fCLK|
|15<br>14<br>13<br>12<br>11<br>10<br>9<br>8|_PWM__<br>_GRAD_|User defined amplitude<br>gradient|Velocity dependent gradient for PWM amplitude:<br>_PWM_GRAD_* 256 /_TSTEP_<br>This value is added to_PWM_OFS_to compensate for the<br>velocity-dependent motor back-EMF.<br>Use_PWM_GRAD_as initial value for automatic scaling to<br>speed up the automatic tuning process. To do this, set<br>_PWM_GRAD_to the determined, application specific value,<br>with<br>_pwm_autoscale_=0.<br>Only<br>afterwards,<br>set<br>_pwm_autoscale_=1. Enable StealthChop when finished.<br>_Hint:_<br>After initial tuning, the required initial value can be read<br>out from_PWM_GRAD_AUTO._|
|7<br>6<br>5<br>|_PWM__<br>_OFS_|User defined amplitude<br>(offset)|User defined PWM amplitude offset (0-255) related to full<br>motor current (_CS_ACTUAL_=31) in stand still.<br>(_Reset default=30_)|
|4<br>3<br>2<br>1<br>0|||Use_PWM_OFS_as initial value for automatic scaling to<br>speed up the automatic tuning process. To do this, set<br>_PWM_OFS_to the determined, application specific value,<br>with<br>_pwm_autoscale_=0.<br>Only<br>afterwards,<br>set<br>_pwm_autoscale_=1. Enable StealthChop when finished.<br>_PWM_OFS_= 0 will disable scaling down motor current<br>below a motor specific lower measurement threshold.<br>This setting should only be used under certain<br>conditions, i.e., when the power supply voltage can vary<br>up and down by a factor of two or more. It prevents<br>the motor going out of regulation, but it also prevents<br>power down below the regulation limit.<br>_PWM_OFS_> 0 allows automatic scaling to low PWM duty<br>cycles even below the lower regulation threshold. This<br>allows low (standstill) current settings based on the<br>actual(hold)current scale(register_IHOLD_IRUN_).|

#### 5.3.5 DRVSTATUS – StallGuard2 Value and Driver Error Flags

|**0X6F:**<br>**Bit**|**DRV_STAT**<br>**Name**|**US – STALLGUARD2 VALU**<br>**Function**|**E AND DRIVER ERROR FLAGS**<br>**Comment**|
|---|---|---|---|
|31|_stst_|standstill indicator|This flag indicates motor stand still in each operation mode.<br>This occurs 2^20 clocks after the last step pulse.|
|30|_olb_|open load indicator<br>phase B|1: Open load detected on phase A or B.<br>_Hint:_This is just an informative flag. The driver takes no action|
|29|_ola_|open load indicator<br>phase A|upon it. False detection may occur in fast motion and<br>standstill. Check during slow motion, only.|
|28|s_2gb_|short to ground<br>indicatorphase B|1: Short to GND detected on phase A or B. The driver becomes<br>disabled. The flags stay active, until the driver is disabled by<br>|
|27|s_2ga_|short to ground<br>indicatorphase A|software (_TOFF_=0) or by the DRV_ENN input.|
|26|_otpw_|overtemperature pre-<br>warning flag|1: Overtemperature pre-warning threshold is exceeded.<br>The overtemperature pre-warning flag is common for both<br>bridges.|
|25|_ot_|overtemperature flag|1: Overtemperature limit has been reached. Drivers become<br>disabled until_otpw_is also cleared due to cooling down of the<br>IC.<br>The overtemperature flagis common for both bridges.|
|24|_StallGuard_|StallGuard2 status|1: Motor stall detected (_SG_RESULT_=0) or DcStep stall in DcStep<br>mode.|
|23<br>22|_-_|reserved|Ignore these bits|
|21||||
|20<br>19<br>18<br>17|_CS_<br>_ACTUAL_|actual motor current /<br>smart energy current|Actual current control scaling, for monitoring smart energy<br>current scaling controlled via settings in register_COOLCONF_, or<br>for monitoring the function of the automatic current scaling.|
|16||||
|15|_fsactive_|full step active<br>indicator|1: Indicates that the driver has switched to fullstep as defined<br>by chopper mode settings and velocity thresholds.|
|14|_stealth_|StealthChopindicator|1: Driver operates in StealthChopmode|
|13|s_2vsb_|short to supply<br>indicatorphase B|1: Short to supply detected on phase A or B. The driver<br>becomes disabled. The flags stay active, until the driver is|
|12|s_2vsa_|short to supply<br>indicatorphase A|disabled by software (_TOFF_=0) or by the DRV_ENN input. Sense<br>resistor voltage drop is included in the measurement!|
|11|_-_|reserved|Ignore this bit|
|10|_-_|reserved|Ignore this bit|
|9<br>8<br>7<br>6<br>5<br>4<br>3<br>2|_SG__<br>_RESULT_|StallGuard2 result<br>respectively PWM on<br>time for coil A in<br>standstill for motor<br>temperature detection|Mechanical load measurement:<br>The StallGuard2 result gives a means to measure mechanical<br>motor load. A higher value means lower mechanical load. A<br>value of 0 signals highest load. With optimum_SGT_setting,<br>this is an indicator for a motor stall. The stall detection<br>compares_SG_RESULT_to 0 to detect a stall._SG_RESULT_is used<br>as a base for CoolStep operation, by comparing it to a pro-<br>grammable upper and a lower limit. It is not applicable in<br>StealthChop mode.|
|1<br>0|||StallGuard2 works best with microstep operation or DcStep.<br>Temperature measurement:<br>In standstill, no StallGuard2 result can be obtained._SG_RESULT_<br>shows the chopper on-time for motor coil A instead. Move the<br>motor to a determined microstep position at a certain current<br>setting to get a rough estimation of motor temperature by a<br>reading the chopper on-time. As the motor heats up, its coil<br>resistance rises and the chopper on-time increases.|

## 6 StealthChop™

StealthChop is an extremely quiet mode of operation for stepper motors. It is based on a voltage mode PWM. In case of standstill and at low velocities, the motor is absolutely noiseless. Thus, StealthChop operated stepper motor applications are very suitable for indoor or home use. The motor operates free of vibration at low velocities. With StealthChop, the motor current is applied by driving a certain effective voltage into the coil, using a voltage mode PWM. With the enhanced StealthChop2, the driver automatically adapts to the application for best performance. No more configurations are required. Optional configuration allows for tuning the setting in special cases, or for storing initial values for the automatic adaptation algorithm. For high velocity drives SpreadCycle should be considered in combination with StealthChop.

**Figure 6.1 Motor coil sine wave current with StealthChop (measured with current probe)**

### 6.1 Automatic Tuning

StealthChop2 integrates an automatic tuning procedure (AT), which adapts the most important operating parameters to the motor automatically. This way, StealthChop2 allows high motor dynamics and supports powering down the motor to very low currents. Just two steps have to be respected by the motion controller for best results: Start with the motor in standstill but powered with nominal run current (AT#1). Move the motor at a medium velocity, e.g., as part of a homing procedure (AT#2). Figure 6.2 shows the tuning procedure.

Border conditions for AT#1 and AT#2 are shown in the following table:

**AUTOMATIC TUNING TIMING AND BORDER CONDITIONS**

|**Step**|**Parameter**|**Conditions**|**Required Duration**|
|---|---|---|---|
|AT#1|_PWM__<br>_OFS_AUTO_|-<br>Motor in standstill and actual current scale (_CS_) is<br>identical to run current (_IRUN_).<br>-<br>If standstill reduction is enabled, an initial step<br>pulse switches the drive back to run current or set<br>_IHOLD_to_IRUN_.<br>-<br>Pin VS at operating level.<br>_Attention: Driver may reduce chopper frequency during_<br>_AT#1. Use reduced standstill current IHOLD<IRUN to_<br>_prevent extended periods of time at lower chopper_<br>_frequency_|≤ 2^20+2*2^18 tCLK,<br>≤ 130ms<br>(with internal clock)|
|AT#2|_PWM__<br>_GRAD_AUTO_|-<br>Move motor at a velocity, where a significant<br>amount of back EMF is generated and where the full<br>run current can be reached. Conditions:<br>-<br>1.5*_PWM_OFS_AUTO*(IRUN_+1)/32 <_PWM_SCALE_SUM_<br>< 4*_PWM_OFS_AUTO_*(_IRUN_+1)/32<br>-<br>_PWM_SCALE_SUM_< 255.<br>_Hint:_A typical range is 60-300 RPM.|8 fullsteps are required<br>for a change of +/-1.<br>For a typical motor with<br>_PWM_GRAD_AUTO_<br>optimum at 50 or less, up<br>to<br>400<br>fullsteps<br>are<br>required when starting<br>from default value 0.|

Determine best conditions for automatic tuning with the evaluation board. Monitor _PWM_SCALE_AUTO_ going down to zero during the constant velocity phase in AT#2 tuning. This indicates a successful tuning.

> **Attention:** Operating in StealthChop without proper tuning can lead to high motor currents during a deceleration ramp, especially with low resistive motors and fast deceleration settings. Follow the automatic tuning process and check optimum tuning conditions using the evaluation board. It is recommended to use an initial value for settings _PWM_OFS_ and _PWM_GRAD_ determined per motor type. Protect the power stage and supply by additionally tuning the overcurrent protection.

_Known Limitations for non-A-version, only_ :

Successful completion of AT#1 tuning phase is not safely detected by the TMC2160. It will require multiple motor start / stop events to safely detect completion. Successful determination is mandatory for AT#2: Tuning of _PWM_GRAD_ will not start when AT#1 has not completed.

Successful completion of AT#1 and AT#2 only can be checked by monitoring _PWM_SCALE_AUTO_ approaching 0 during AT#2 motion.

> **Solution a):** Complete automatic tuning phase AT#1 process, by using a slow-motion sequence which leads to standstill detection in between of each two steps. Use a velocity of 8 (6 Hz) or lower and execute minimum 10 steps during AT#1 phase.

> **Solution b):** Store initial parameters for _PWM_GRAD_AUTO_ for the application. Therefore, use the motor and operating conditions determined for the application and do a complete automatic tuning sequence (refer to _a)_ ). Store the resulting _PWM_GRAD_AUTO_ value and use it for initialization of _PWM_GRAD_ . With this, tuning of AT#2 phase is not mandatory in the application and can be skipped. Automatic tuning will further optimize settings during operation. Combine with a) if desired.

**Figure 6.2 StealthChop2 automatic tuning procedure**

_Attention_ Modifying _GLOBALSCALER_ or VS voltage invalidates the result of the automatic tuning process. However, automatic tuning adapts to changed conditions whenever AT#1 or AT#2 conditions are fulfilled. Modifying VS is no problem with sinking supply voltage, i.e., due to the battery running low, as the regulator corrects by increasing the PWM value. However, with significantly increasing supply voltage, motor current rises, as the lower regulator limit is given by the result of the last AT#1 phase. Take this into account, when experimenting with a lab supply and modifying supply voltage.

### 6.2 StealthChop Options

To match the motor current to a certain level, the effective PWM voltage becomes scaled depending on the actual motor velocity. Several additional factors influence the required voltage level to drive the motor at the target current: The motor resistance, its back EMF (i.e., directly proportional to its velocity) as well as the actual level of the supply voltage. Two modes of PWM regulation are provided: The automatic tuning mode (AT) using current feedback ( _pwm_autoscale_ = 1, _pwm_autograd_ = 1) and a feed forward velocity-controlled mode ( _pwm_autoscale_ = 0). The feed forward velocitycontrolled mode will not react to a change of the supply voltage or to events like a motor stall, but it provides very stable amplitude. It does not use nor require any means of current measurement. This is perfect when motor type and supply voltage are well known. Therefore, we recommend the automatic mode, unless current regulation is not satisfying in the given operating conditions.

It is recommended to use application specific initial tuning parameters, fitting the motor type and supply voltage. Additionally, operate in automatic tuning mode ( _pwm_autoscale_ =1) to respond to parameter change, e.g., due to motor heat-up or change of supply voltage.

_Hint:_ To reduce amplitude jitter, use pre-determined _PWM_GRAD_ and set _pwm_autograd = 0_ .

Non-automatic mode ( _pwm_autoscale=0_ ) should be considered only with well-known motor and operating conditions. In this case, careful programming via the interface is required. The operating <u>parameters</u> _PWM_GRAD_ and _PWM_OFS_ can be determined in automatic tuning mode initially.

The StealthChop PWM frequency can be chosen in four steps to adapt the frequency divider to the frequency of the clock source. A setting in the range of 20-50kHz is good for most applications. It balances low current ripple and good higher velocity performance vs. dynamic power dissipation.

**CHOICE OF PWM FREQUENCY FOR STEALTHCHOP**

|**Clock frequency**<br>**fCLK**|**PWM_FREQ=%00**<br>fPWM=2/1024 fCLK|**PWM_FREQ=%01**<br>fPWM=2/683 fCLK|**PWM_FREQ=%10**<br>fPWM=2/512 fCLK|**PWM_FREQ=%11**<br>fPWM=2/410 fCLK|
|---|---|---|---|---|
|18MHz|35.2kHz|52.7kHz|70.3kHz|87.8kHz|
|16MHz|31.3kHz|46.9kHz|62.5kHz|78.0kHz|
|12MHz(internal)|23.4kHz|35.1kHz|46.9kHz|58.5kHz|
|10MHz|19.5kHz|29.3kHz|39.1kHz|48.8kHz|
|8MHz|15.6kHz|23.4kHz|31.2kHz|39.0kHz|

**Table 6.1 Choice of PWM frequency – green / light green: recommended**

### 6.3 StealthChop Current Regulator

In StealthChop voltage PWM mode, the autoscaling function ( _pwm_autoscale_ = 1, _pwm_autograd_ = 1) regulates the motor current to the desired current setting. Automatic scaling is used as part of the automatic tuning process (AT), and for subsequent tracking of changes within the motor parameters. The driver measures the motor current during the chopper on time and uses a proportional regulator to regulate _PWM_SCALE_AUTO_ in order match the motor current to the target current. _PWM_REG_ is the proportionality coefficient for this regulator. Basically, the proportionality coefficient should be as small as possible to get a stable and soft regulation behavior, but it must be large enough to allow the driver to quickly react to changes caused by variation of parameters (e.g., change of mechanical load). During initial tuning step AT#2, _PWM_REG_ also compensates for the change of motor velocity. Therefore, a high acceleration during AT#2 will require a higher setting of _PWM_REG_ . With careful selection of homing velocity and acceleration, a minimum setting of the regulation gradient often is sufficient ( _PWM_REG_ =1). _PWM_REG_ setting should be optimized for the fastest required acceleration and deceleration ramp (compare Figure 6.3 and Figure 6.4). The quality of the setting _PWM_REG_ in phase AT#2 and the finished automatic tuning procedure (or non-automatic settings for _PWM_OFS_ and _PWM_GRAD_ ) can be examined when monitoring motor current during an acceleration phase Figure 6.5.

**Figure 6.3 Scope shot: good setting for PWM_REG**

**Figure 6.4 Scope shot: too small setting for PWM_REG during AT#2**

**Figure 6.5 Successfully determined PWM_GRAD(_AUTO) and PWM_OFS(_AUTO)**

_Quick Start_ For a quick start, see the Quick Configuration Guide in chapter 18.

#### 6.3.1 Lower Current Limit

The StealthChop current regulator imposes a lower limit for motor current regulation. As the coil current can be measured in the shunt resistor during chopper on phase only, a minimum chopper duty cycle allowing coil current regulation is given by the blank time as set by _TBL_ and by the chopper frequency setting. Therefore, the motor specific minimum coil current in StealthChop autoscaling mode rises with the supply voltage and with the chopper frequency. A lower blanking time allows a lower current limit. It is important for the correct determination of _PWM_OFS_AUTO_ , that in AT#1 the run current set by the sense resistor, _GLOBALSCALER_ and _IRUN_ is well within the regulation range. Lower currents (e.g., for standstill power down) are automatically realized based on _PWM_OFS_AUTO_ and _PWM_GRAD_AUTO_ respectively based on _PWM_OFS_ and _PWM_GRAD_ with nonautomatic current scaling. The freewheeling option allows going to zero motor current.

Lower motor coil current limit for StealthChop2 automatic tuning:

With VM the motor supply voltage and RCOIL the motor coil resistance. ILower Limit can be treated as a thumb value for the minimum nominal _IRUN_ motor current setting. In case the lower current limit is not sufficient to reach the desired setting, the driver will retry with a lower chopper frequency in step AT#1, only.

fPWM is the chopper frequency as determined by setting _PWM_FREQ_ . In AT#1, the driver tries a lower, (roughly half frequency), in case it cannot reach the current. The frequency will remain active in standstill, while currentscale _CS_ = _IRUN._ With automatic standstill reduction, this is a short moment.

**EXAMPLE:**

A motor has a coil resistance of 5Ω, the supply voltage is 24V. With _TBL_ =%01 and _PWM_FREQ_ =%00, tBLANK is 24 clock cycles, fPWM is 2/(1024 clock cycles):

This means, the motor target current for automatic tuning must be 225mA or more, taking into account all relevant settings. This lower current limit also applies for modification of the motor current via the _GLOBALSCALER_ .

> **Attention:** For automatic tuning, a lower coil current limit applies. _IRUN_ ≥ 8: Current settings for _IRUN_ below 8 do not work with automatic tuning. I LOWER LIMIT : The motor current in automatic tuning phase AT#1 must exceed this lower limit. Calculate I LOWER LIMIT or measure it using a current probe. Setting the motor run-current or hold-current below the lower current limit during operation by modifying _IRUN_ and _IHOLD_ is possible <u>after</u> successful automatic tuning.

The lower current limit also limits the capability of the driver to respond to changes of _GLOBALSCALER_ .

### 6.4 Velocity Based Scaling

Velocity based scaling scales the StealthChop amplitude based on the time between each two steps ( _TSTEP_ ) measured in clock cycles. This concept basically does not require a current measurement, because no regulation loop is necessary. A pure velocity-based scaling is available via programming, only, when setting _pwm_autoscale_ = 0. The basic idea is to have a linear approximation of the voltage required to drive the target current into the motor. The stepper motor has a certain coil resistance and thus needs a certain voltage amplitude to yield a target current based on the basic formula I=U/R. With R being the coil resistance, U the supply voltage scaled by the PWM value, the current I results. The initial value for _PWM_OFS_ can be calculated:

With VM the motor supply voltage and ICOIL the target RMS current

The effective PWM voltage UPWM (1/SQRT(2) x peak value) results considering the 8 bit resolution and 248 sine wave peak for the actual PWM amplitude shown as _PWM_SCALE_ :

With rising motor velocity, the motor generates an increasing back EMF voltage. The back EMF voltage is proportional to the motor velocity. It reduces the PWM voltage effective at the coil resistance and thus current decreases. The TMC2160 provides a second velocity dependent factor ( _PWM_GRAD_ ) to compensate for this. The overall effective PWM amplitude ( _PWM_SCALE_SUM_ ) in this mode automatically is calculated in dependence of the microstep frequency as:

With fSTEP being the microstep frequency for 256 microstep resolution equivalent and fCLK the clock frequency supplied to the driver or the actual internal frequency resulting in TSTEP= fSTEP / fCLK

CS_ACTUAL takes into account the actual current scaling as defined by IHOLD and IRUN

As a first approximation, the back EMF subtracts from the supply voltage and thus the effective current amplitude decreases. This way, a first approximation for _PWM_GRAD_ setting can be calculated:

CBEMF is the back EMF constant of the motor in Volts per radian/second. MSPR is the number of microsteps per rotation assuming a 256 microstep resolution, e.g., 51200 = 256µsteps multiplied by 200 fullsteps for a 1.8° motor.

**Figure 6.6 Velocity based PWM scaling (pwm_autoscale=0)**

> **Hint:** The values for _PWM_OFS_ and _PWM_GRAD_ can easily be optimized by tracing the motor current with a current probe on the oscilloscope. Alternatively, automatic tuning determines these values, and they can be read out from _PWM_OFS_AUTO_ and _PWM_GRAD_AUTO_ .

##### UNDERSTANDING THE BACK EMF CONSTANT OF A MOTOR

The back EMF constant is the voltage a motor generates when turned with a certain velocity. Often motor datasheets do not specify this value, as it can be deducted from motor torque and coil current rating. Within SI units, the numeric value of the back EMF constant CBEMF has the same numeric value as the numeric value of the torque constant. For example, a motor with a torque constant of 1 Nm/A would have a CBEMF of 1V/rad/s. Turning such a motor with 1 rps (1 rps = 1 revolution per second = 6.28 rad/s) generates a back EMF voltage of 6.28V. Thus, the back EMF constant can be calculated as:

ICOILNOM is the motor’s rated phase current for the specified holding torque HoldingTorque is the motor specific holding torque, i.e., the torque reached at ICOILNOM on both coils. The torque unit is [Nm] where 1Nm = 100Ncm = 1000mNm.

The voltage is valid as RMS voltage per coil, thus the nominal current is multiplied by 2 in this formula, since the nominal current assumes a full step position, with two coils operating.

### 6.5 Combine StealthChop and SpreadCycle

For applications requiring high velocity motion, SpreadCycle may bring more stable operation in the upper velocity range. To combine no-noise operation with highest dynamic performance, the TMC2160 allows combining StealthChop and SpreadCycle based on a velocity threshold (Figure 6.7). With this, StealthChop is only active at low velocities.

> **Hint:** Operate the motor within your application when exploring StealthChop. Motor performance often is better with a mechanical load, because it prevents the motor from stalling due mechanical oscillations which can occur without load.

**Figure 6.7 TPWMTHRS for optional switching to SpreadCycle**

As a first step, both chopper principles should be parameterized and optimized individually. In a next step, a transfer velocity has to be fixed. For example, StealthChop operation is used for precise low speed positioning, while SpreadCycle shall be used for highly dynamic motion. _TPWMTHRS_ determines the transition velocity. Read out _TSTEP_ when moving at the desired velocity and program the resulting value to _TPWMTHRS_ . Use a low transfer velocity to avoid a jerk at the switching point. A jerk occurs when switching at higher velocities, because the back-EMF of the motor (which rises with the velocity) causes a phase shift of up to 90° between motor voltage and motor current. So when switching at higher velocities between voltage PWM and current PWM mode, this jerk will occur with increased intensity. A high jerk may even produce a temporary overcurrent condition (depending on the motor coil resistance). At low velocities (e.g., 1 to a few 10 RPM), it can be completely neglected for most motors. Therefore, consider the switching jerk when choosing _TPWMTHRS_ . Set _TPWMTHRS_ zero if you want to work with StealthChop only.

When enabling the StealthChop mode the first time using automatic current regulation, the motor must be at stand still to allow a proper current regulation. When the drive switches to StealthChop at a higher velocity, StealthChop logic stores the last current regulation setting until the motor returns to a lower velocity again. This way, the regulation has a known starting point when returning to a lower velocity, where StealthChop becomes re-enabled. Therefore, neither the velocity threshold nor the supply voltage must be considerably changed during the phase while the chopper is switched to a different mode, because otherwise the motor might lose steps, or the instantaneous current might be too high or too low.

A motor stall or a sudden change in the motor velocity may lead to the driver detecting a short circuit or to a state of automatic current regulation, from which it cannot recover. Clear the error flags and restart the motor from zero velocity to recover from this situation.

> **Hint:** Start the motor from standstill when switching on StealthChop the first time and keep it stopped for at least 128 chopper periods to allow StealthChop to do initial standstill current control.

### 6.6 Flags in StealthChop

As StealthChop uses voltage mode driving, status flags based on current measurement respond slower, respectively the driver reacts delayed to sudden changes of back EMF, like on a motor stall.

> **Attention:** A motor stall, or abrupt stop of the motion during operation in StealthChop can lead to a overcurrent condition. Depending on the previous motor velocity, and on the coil resistance of the motor, it significantly increases motor current for a time of several 10ms. With low velocities, where the back EMF is just a fraction of the supply voltage, there is no danger of triggering the short detection.

_Hint_ Tune low side driver overcurrent detection to safely trigger upon motor stall, when using StealthChop. This will avoid high peak current draw from the power supply.

#### 6.6.1 Open Load Flags

In StealthChop mode, status information is different from the cycle-by-cycle regulated SpreadCycle mode. OLA and OLB show if the current regulation sees that the nominal current can be reached on both coils. An active open load flag not necessarily signals an interrupted coil condition.

- A flickering OLA or OLB can result from asymmetries of the sense resistors or the motor coils.

- An interrupted motor coil leads to a continuously active open load flag for the coil.

- One or both flags become active, if the current regulation fails in scaling up to the full target current within a few fullsteps. This can result if the motor is not connected, or from a high velocity motion where the back EMF reaches the supply limit, or a too high motor resistance.

- Checking _PWM_SCALE_SUM_ for a value determined during typical operation at slow motion may give a more reliable result.

With automatic scaling, the current regulation measures and regulates the current in the coil with the higher target current, only. The other coil PWM becomes scaled proportionally. In case a coil connection is interrupted, this behavior can lead to the other coil being driven with too high current. To prevent subsequent motor or driver damage, do an open load test using SpreadCycle prior to operation in StealthChop, and do not enable StealthChop in case of open load failure.

> **Attention:** For _pwm_autoscale_ mode, an open load situation on a single coil can lead to the current regulation algorithm scaling up the non-interrupted coil to too high current values. Therefore, it is recommended to test for open load prior to operation in StealthChop using SpreadCycle. Do not enable StealthChop in case of an open load situation.

#### 6.6.2 PWMSCALESUM Informs about the Motor State

_PWM_SCALE_SUM_ reflects the actual voltage required to drive the target current into the motor. It depends on several factors, and thus allows a health check of the drive: motor load, coil resistance, supply voltage, and current setting. When reaching the limit (255), the current regulator cannot sustain the full motor current, e.g., due to a drop in supply volage or an open load condition.

### 6.7 Freewheeling and Passive Braking

StealthChop provides different options for motor standstill. Enable these options by setting _IHOLD_ to zero and choosing the desired _FREEWHEEL_ setting. The desired option becomes enabled after the delay specified by _TPOWERDOWN_ and _IHOLDDELAY_ . Current regulation becomes frozen once the motor target current is at zero to ensure a quick startup. With the freewheeling options, both freewheeling and passive braking can be realized. Passive braking is an energy efficient eddy current motor braking with no active current driven into the coils. However, passive braking will allow slow turning of the motor when a continuous torque is applied.

|**PARAMETERS**<br>**Parameter**|**RELATED TOSTEALTHCHOP**<br>**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_en_spread__<br>_cycle_|General disable for use of StealthChop (register<br>_GCONF_). The input SPREAD is XORed to this flag.|<br>1<br>0|Do not use StealthChop<br>StealthChopenabled|
|_TPWMTHRS_|Specifies the upper velocity for operation in<br>StealthChop. Entry the_TSTEP_reading (time<br>between two microsteps) when operating at the<br>desired threshold velocity.|<br> <br> <br>0 …<br>1048575|<br>StealthChop is disabled if<br>_TSTEP_falls_TPWMTHRS_|
|_PWM_LIM_|Limiting value for limiting the current jerk when<br>switching<br>from<br>SpreadCycle<br>to StealthChop.<br>Reduce the value toyield a lower currentjerk.|<br> <br>0 … 15|Upper four bits of 8 bit<br>amplitude limit<br>(Default=12)|
|_pwm__|Enable automatic current scaling using current|<br>0|Forward controlled mode|
|<br>_autoscale_|<br>measurement. If off, use forward controlled<br>velocity-based mode.|<br> <br>1|Automatic scaling with<br>current regulator|
|_pwm__<br>_autograd_|Enable automatic tuning of_PWM_GRAD_AUTO_|0<br>1|disable, use_PWM_GRAD_<br>from register instead<br>enable|
|_PWM_FREQ_|PWM frequency selection. Use the lowest setting<br>giving good results. The frequency measured at|<br> <br>0<br>1|fPWM=2/1024 fCLK<br>fPWM=2/683 fCLK|
||each of the chopper outputs is half of the<br>effective chopper frequency fPWM.|<br>2<br>3|fPWM=2/512 fCLK<br>fPWM=2/410 fCLK|
|_PWM_REG_|User defined PWM amplitude regulation loop P-<br>coefficient. A higher value leads to a higher<br>|<br>1 … 15|Results in 0.5 to 7.5 steps<br>for_PWM_SCALE_AUTO_<br>|
||adaptation speed when_pwm_autoscale_=1.||regulatorper fullstep|
|_PWM_OFS_|User defined PWM amplitude (offset) for velocity-<br>based scaling and initialization value for automatic<br>tuningof_PWM_OFFS_AUTO_.|<br>0 … 255|_PWM_OFS_=0 disables<br>linear current scaling<br>based on current setting|
|_PWM_GRAD_|User defined PWM amplitude (gradient) for<br>velocity-based scaling and initialization value for<br>automatic tuningof_PWM_GRAD_AUTO_.|<br> <br>0 … 255||
|_FREEWHEEL_|Stand still option when motor current setting is<br>zero (_I_HOLD_=0). Only available with StealthChop|<br> <br>0<br>1|Normal operation<br>Freewheeling|
||enabled. The freewheeling option makes the<br>motor easy movable, while both coil short options<br>realize apassive brake.|<br> <br>2<br>3|Coil short via LS drivers<br>Coil short cia HS drivers|
|_PWM_SCALE_<br>__AUTO_|Read back of the actual StealthChop voltage PWM<br>scaling correction as determined by the current<br>regulator. Shall regulate close to 0 duringtuning.|<br> <br>-255 …<br>255|(read only) Scaling value<br>becomes frozen when<br>operatingin SpreadCycle|
|_PWM_GRAD_<br>__AUTO_<br>_PWM_OFS_<br>_AUTO_|Allow monitoring of the automatic tuning and<br>determination of initial values for_PWM_OFS_and<br>_PWM_GRAD_.|<br> <br>0 … 255|(read only)|
|__ _<br>_TOFF_|General enable for the motor driver, the actual<br>value does not influence StealthChop|<br>0<br>1 … 15|Driver off<br>Driver enabled|
|_TBL_|Comparator_blank time_. This time needs to safely<br>cover the switching event and the duration of the|<br> <br>0<br>1|16 tCLK<br>24 tCLK|
||ringing on the sense resistor. Choose a setting of|<br>2|36 tCLK|
||<br>1 or 2 for typical applications. For higher<br>capacitive loads, 3 may be required. Lower<br>settings allow StealthChop to regulate down to<br>lower coil current values.|<br> <br> <br> <br>3|54 tCLK|

## 7 SpreadCycle and Classic Chopper

While StealthChop is a voltage mode PWM controlled chopper, SpreadCycle is a cycle-by-cycle current control. Therefore, it can react extremely fast to changes in motor velocity or motor load. The currents through both motor coils are controlled using choppers. The choppers work independently of each other. In Figure 7.1 the different chopper phases are shown.

##### Figure 7.1 Chopper phases

Although the current could be regulated using only on phases and fast decay phases, insertion of the slow decay phase is important to reduce electrical losses and current ripple in the motor. The duration of the slow decay phase is specified in a control parameter and sets an upper limit on the chopper frequency. The current comparator can measure coil current during phases when the current flows through the sense resistor, but not during the slow decay phase, so the slow decay phase is terminated by a timer. The on phase is terminated by the comparator when the current through the coil reaches the target current. The fast decay phase may be terminated by either the comparator or another timer.

When the coil current is switched, spikes at the sense resistors occur due to charging and discharging parasitic capacitances. During this time, typically one or two microseconds, the current cannot be measured. Blanking is the time when the input to the comparator is masked to block these spikes. There are two cycle-by-cycle chopper modes available: a new high-performance chopper algorithm called SpreadCycle and a proven constant off-time chopper mode. The constant off-time mode cycles through three phases: on, fast decay, and slow decay. The SpreadCycle mode cycles through four phases: on, slow decay, fast decay, and a second slow decay.

The chopper frequency is an important parameter for a chopped motor driver. A too low frequency might generate audible noise. A higher frequency reduces current ripple in the motor, but with a too high frequency magnetic losses may rise. Also, power dissipation in the driver rises with increasing frequency due to the increased influence of switching slopes causing dynamic dissipation. Therefore, a compromise needs to be found. Most motors are optimally working in a frequency range of 16 kHz to 30 kHz. The chopper frequency is influenced by a number of parameter settings as well as by the motor inductivity and supply voltage.

> **Hint:** A chopper frequency in the range of 16 kHz to 30 kHz gives a good result for most motors when using SpreadCycle. A higher frequency leads to increased switching losses.

Three parameters are used for controlling both chopper modes:

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_TOFF_|Sets the slow decay time (_off time_). This setting also|0|chopper off|
||limits the maximum chopper frequency.<br>For operation with StealthChop, this parameter is not<br>used, but it is required to enable the motor. In case of<br>operation with StealthChop only, any setting is OK.<br>Setting this parameter to zero completely disables all<br>driver transistors and the motor can free-wheel.|1…15|off time setting<br>NCLK= 24 + 32*_TOFF_<br>(1 will work with minimum<br>blank time of 24 clocks)|
|_TBL_|Selects the comparator_blank time_. This time needs to<br>safely cover the switching event and the duration of the<br>ringing on the sense resistor. For most applications, a|0<br>1|16 tCLK<br>24 tCLK|
||setting of 1 or 2 is good. For highly capacitive loads,<br>e.g., when filter networks are used, a setting of 2 or 3<br>will be required.|2<br>3|36 tCLK<br>54 tCLK|
|_chm_|Selection of the_chopper mode_|0|SpreadCycle|
|||1|classic const. off time|
|_TPFD_|Adds passive fast decay time after bridge polarity<br>change. Starting from 0, increase value, in case the<br>motor suffers from mid-range resonances.|0…15|Fast decay time in multiple<br>of 128 clocks (128 clocks<br>are roughly10µs)|

### 7.1 SpreadCycle Chopper

The SpreadCycle (patented) chopper algorithm is a precise and simple to use chopper mode which automatically determines the optimum length for the fast-decay phase. The SpreadCycle will provide superior microstepping quality even with default settings. Several parameters are available to optimize the chopper to the application.

Each chopper cycle is comprised of an on phase, a slow decay phase, a fast decay phase and a second slow decay phase (see Figure 7.3). The two slow decay phases and the two blank times per chopper cycle put an upper limit to the chopper frequency. The slow decay phases typically make up for about 30%-70% of the chopper cycle in standstill and are important for low motor and driver power dissipation.

Calculation of a starting value for the slow decay time _TOFF_ :

##### EXAMPLE:

Target Chopper frequency: 25kHz. Assumption: Two slow decay cycles make up for 50% of overall chopper cycle time

The hysteresis start setting forces the driver to introduce a minimum amount of current ripple into the motor coils. The current ripple must be higher than the current ripple which is caused by resistive losses in the motor in order to give best microstepping results. This will allow the chopper to precisely regulate the current both for rising and for falling target current. The time required to introduce the current ripple into the motor coil also reduces the chopper frequency. Therefore, a higher hysteresis setting will lead to a lower chopper frequency. The motor inductance limits the

ability of the chopper to follow a changing motor current. Further the duration of the on phase and the fast decay must be longer than the blanking time because the current comparator is disabled during blanking.

It is easiest to find the best setting by starting from a low hysteresis setting (e.g., _HSTRT_ =0, _HEND_ =0) and increasing _HSTRT_ , until the motor runs smoothly at low velocity settings. This can best be checked when measuring the motor current either with a current probe or by probing the sense resistor voltages (see Figure 7.2). Checking the sine wave shape near zero transition will show a small ledge between both half waves in case the hysteresis setting is too small. At medium velocities (i.e., 100 to 400 fullsteps per second), a too low hysteresis setting will lead to increased humming and vibration of the motor.

**Figure 7.2 No ledges in current wave with sufficient hysteresis (magenta: current A, yellow & blue: sense resistor voltages A and B)**

A too high hysteresis setting will lead to reduced chopper frequency and increased chopper noise but will not yield any benefit for the wave shape.

_Quick Start_ For a quick start, see the Quick Configuration Guide in chapter 18. For detail procedure see Application Note AN001 - _Parameterization of SpreadCycle_

As experiments show, the setting is quite independent of the motor, because higher current motors typically also have a lower coil resistance. Therefore, choosing a low to medium default value for the hysteresis (for example, effective hysteresis = 4) normally fits most applications. The setting can be optimized by experimenting with the motor: A too low setting will result in reduced microstep accuracy, while a too high setting will lead to more chopper noise and motor power dissipation. When measuring the sense resistor voltage in motor standstill at a medium coil current with an oscilloscope, a too low setting shows a fast decay phase not longer than the blanking time. When the fast decay time becomes slightly longer than the blanking time, the setting is optimum. You can reduce the off-time setting, if this is hard to reach.

The hysteresis principle could in some cases lead to the chopper frequency becoming too low, e.g. when the coil resistance is high when compared to the supply voltage. This is avoided by splitting the hysteresis setting into a start setting ( _HSTRT+HEND_ ) and an end setting ( _HEND_ ). An automatic hysteresis decrementer (HDEC) interpolates between both settings, by decrementing the hysteresis value stepwise each 16 system clocks. At the beginning of each chopper cycle, the hysteresis begins with a value which is the sum of the start and the end values ( _HSTRT_ + _HEND_ ), and decrements during the cycle, until either the chopper cycle ends, or the hysteresis end value ( _HEND_ ) is reached. This way,

the chopper frequency is stabilized at high amplitudes and low supply voltage situations, if the frequency gets too low. This avoids the frequency reaching the audible range.

**Figure 7.3 SpreadCycle chopper scheme showing coil current during a chopper cycle**

Two parameters control SpreadCycle mode:

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_HSTRT_|_Hysteresis start_setting. This value is an offset<br>from the hysteresis end value_HEND_.|<br>0…7|_HSTRT_=1…8<br>This value adds to HEND.|
|_HEND_|_Hysteresis end_setting. Sets the hysteresis end<br>value after a number of decrements. The sum<br>_HSTRT_+_HEND_must be ≤16. At a current setting of|<br> <br>0…2<br>3|-3…-1: negative HEND<br>0: zero HEND|
||max. 30 (amplitude reduced to 240), the sum is<br>not limited.|<br>4…15|1…12: positive HEND|

With HSTRT=0 and HEND=0, the hysteresis is 0 (off).

##### EXAMPLE:

A hysteresis of 4 has been chosen. You might decide to not use hysteresis decrement. In this case set:

_HEND_ =6 (sets an effective end value of 6-3=3) _HSTRT_ =0 (sets minimum hysteresis, i.e. 1: 3+1=4)

In order to take advantage of the variable hysteresis, we can set most of the value to the HSTRT, i.e. 4, and the remaining 1 to hysteresis end. The resulting configuration register values are as follows:

_HEND_ =0 (sets an effective end value of -3) _HSTRT_ =6 (sets an effective start value of hysteresis end +7: 7-3=4)

_Hint_

Highest motor velocities sometimes benefit from setting TOFF to 2 or 3 and a short TBL of 2 or 1.

### 7.2 Classic Constant Off Time Chopper

The classic constant off time chopper is an alternative to SpreadCycle. Perfectly tuned, it also gives good results. Also, the classic constant off time chopper (automatically) is used in combination with fullstepping in DcStep operation.

The classic constant off-time chopper uses a fixed-time fast decay following each on phase. While the duration of the on phase is determined by the chopper comparator, the fast decay time needs to be long enough for the driver to follow the falling slope of the sine wave, but it should not be so long that it causes excess motor current ripple and power dissipation. This can be tuned using an oscilloscope or evaluating motor smoothness at different velocities. A good starting value is a fast decay time setting similar to the slow decay time setting.

**Figure 7.4 Classic const. off time chopper with offset showing coil current**

After tuning the fast decay time, the offset should be tuned for a smooth zero crossing. This is necessary because the fast decay phase makes the absolute value of the motor current lower than the target current (see Figure 7.5). If the zero offset is too low, the motor stands still for a short moment during current zero crossing. If it is set too high, it makes a larger microstep. Typically, a positive offset setting is required for smoothest operation.

**Figure 7.5 Zero crossing with classic chopper and correction using sine wave offset**

Three parameters control constant off-time mode:

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_TFD_|_Fast decay time_setting. With CHM=1, these bits|<br>0|slow decay only|
|(_fd3_<br>&<br>_HSTRT_)|control the portion of fast decay for each chopper<br>cycle.|1…15|duration of fast decay<br>phase|
|_OFFSET_<br>(_HEND_)|_Sine wave offset_. With CHM=1, these bits control<br>the sine wave offset. A positive offset corrects for<br>i|<br>0…2<br>3|negative offset: -3…-1<br>no offset: 0|
||zero crossng error.|4…15|positive offset 1…12|
|_disfdcc_|Selects usage of the_current comparator_for<br>termination of the_fast decay_cycle. If current<br>comparator is enabled, it terminates the fast decay|<br> <br> <br>0|enable comparator<br>termination of fast decay<br>cycle|
||cycle in case the current reaches a higher negative<br>value than the actualpositive value.|<br>1|end by time only|

## 8 Selecting Sense Resistors

The TMC2160 provides several means to set the motor current: Sense resistors, _GLOBALSCALER_ and currentscale _CS._ To adapt a drive to the motor, choose a sense-resistor value fitting or slightly exceeding the maximum desired current at 100% settings of the scalers. Fine-tune the current to the specific motor via the 8-bit _GLOBALSCALER_ . Situation specific motor current adaptation is done by 5-bit scalers (actual scale can be read via _CS_ ), controlled by CoolStep, run- and hold current ( _IRUN_ , _IHOLD_ ). This makes the _CS_ control compatible to other TRINAMIC ICs.

Set the desired maximum motor current by selecting an appropriate value for the sense resistor. The following table shows the RMS current values which are reached using standard resistors.

**CHOICE OF RSENSE AND RESULTING MAX. MOTOR CURRENT WITH GLOBALSCALER=0 (RESP. VALUE 256)**

|**RSENSE [Ω]**|**_RMS current [A]_**<br>**_(CS=31)_**<br>**_Sine wave peak_**<br>**_current[A] (CS=31)_**|
|---|---|
|0.22|1.1<br>1.5|
|0.15|1.6<br>2.2|
|0.12|2.0<br>2.8|
|0.10|2.3<br>3.3|
|0.075|3.1<br>4.4|
|0.066|3.5<br>5.0|
|0.050|4.7<br>6.6|
|0.033|7.1<br>10.0|
|0.022|10.6<br>15.0|

Sense resistors should be carefully selected. The full motor current flows through the sense resistors. Due to chopper operation the sense resistors see pulsed current from the MOSFET bridges. Therefore, a low-inductance type such as film or composition resistors is required to prevent voltage spikes causing ringing on the sense voltage inputs leading to unstable measurement results. Also, a lowinductance, low-resistance PCB layout is essential. A massive ground plane is best. Please also refer to layout considerations in chapter 25.

The sense resistor sets the upper current which can be set by software settings _IRUN_ , _IHOLD_ and _GLOBALSCALER_ . Choose the sense resistor value so that the maximum desired current (or slightly more) flows at the maximum current setting ( _GLOBALSCALER_ = 256 (0) and _IRUN_ = 31).

##### CALCULATION OF RMS CURRENT

The momentary motor current is calculated by:

_GLOBALSCALER_ is the global current scaler. A setting of 0 is treated as full scale (256). _CS_ is the current scale setting as set by the _IHOLD_ and _IRUN_ and CoolStep. _VFS_ is the full-scale voltage (please refer to electrical characteristics, V SRT). _CURA/B_ is the actual value from the internal sine wave table. 248 is the amplitude of the internal sine wave table.

The sense resistor needs to be able to conduct the peak motor coil current in motor standstill conditions unless standby power is reduced. Under normal conditions, the sense resistor conducts

less than the coil RMS current, because no current flows through the sense resistor during the slow decay phases.

##### CALCULATION OF PEAK SENSE RESISTOR POWER DISSIPATION

> **Hint:** For best precision of current setting, it is advised to measure and fine tune the current in the application. Choose the sense resistors to the next value covering the desired motor current. Set _IRUN_ to 31 corresponding 100% of the desired motor current and fine-tune motor current using _GLOBALSCALER_ .

> **Attention:** Be sure to use a symmetrical sense resistor layout and short and straight sense resistor traces of identical length. Well matching sense resistors ensure best performance. A compact layout with massive ground plane is best to avoid parasitic resistance effects.

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_IRUN_|Current scale when motor is running. Scales coil<br>current values as taken from the internal sine<br>wave table. For high precision motor operation,<br>work with a current scaling factor in the range 16<br>to 31, because scaling down the current values<br>reduces the effective microstep resolution by<br>making microsteps coarser. This setting also<br>controls the maximum current value set by<br>CoolStep.|<br> <br> <br> <br> <br> <br> <br> <br>0 … 31|scaling factor<br>1/32, 2/32, … 32/32|
|_IHOLD_|Identical to_IRUN_,but for motor in stand still.|||
|_IHOLD_|Allows smooth current reduction from run current|<br>0|instant_IHOLD_|
|_DELAY_|to hold current._IHOLDDELAY_controls the number<br>of clock cycles for motor power down after<br>_TZEROWAIT_in increments of 2^18 clocks: 0=instant<br>power down, 1..15: Current reduction delay per<br>current step in multiple of 2^18 clocks.|<br> <br> <br> <br>1 … 15|1*2<sup>18</sup>… 15*2<sup>18</sup><br>clocks per current<br>decrement|
||_Example:_When using_IRUN_=31 and_IHOLD_=16, 15<br>current steps are required for hold current<br>reduction. A_IHOLDDELAY_setting of 4 thus results<br>in a power down time of 4*15*2^18 clock cycles,<br>i.e.,roughlyone second at 16MHz.|<br> <br> <br>||
|_GLOBAL_<br>_SCALER_|Allows fine control of the motor current range<br>setting|<br>0 … 255|scales in 1/256 steps<br>0=full scale|

## 9 Velocity Based Mode Control

The TMC2160 allows the configuration of different chopper modes and modes of operation for optimum motor control. Depending on the motor load, the different modes can be optimized for lowest noise & high precision, highest dynamics, or maximum torque at highest velocity. Some of the features like CoolStep or StallGuard2 are useful in a limited velocity range. A number of velocity thresholds allow combining the different modes of operation within an application requiring a wide velocity range.

##### Figure 9.1 Choice of velocity dependent modes

Figure 9.1 shows all available thresholds and the required ordering. VPWMTHRS, VHIGH and VCOOLTHRS are determined by the settings _TPWMTHRS_ , _THIGH_ and _TCOOLTHRS._ The velocity is described by the time interval _TSTEP_ between each two step pulses. This allows determination of the velocity when an external step source is used. _TSTEP_ always becomes normalized to 256 microstepping. This way, the thresholds do not have to be adapted when the microstep resolution is changed. The thresholds represent the same motor velocity, independent of the microstep settings. _TSTEP_ becomes compared to these threshold values. A hysteresis of 1/16 _TSTEP_ resp. 1/32 _TSTEP_ is applied to avoid continuous toggling of the comparison results when a jitter in the _TSTEP_ measurement occurs. The upper switching velocity is higher by 1/16, resp. 1/32 of the value set as threshold. The motor current can be programmed to a run and a hold level, dependent on the standstill flag _stst_ .

Using automatic velocity thresholds allows tuning the application for different velocity ranges. Features like CoolStep will integrate completely transparently in your setup. This way, once <u>parameterized, they do not require any activation or deactivation via software.</u>

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_stst_|This flag indicates motor stand still in each operation<br>mode. This occurs 2^20 clocks after the last step pulse.|0/1|Status bit, read only|
|_TPOWER_<br>_DOWN_|This is the delay time after stand still (_stst_) of the<br>motor to motor current power down. Time range<br>is about 0 to 4 seconds. Setting 0 is no delay, 1 a<br>minimum delay. Further increment is in discrete<br>steps of 2^18 clock cycles.|<br> <br> <br> <br>_0…255_|Time in multiples of 2^18<br>_tCLK_<br>Set at minimum to 2 to<br>allow automatic tuning of<br>_PWM_OFS_AUTO_|
|_TSTEP_|Actual<br>measured<br>time<br>between<br>two<br>1/256<br>microsteps derived from the step input frequency<br>in units of 1/fCLK. Measured value is (2^20)-1 in<br>case of overflow or stand still|<br> <br> <br>0…<br>1048575|<br>Status register, read only.<br>Actual measured step time<br>in multiple of_tCLK_|
|_TPWMTHRS_|.<br>_TSTEP_≥_TPWMTHRS_<br>-<br>StealthChop PWM mode is enabled, if<br>configured<br>-<br>DcStepis disabled|<br>0…<br>1048575|<br>Setting to control the<br>upper velocity threshold<br>for operation in<br>StealthChop|
|_TCOOLTHRS_|_TCOOLTHRS_≥_TSTEP_≥_THIGH_:<br>-<br>CoolStep is enabled, if configured<br>-<br>StealthChop<br>voltage<br>PWM<br>mode<br>is<br>disabled<br>_TCOOLTHRS_≥_TSTEP_<br>-<br>Stall<br>output<br>signal<br>is<br>enabled,<br>if<br>configured|<br> <br>0…<br>1048575|<br>Setting to control the<br>lower velocity threshold<br>for operation with<br>CoolStep and stallGuard|
|_THIGH_|_TSTEP_≤_THIGH_:<br>-<br>CoolStep is disabled (motor runs with<br>normal current scale)<br>-<br>StealthChop<br>voltage<br>PWM<br>mode<br>is<br>disabled<br>-<br>If_vhighchm_is set, the chopper switches<br>to_chm_=1 with_TFD_=0 (constant off time<br>with slow decay, only).<br>-<br>If_vhighfs_is set, the motor operates in<br>fullstep mode, and the stall detection<br>becomes switched over to DcStep stall<br>|<br> <br> <br> <br> <br> <br> <br>0…<br>1048575|<br>Setting to control the<br>upper threshold for<br>operation with CoolStep<br>and stallGuard as well as<br>optional high velocity step<br>mode|
||detection.|||
|_small__|Hysteresis for step frequency comparison based|<br>0|Hysteresis is 1/16|
|_hysteresis_|on<br>_TSTEP_<br>(lower<br>velocity<br>threshold)<br>and<br>(_TSTEP_*15/16)-1 respectively (_TSTEP_*31/32)-1 (upper<br>velocitythreshold)|<br> <br>1|Hysteresis is 1/32|
|_vhighfs_|<br>This bit enables switching to fullstep, when_VHIGH_<br>is exceeded. Switching takes place only at 45°<br>position. The fullstep target current uses the<br>current value from the microstep table at the 45°<br>position.|<br> <br>0<br>1|No switch to fullstep<br>Fullstep at high velocities|
|_vhighchm_|This bit enables switching to_chm_=1 and_fd_=0, when<br>_VHIGH_is exceeded. This way, a higher velocity can<br>be achieved. Can be combined with_vhighfs_=1. If set,<br>the_TOFF_setting automatically becomes doubled<br>during high velocity operation to avoid doubling of<br>the chopper frequency.|<br> <br> <br> <br> <br>0<br>1|No change of chopper<br>mode<br>Classic const. Toff chopper<br>at high velocities|
|_en_pwm__<br>_mode_|StealthChop voltage PWM enable flag (depending<br>on velocity thresholds). Switch from off to on<br>state while in stand still,only.|<br> <br>0<br>1|No StealthChop<br>StealthChop below<br>VPWMTHRS|

## 10 Diagnostics and Protection

The TMC2160 supplies a complete set of diagnostic and protection capabilities, like short circuit protection and undervoltage detection. Open load detection allows testing if a motor coil connection is interrupted. See the _DRV_STATUS_ table for details.

### 10.1 Temperature Sensors

The driver integrates a four-level temperature sensor (120°C pre-warning and selectable 136°C / 143°C / 150°C thermal shutdown) for diagnostics and for protection of the IC and the power MOSFETs and adjacent components against excess heat. Choose the overtemperature level to safely cover error conditions like missing heat convection. Heat is mainly generated by the power MOSFETs, and, at increased voltage, by the internal voltage regulators. For many applications, already the overtemperature pre-warning will indicate an abnormal operation situation and can be used to initiate user warning or power reduction measures like motor current reduction. The thermal shutdown is just an emergency measure and temperature rising to the shutdown level should be prevented by design.

After triggering the overtemperature sensor ( _ot_ flag), the driver remains switched off until the system temperature falls below the pre-warning level ( _otpw_ ) to avoid continuous heating to the shutdown level.

### 10.2 Short Protection

The TMC2160 protects the MOSFET power stages against a short circuit or overload condition by monitoring the voltage drop in the high-side MOSFETs, as well as the voltage drop in sense resistor and low-side MOSFETs (Figure 10.1). A programmable short detection delay ( _shortdelay_ ) allows adjusting the detector to work with very slow switching slopes. Additionally, the short detector allows filtering of the signal. This helps to prevent spurious triggering caused by effects of PCB layout, or long, adjacent motor cables ( _SHORTFILTER_ ). All control bits are available via register _SHORT_CONF_ . Additionally, the short detection is protected against single events, e.g., caused by ESD discharges, by retrying three times before switching off the motor continuously.

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_S2VS_LEVEL_|Short or overcurrent detector level for lowside<br>FETs. Checks for voltage drop in LS MOSFET and<br>sense resistor.<br>_Hint:_6 to 8 recommended, down to 4 at low<br>current scale|4…15|4 (highest sensitivity) …<br>15 (lowest sensitivity)<br>_(Reset Default:_<br>_OTP 6 or 12)_|
|_S2G_LEVEL_|_S2G_LEVEL_:<br>Short to GND detector level for highside FETs.<br>Checks for voltage drop on high side MOSFET.<br>_Hint:_6 to 14 recommended (minimum 12 if the<br>bridge supplyvoltage can exceed 52V)|<br>_2…15_|2 (highest sensitivity) …<br>15 (lowest sensitivity)<br>_(Reset Default:_<br>_OTP 6 or 12)_|
|_SHORT__<br>_FILTER_|Spike filtering bandwidth for short detection<br>_Hint:_A good PCB layout will allow using setting 0.<br>Increase value if erroneous short detection occurs.|0…3|0 (lowest, 100ns),<br>1 (1µs) (_Reset Default_),<br>2 (2µs),<br>3 (3µs)|
|_shortdelay_|_shortdelay_: Short detection delay<br>The short detection delay shall cover the bridge<br>switchingtime. 0 will work for most applications.|0/1|0=750ns: normal,<br>1=1500ns: high|
|_CHOPCONF._<br>_diss2vs_|Allows to disable short to VS protection.|0/1|Leave detection enabled<br>for normal use(0).|
|_CHOPCONF._<br>_diss2g_|Allows to disable short to GND protection.|0/1|Leave detection enabled<br>for normal use(0).|

**Figure 10.1 Short detection**

As the low-side short detection includes the sense resistor, it can be set to a high sensitivity and provides good precision of current detection. This way, it will safely cover most overcurrent conditions, i.e., when the motor stalls, or is abruptly stopped in StealthChop mode.

> **Hint:** Once a short condition is safely detected, the corresponding driver bridge (A or B) becomes switched off, and the _s2ga_ or _s2gb_ flag, respectively _s2vsa_ or _s2vsb_ becomes set. To restart the motor, disable and re-enable the driver.

> **Attention:** Short protection cannot protect the system and the power stages for all possible short events, as a short event is rather undefined, and a complex network of external components may be involved. Therefore, short circuits should basically be avoided.

> **Hint:** Set low-side short protection (S2VS) to sensitively detect an overcurrent condition (at 150 to 200% of nominal peak current). Especially with low resistive motors an overcurrent can easily be triggered by false settings, or motor stall when using StealthChop. Therefore, a sensitive short to VS setting will <u>protect the power stage.</u>

> **Attention:** High-side short detection (S2G) sensitivity may increase at voltages above 52V. Therefore, a higher setting is required if motor supply voltage can overshoot up to 55V. We recommend a setting of 12 to 15 in this case. For fine tuning of overcurrent detection, trim the S2VS detector threshold. High-side short detection may falsely trigger if motor supply voltage overshoots 55V.

### 10.3 Open Load Diagnostics

Interrupted cables are a common cause for systems failing, e.g., when connectors are not firmly plugged. The TMC2160 detects open load conditions by checking if it can reach the desired motor coil current. This way, also undervoltage conditions, high motor velocity settings or short and overtemperature conditions may cause triggering of the open load flag, and inform the user, that motor torque may suffer. In motor stand still, open load cannot be measured, as the coils might eventually have zero current.

Open load detection is provided for system debugging. To safely detect an interrupted coil connection, operate in SpreadCyle, and check the open load flags following a motion of minimum four times the selected microstep resolution into a single direction using low or nominal motor velocity operation, only. However, the _ola_ and _olb_ flags have just informative character and do not cause any action of the driver.

## 11 StallGuard2 Load Measurement

StallGuard2 provides an accurate measurement of the load on the motor. It can be used for stall detection as well as other uses at loads below those which stall the motor, such as CoolStep loadadaptive current reduction. The StallGuard2 measurement value changes linearly over a wide range of load, velocity, and current settings, as shown in Figure 11.1. At maximum motor load, the value goes to zero or near to zero. This corresponds to a load angle of 90° between the magnetic field of the coils and magnets in the rotor. This also is the most energy-efficient point of operation for the motor.

**Figure 11.1 Function principle of StallGuard2**

|**Parameter**|**Description**|**Setting**|**Comment**|
|---|---|---|---|
|_SGT_|This signed value controls the StallGuard2<br>threshold level for stall detection and sets the<br>optimum measurement range for readout. A<br>lower value gives a higher sensitivity. Zero is the<br>starting value working with most motors. A<br>higher value makes StallGuard2 less sensitive and<br>requires more torque to indicate a stall.|0<br>+1… +63<br>-1… -64|indifferent value<br>less sensitivity<br>higher sensitivity|
|_sfilt_|Enables the StallGuard2 filter for more precision<br>of the measurement. If set, reduces the<br>measurement frequency to one measurement per<br>electricalperiod of the motor(4 fullsteps).|0<br>1|standard mode<br>filtered mode|
|**Status word**|**Description**|**Range **|**Comment**|
|_SG_RESULT_|This is the_StallGuard2 result_. A higher reading<br>indicates less mechanical load. A lower reading<br>indicates a higher load and thus a higher load<br>angle. Tune the_SGT_setting to show a_SG_RESULT_<br>reading of roughly 0 to 100 at maximum load<br>before motor stall.|0… 1023|0: highest load<br>low value: high load<br>high value: less load|
|_Hint_||||
|In order to us<br>SGT setting!|e StallGuard2 and CoolStep, the StallGuard2 sensiti|vity shou|ld first be tuned using the|

### 11.1 Tuning StallGuard2 Threshold SGT

The StallGuard2 value _SG_RESULT_ is affected by motor-specific characteristics and application-specific demands on load and velocity. Therefore, the easiest way to tune the StallGuard2 threshold _SGT_ for a specific motor type and operating conditions is interactive tuning in the actual application.

##### INITIAL PROCEDURE FOR TUNING STALLGUARD SGT

1. Operate the motor at the normal operation velocity for your application and monitor _SG_RESULT_ .

2. Apply slowly increasing mechanical load to the motor. If the motor stalls before _SG_RESULT_ reaches zero, decrease _SGT_ . If _SG_RESULT_ reaches zero before the motor stalls, increase _SGT_ . A good _SGT_ starting value is zero. _SGT_ is signed, so it can have negative or positive values.

3. Set _TCOOLTHRS_ to a value above _TSTEP_ and monitor the StallGuard output signal (configure DIAG0 or DIAG1 to output stall detection). Stop the motor when a pulse is seen on the respective output. Make sure, that the motor is safely stopped whenever it is stalled. Increase _SGT_ if the motor becomes stopped before a stall occurs.

4. The optimum setting is reached when _SG_RESULT_ is between 0 and roughly 100 at increasing load shortly before the motor stalls, and _SG_RESULT_ increases by 100 or more without load. _SGT_ in most cases can be tuned for a certain motion velocity or a velocity range. Make sure, that the setting works reliable in a certain range (e.g. 80% to 120% of desired velocity) and also under extreme motor conditions (lowest and highest applicable temperature).

##### OPTIONAL PROCEDURE ALLOWING AUTOMATIC TUNING OF SGT

The basic idea behind the SGT setting is a factor, which compensates the StallGuard measurement for resistive losses inside the motor. At standstill and very low velocities, resistive losses are the main factor for the balance of energy in the motor, because mechanical power is zero or near to zero. This way, SGT can be set to an optimum at near zero velocity. This algorithm is especially useful for tuning SGT within the application to give the best result independent of environment conditions, motor stray, etc.

1. Operate the motor at low velocity < 10 RPM (i.e., a few to a few fullsteps per second) and target operation current and supply voltage. In this velocity range, there is not much dependence of _SG_RESULT_ on the motor load, because the motor does not generate significant back EMF. Therefore, mechanical load will not make a big difference on the result.

2. Switch on _sfilt_ . Now increase _SGT_ starting from 0 to a value, where _SG_RESULT_ starts rising. With a high _SGT_ , _SG_RESULT_ will rise up to the maximum value. Reduce again to the highest value, where _SG_RESULT_ stays at 0. Now the _SGT_ value is set as sensibly as possible. When you see _SG_RESULT_ increasing at higher velocities, there will be useful stall detection.

The upper velocity for the stall detection with this setting is determined by the velocity, where the motor back EMF approaches the supply voltage, and the motor current starts dropping when further increasing velocity.

_SG_RESULT_ goes to zero when the motor stalls and the stall output becomes activated. The external motion controller should react to a single pulse by stopping the motor, if desired. Set _TCOOLTHRS_ to match the lower velocity threshold where StallGuard delivers a good result.

The power supply voltage also affects _SG_RESULT_ , so tighter voltage regulation results in more accurate values. StallGuard measurement has a high resolution, and there are a few ways to enhance its accuracy, as described in the following sections.

_Quick Start_ For a quick start, see the Quick Configuration Guide in chapter 18. For detail procedure see Application Note AN002 - _Parameterization of StallGuard2 & CoolStep_

#### 11.1.1 Variable Velocity Limits TCOOLTHRS and THIGH

The _SGT_ setting chosen as a result of the previously described _SGT_ tuning can be used for a certain velocity range. Outside this range, a stall may not be detected safely, and CoolStep might not give the optimum result.

##### Figure 11.2 Example: optimum SGT setting and StallGuard2 reading with an example motor

In many applications, operation at or near a single operation point is used most of the time and a single setting is sufficient. The driver provides a lower and an upper velocity threshold to match this. The stall detection is disabled outside the determined operation point, e.g. during acceleration phases preceding a sensorless homing procedure when setting _TCOOLTHRS_ to a matching value. An upper limit can be specified by _THIGH_ .

In some applications, a velocity dependent tuning of the _SGT_ value can be expedient, using a small number of support points and linear interpolation.

#### 11.1.2 Small Motors with High Torque Ripple and Resonance

Motors with a high detent torque show an increased variation of the StallGuard2 measurement value SG with varying motor currents, especially at low currents. For these motors, the current dependency should be checked for best result.

#### 11.1.3 Temperature Dependence of Motor Coil Resistance

Motors working over a wide temperature range may require temperature correction, because motor coil resistance increases with rising temperature. This can be corrected as a linear reduction of _SGT_ at increasing temperature, as motor efficiency is reduced.

#### 11.1.4 Accuracy and Reproducibility of StallGuard2 Measurement

In a production environment, it may be desirable to use a fixed _SGT_ value within an application for one motor type. Most of the unit-to-unit variation in StallGuard2 measurements results from manufacturing tolerances in motor construction. The measurement error of StallGuard2 – provided that all other parameters remain stable – can be as low as:

𝑠𝑡𝑎𝑙𝑙𝐺𝑢𝑎𝑟𝑑 𝑚𝑒𝑎𝑠𝑢𝑟𝑒𝑚𝑒𝑛𝑡 𝑒𝑟𝑟𝑜𝑟= ±𝑚𝑎𝑥(1, |𝑆𝐺𝑇|)

### 11.2 StallGuard2 Update Rate and Filter

The StallGuard2 measurement value _SG_RESULT_ is updated with each full step of the motor. This is enough to safely detect a stall because a stall always means the loss of four full steps. In a practical application, especially when using CoolStep, a more precise measurement might be more important than an update for each fullstep because the mechanical load never changes instantaneously from one step to the next. For these applications, the _sfilt_ bit enables a filtering function over four load measurements. The filter should always be enabled when high-precision measurement is required. It compensates for variations in motor construction, for example due to misalignment of the phase A to phase B magnets. The filter should be disabled when rapid response to increasing load is required and for best results of sensorless homing using StallGuard.

### 11.3 Detecting a Motor Stall

For best stall detection, work without StallGuard filtering ( _sfilt_ =0). To safely detect a motor stall the stall threshold must be determined using a specific _SGT_ setting. Therefore, the maximum load needs to be determined, which the motor can drive without stalling. At the same time, monitor the _SG_RESULT_ value at this load, e.g., some value within the range 0 to 100. The stall threshold should be a value safely within the operating limits, to allow for parameter stray. The response at an _SGT_ setting at or near 0 gives some idea on the quality of the signal: Check the _SG_ value without load and with maximum load. They should show a difference of at least 100 or a few 100, which shall be large compared to the offset. If you set the _SGT_ value in a way, that a reading of 0 occurs at maximum motor load, the stall can be automatically detected by the motion controller to issue a motor stop. In the moment of the step resulting in a step loss, the lowest reading will be visible. After the step loss, the motor will vibrate and show a higher _SG_RESULT_ reading.

### 11.4 Homing with StallGuard

The homing of a linear drive requires moving the motor into the direction of a hard stop. As StallGuard needs a certain velocity to work (as set by _TCOOLTHRS_ ), make sure that the start point is far enough away from the hard stop to provide the distance required for the acceleration phase. After setting up _SGT_ and the ramp generator registers, start a motion into the direction of the hard stop and activate the stop on stall function of your controller. Best results are yielded at 30% to 70% of nominal motor current and typically 1 to 5 RPS (motors smaller than NEMA17 may require higher velocities).

### 11.5 Limits of StallGuard2 Operation

StallGuard2 does not operate reliably at extreme motor velocities: Very low motor velocities (for many motors, less than one revolution per second) generate a low back EMF and make the measurement unstable and dependent on environment conditions (temperature, etc.). The automatic tuning procedure described above will compensate for this. Other conditions will also lead to extreme settings of _SGT_ and poor response of the measurement value _SG_RESULT_ to the motor load.

Very high motor velocities, in which the full sinusoidal current is not driven into the motor coils also leads to poor response. These velocities are typically characterized by the motor back EMF reaching the supply voltage.

## 12 CoolStep Operation

CoolStep is an automatic smart energy optimization for stepper motors based on the motor mechanical load, making them “green”.

### 12.1 User Benefits

- _Energy efficiency_ – consumption decreased up to 75% _Motor generates less heat_ – improved mechanical precision _Less cooling infrastructure_ – for motor and driver _Cheaper motor_ – does the job!

CoolStep allows substantial energy savings, especially for motors which see varying loads or operate at a high duty cycle. Because a stepper motor application needs to work with a torque reserve of 30% to 50%, even a constant-load application allows significant energy savings because CoolStep automatically enables torque reserve when required. Reducing power consumption keeps the system cooler, increases motor life, and allows reducing cost in the power supply and cooling components.

# Reducing motor current by half results in reducing <u>power by a factor of four.</u> ~~CO~~

### 12.2 Setting up for CoolStep

CoolStep is controlled by several parameters, but two are critical for understanding how it works:

|**Parameter**|**Description**|**Range**|**Comment**|
|---|---|---|---|
|_SEMIN_|4-bit unsigned integer that sets a_lower threshold_.<br>If_SG_goes below this threshold, CoolStep<br>increases the current to both coils. The 4-bit<br>_SEMIN_value is scaled by 32 to cover the lower<br>half of the range of the 10-bit_SG_value. (The<br>name<br>of this<br>parameter is<br>derived<br>from<br>smartEnergy, which is an earlier name for<br>CoolStep.)|0<br>1…15|disable CoolStep<br>threshold is_SEMIN_*32|
|_SEMAX_|4-bit unsigned integer that controls an_upper_<br>_threshold_. If SG is sampled equal to or above this<br>threshold enough times, CoolStep decreases the<br>current to both coils. The upper threshold is<br>(_SEMIN_+_SEMAX_+ 1)*32.|0…15|threshold is<br>(_SEMIN_+_SEMAX_+1)*32|

Figure 12.1 shows the operating regions of CoolStep:

- The black line represents the _SG_ measurement value.

- The blue line represents the mechanical load applied to the motor.

- The red line represents the current into the motor coils.

When the load increases, _SG_RESULT_ falls below _SEMIN_ , and CoolStep increases the current. When the ~~Po~~ load decreases, _SG_RESULT_ rises above ( _SEMIN_ + _SEMAX_ + 1) * 32, and the current is reduced.

**Figure 12.1 CoolStep adapts motor current to the load**

Five more parameters control CoolStep and one status value is returned:

|**Parameter**|**Description**|**Range **|**Comment**|
|---|---|---|---|
|_SEUP_|Sets the_current increment step_. The current<br>becomes<br>incremented<br>for<br>each<br>measured<br>StallGuard2 value below the lower threshold.|<br> <br>0…3|step width is<br>1, 2, 4, 8|
|_SEDN_|Sets the number of StallGuard2 readings above<br>the upper threshold necessary for each_current_<br>_decrement_of the motor current.|<br> <br>0…3|number of StallGuard2<br>measurements per<br>decrement:<br>32,8,2,1|
|_SEIMIN_|Sets the_lower motor current limit_for CoolStep<br>operation byscalingthe_IRUN_current setting.|<br>0<br>1|0: 1/2 of IRUN<br>1: 1/4 of IRUN|
|_TCOOL_<br>_THRS_|Lower<br>velocity<br>threshold<br>for<br>switching on<br>CoolStep and stall output. Below this velocity<br>CoolStep becomes disabled. Adapt to the lower<br>limit of the velocity range where StallGuard2 gives<br>a stable result.<br>_Hint:_May be adapted to disable CoolStep during<br>acceleration and deceleration phase by setting<br>identical to_VMAX_.|<br> <br> <br> <br> <br>1…<br>2^20-1|Specifies lower CoolStep<br>velocity by comparing<br>the threshold value to<br>_TSTEP_|
|_THIGH_|Upper velocity threshold value for CoolStep and<br>stall output signal. Above this velocity CoolStep<br>becomes disabled. Adapt to the velocity range<br>where StallGuard2gives a stable result.|<br> <br>1…<br>2^20-1|Also controls additional<br>functions like switching<br>to fullstepping.|
|**Status**<br>**word**|**Description**|**Range**|**Comment**|
|_CSACTUAL_|This status value provides the_actual motor_<br>_current_ _scale_as controlled by CoolStep. The value<br>goes up to the_IRUN_value and down to the<br>portion of_IRUN_as specified by _SEIMIN_.|<br> <br> <br>0…31|1/32, 2/32, … 32/32|

### 12.3 Tuning CoolStep

Before tuning CoolStep, first tune the StallGuard2 threshold level _SGT_ , which affects the range of the load measurement value _SG_RESULT_ . CoolStep uses _SG_RESULT_ to operate the motor near the optimum load angle of +90°.

The current increment speed is specified in _SEUP_ , and the current decrement speed is specified in _SEDN_ . They can be tuned separately because they are triggered by different events that may need different responses. The encodings for these parameters allow the coil currents to be increased much more quickly than decreased, because crossing the lower threshold is a more serious event that may require a faster response. If the response is too slow, the motor may stall. In contrast, a slow response to crossing the upper threshold does not risk anything more serious than missing an opportunity to save power.

CoolStep operates between limits controlled by the current scale parameter _IRUN_ and the _seimin_ bit.

#### 12.3.1 Response Time

For fast response to increasing motor load, use a high current increment step _SEUP_ . If the motor load changes slowly, a lower current increment step can be used to avoid motor oscillations. If the filter controlled by _sfilt_ is enabled, the measurement rate and regulation speed are cut by a factor of four.

_Hint_

The most common and most beneficial use is to adapt CoolStep for operation at the typical system target operation velocity and to set the velocity thresholds according. As acceleration and decelerations normally shall be quick, they will require the full motor current, while they have only a small contribution to overall power consumption due to their short duration.

#### 12.3.2 Low Velocity and Standby Operation

Because CoolStep is not able to measure the motor load in standstill and at very low RPM, a lower velocity threshold is provided for enabling CoolStep. It should be set to an application specific default value. Below this threshold the normal current setting via _IRUN_ respectively _IHOLD_ is valid. An upper threshold is provided by the _VHIGH_ setting. Both thresholds can be set as a result of the StallGuard2 tuning process.

## 13 STEP/DIR Interface

The STEP and DIR inputs provide a simple, standard interface compatible with many existing motion controllers. The MicroPlyer STEP pulse interpolator brings the smooth motor operation of highresolution microstepping to applications originally designed for coarser stepping. In case an external step source is used, the complete integrated motion controller can be switched off.

### 13.1 Timing

Figure 13.1 shows the timing parameters for the STEP and DIR signals, and the table below gives their specifications. When the _dedge_ mode bit in the _CHOPCONF_ register is set, both edges of STEP are active. If _dedge_ is cleared, only rising edges are active. STEP and DIR are sampled and synchronized to the system clock. An internal analog filter removes glitches on the signals, such as those caused by long PCB traces. If the signal source is far from the chip, and especially if the signals are carried on cables, the signals should be filtered or differentially transmitted.

**Figure 13.1 STEP and DIR timing, Input pin filter**

|**STEP and DIR interface timing**|**AC-Charact**<br>clockperio|**eristics**<br>d is tCLK|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|step frequency (at maximum<br>|fSTEP|_dedge_=0|||½ fCLK||
|microstep resolution)||_dedge_=1|||¼ fCLK||
|fullstepfrequency|fFS||||fCLK/512||
|STEP input low time *)|tSL||max(tFILTSD,<br>tCLK+20)|100||ns|
|STEP input high time *)|tSH||max(tFILTSD,<br>tCLK+20)|100||ns|
|DIR to STEP setuptime|tDSU||20|||ns|
|DIR after STEP hold time|tDSH||20|||ns|
|STEP and DIR spike filtering time<br>*)|tFILTSD|rising and falling<br>edge|13|20|30|ns|
|STEP and DIR sampling relative<br>to risingCLK input|tSDCLKHI|before rising edge<br>of CLK input||tFILTSD||ns|

*) These values are valid with full input logic level swing, only. Asymmetric logic levels will increase filtering delay tFILTSD, due to an internal input RC filter.

### 13.2 Changing Resolution

The TMC2160 includes an internal microstep table with 1024 sine wave entries to generate sinusoidal motor coil currents. These 1024 entries correspond to one electrical revolution or four fullsteps. The microstep resolution setting determines the step width taken within the table. Depending on the DIR input, the microstep counter is increased (DIR=0) or decreased (DIR=1) with each STEP pulse by the step width. The microstep resolution determines the increment respectively the decrement. At maximum resolution, the sequencer advances one step for each step pulse. At half resolution, it advances two steps. Increment is up to 256 steps for fullstepping. The sequencer has special provision to allow seamless switching between different microstep rates at any time. When switching to a lower microstep resolution, it calculates the nearest step within the target resolution and reads the current vector at that position. This behavior especially is important for low resolutions like fullstep and halfstep because any failure in the step sequence would lead to asymmetrical run when comparing a motor running clockwise and counterclockwise.

**EXAMPLES:** _Fullstep_ : Cycles through table positions: 128, 384, 640 and 896 (45°, 135°, 225° and 315° electrical position, both coils on at identical current). The coil current in each position corresponds to the RMS-Value (0.71 * amplitude). Step size is 256 (90° electrical)

_Half step_ : The first table position is 64 (22.5° electrical), Step size is 128 (45° steps) _<u>Quarter step</u>_ : The first table position is 32 (90°/8=11.25° electrical), Step size is 64 (22.5° steps)

This way equidistant steps result, and they are identical in both rotation directions. Some older drivers also use zero current (table entry 0, 0°) as well as full current (90°) within the step tables. This kind of stepping is avoided because it provides less torque and has a worse power dissipation in driver and motor.

|**Step position**|**tableposition**|**current coil A**|**current coil B**|
|---|---|---|---|
|Half step0|64|38.3%|92.4%|
|Full step0|128|70.7%|70.7%|
|Half step1|192|92.4%|38.3%|
|Half step2|320|92.4%|-38.3%|
|Full step1|384|70.7%|-70.7%|
|Half step3|448|38.3%|-92.4%|
|Half step4|576|-38.3%|-92.4%|
|Full step2|640|-70.7%|-70.7%|
|Half step5|704|-92.4%|-38.3%|
|Half step6|832|-92.4%|38.3%|
|Full step3|896|-70.7%|70.7%|
|Half step7|960|-38.3%|92.4%|

### 13.3 MicroPlyer and Stand Still Detection

For each active edge on STEP, MicroPlyer produces microsteps at 256x resolution, as shown in Figure 13.2. It interpolates the time in between of two step impulses at the step input based on the last step interval. This way, from 2 microsteps (128 microstep to 256 microstep interpolation) up to 256 microsteps (full step input to 256 microsteps) are driven for a single step pulse.

Enable MicroPlyer by setting the _intpol_ bit in the _CHOPCONF_ register. _GCONF.faststandstill_ allows reduction of standstill detection time to 2^18 clocks (~20ms)

The step rate for the interpolated 2 to 256 microsteps is determined by measuring the time interval of the previous step period and dividing it into up to 256 equal parts. The maximum time between two microsteps corresponds to 2<sup>20</sup> (roughly one million system clock cycles), for an even distribution of 256 microsteps. At 12 MHz system clock frequency, this results in a minimum step input frequency of 12 Hz for MicroPlyer operation (50 Hz with _faststandstill_ = 1). A lower step rate causes the _STST_ bit to be set, which indicates a standstill event. At that frequency, microsteps occur at a rate of (system clock frequency)/2<sup>16</sup> ~ 256 Hz. When a stand still is detected, the driver automatically switches the motor to holding current _IHOLD_ .

_Hint_

MicroPlyer only works perfectly with a stable STEP frequency. Do not use the _dedge_ option if the STEP signal does not have a 50% duty cycle.

**Figure 13.2 MicroPlyer microstep interpolation with rising STEP frequency (Example: 16 to 256)**

In Figure 13.2, the first STEP cycle is long enough to set the standstill bit _stst_ . This bit is cleared on the next STEP active edge. Then, the external STEP frequency increases. After one cycle at the higher rate MicroPlyer adapts the interpolated microstep rate to the higher frequency. During the last cycle at the slower rate, MicroPlyer did not generate all 16 microsteps, so there is a small jump in motor angle between the first and second cycles at the higher rate. With the flag _GCONF.faststandstill_ enabled, standstill detection is after 2^18 clocks (rather than 2^20 clocks) without step pulse. This allows faster current reduction for energy saving in drives with short stand still times.

## 14 DIAG Outputs

Operation with an external motion controller often requires quick reaction to certain states of the stepper motor driver. Therefore, the DIAG outputs supply a configurable set of different real time information complementing the STEP/DIR interface.

Both, the information available at DIAG0 and DIAG1 can be selected as well as the type of output (low active open drain – default setting, or high active push-pull). In order to determine a reset of the driver, DIAG0 always shows a power-on reset condition by pulling low during a reset condition. Figure 14.1 shows the available signals and control bits.

**Figure 14.1 DIAG outputs**

The stall output signal allows StallGuard2 to be handled by the external motion controller like a stop switch. The index output signals the microstep counter zero position, to allow the application to reference the drive to a certain current pattern. Chopper on-state shows the on-state of both coil choppers (alternating) when working in SpreadCycle or constant off time to determine the duty cycle. The DcStep skipped information is an alternative way to find out when DcStep runs with a velocity below the step velocity. It toggles with each step not taken by the sequencer.

> **Attention:** The duration of the index pulse corresponds to the duration of the microstep. When working without interpolation at less than 256 microsteps, the index time goes down to two CLK clock cycles.

## 15 DcStep

DcStep is an automatic commutation mode for the stepper motor. It allows the stepper to run with its target velocity as commanded by the Step signal, as long as it can cope with the load. In case the motor becomes overloaded, it slows down to a velocity, where the motor can still drive the load. This way, the stepper motor never stalls and can drive heavy loads as fast as possible. Its higher torque available at lower velocity, plus dynamic torque from its flywheel mass allows compensating for mechanical torque peaks. In case the motor becomes completely blocked, the stall flag becomes set.

### 15.1 User Benefits

- _Motor_ – never loses steps _Application_ – works as fast as possible _Acceleration_ – automatically as high as possible _Energy efficiency_ – highest at speed limit _Cheaper motor_ – does the job!

### 15.2 Designing-In DcStep

In a classical application, the operation area is limited by the maximum torque required at maximum application velocity. A safety margin of up to 50% torque is required, to compensate for unforeseen load peaks, torque loss due to resonance and aging of mechanical components. DcStep allows using up to the full available motor torque. Even higher short time dynamic loads can be overcome using motor and application flywheel mass without the danger of a motor stall. With DcStep the nominal application load can be extended to a higher torque only limited by the safety margin near the holding torque area (which is the highest torque the motor can provide). Additionally, maximum application velocity can be increased up to the actually reachable motor velocity.

**Figure 15.1 DcStep extended application operation area**

_Quick Start_ For a quick start, see the Quick Configuration Guide in chapter 18. For detail configuration procedure see Application Note AN003 - _DcStep_

### 15.3 Stall Detection in DcStep Mode

While DcStep is able to decelerate the motor upon overload, it cannot avoid a stall in every operation situation. Once the motor is blocked, or it becomes decelerated below a motor dependent minimum velocity where the motor operation cannot safely be detected any more, the motor may stall and loose steps. A StallGuard2 load value also is available during DcStep operation. The range of values is limited to 0 to 255, in certain situations up to 511 will be read out. To enable stallGuard, also set _TCOOLTHRS_ corresponding to a velocity slightly above _VDCMIN_ or up to _VMAX_ .

Stall detection in this mode may trigger falsely due to resonances when flywheel loads are loosely coupled to the motor axis.

|**Parameter**|**Description**|**Range **|**Comment**|
|---|---|---|---|
|_vhighfs_<br>_&_<br>_vhighchm_|These chopper configuration flags in_CHOPCONF_<br>need to be set for DcStep operation. As soon as<br>_VDCMIN_becomes exceeded, the chopper becomes<br>switched to fullstepping.|<br>0 / 1|set to 1 for DcStep|
|_TOFF_|DcStep often benefits from an increased off time<br>value in_CHOPCONF_. Settings >2 should be<br>preferred.|2… 15|Settings 8…15 do not make<br>any difference to setting 8<br>for DcStepoperation.|
|_VDCMIN_|This is the lower threshold for DcStep operation<br>when using internal ramp generator. Below this<br>threshold, the motor operates in normal microstep<br>mode. In DcStep operation, the motor operates at<br>minimum_VDCMIN_, even when it is completely<br>blocked. Tune together with_DC_TIME_setting.|<br> <br>0… 2^22|0: Disable DcStep<br>Set to the lower velocity<br>limit for DcStep operation.|
||Activation of StealthChopalso disables DcStep.|||
|_DC_TIME_|This setting controls the reference pulse width for<br>DcStep load measurement. It must be optimized<br>for robust operation with maximum motor torque.<br>A higher value allows higher torque and higher<br>velocity, a lower value allows operation down to<br>a lower velocity as set by_VDCMIN_.<br>Check best setting under nominal operation<br>conditions, and re-check under extreme operating<br>conditions (e.g., lowest operation supply voltage,<br>highest motor temperature, and highest supply<br>voltage,lowest motor temperature).|<br>0… 1023|Lower limit for the setting<br>is:_tBLANK_(as defined by<br>_TBL_) in clock cycles +_n_<br>with_n_in the range 1 to<br>100 (for a typical motor)|
|_DC_SG_|This setting controls stall detection in DcStep<br>mode. Increase for higher sensitivity.<br>A stall can be used as an error condition by<br>issuing a hard stop for the motor. Stop the motor<br>upon an impulse on the stall output (configure<br>DIAG0 or DIAG1 to signal a stall). This way the<br>motor will be stopped once it stalls.|<br> <br> <br>0… 255|Set slightly higher than<br>_DC_TIME_/ 16|

### 15.4 DcStep with STEP/DIR Interface

The TMC2160 provides two ways to use DcStep when interfaced to an external motion controller. The first way gives direct control of the DcStep step execution to the external motion controller, which must react to motor overload and is allowed to override a blocked motor situation. The second way assumes that the external motion controller cannot directly react to DcStep signals. The TMC2160 automatically reduces the motor velocity or stops the motor upon overload. To allow the motion controller to react to the reduced real motor velocity in this mode, the counter _LOST_STEPS_ gives the number of steps which have been commanded, but not taken by the motor controller. The motion controller can later on read out _LOST_STEPS_ and drive any missing number of steps. In case of a blocked motor, it tries moving it with the minimum velocity as programmed by _VDCMIN_ .

Enabling DcStep automatically sets the chopper to constant TOFF mode with slow decay only. This way, no re-configuration is required when switching from microstepping mode to DcStep and back.

DcStep operation is controlled by three pins in STEP and DIR mode:

- DCEN –  Forces the driver to DcStep operation if high. A velocity-based activation of DcStep is controlled by _TPWMTHRS_ when using StealthChop operation for low velocity settings. In this case, DcStep is disabled while in StealthChop mode, i.e. at velocities below the StealthChop switching velocity.

- DCO – Informs the motion controller when motor is not ready to take a new step (low level). The motion controller shall react by delaying the next step until DCO becomes high. The sequencer can buffer up to the effective number of microsteps per fullstep to allow the motion controller to react to assertion of DCO. In case the motor is blocked this wait-situation can be terminated after a timeout by providing a long > 1024 clock STEP input, or via the internal _VDCMIN_ setting.

- DCIN – Commands the driver to wait with step execution and to disable DCO. This input can be used for synchronization of multiple drivers operating with DcStep.

#### 15.4.1 Using LOSTSTEPS for DcStep Operation

This is the simplest possibility to integrate DcStep with an external motion controller: The external motion controller enables DcStep using DCEN or the internal velocity threshold. The TMC2160 tries to follow the steps. In case it needs to slow down the motor, it counts the difference between incoming steps on the STEP signal and steps going to the motor. The motion controller can read out the difference and compensate for the difference after the motion or on a cyclic basis. Figure 15.2 shows the principle (simplified).

In case the motor driver needs to postpone steps due to detection of a mechanical overload in DcStep, and the motion controller does not react to this by pausing the step generation, _LOST_STEPS_ becomes incremented or decremented (depending on the direction set by DIR) with each step which is not taken. This way, the number of lost steps can be read out and executed later on or be appended to the motion. As the driver needs to slow down the motor while the overload situation persists, the application will benefit from a high microstepping resolution, because it allows more seamless acceleration or deceleration in DcStep operation. In case the application is completely blocked, _VDCMIN_ sets a lower limit to the step execution. If the motor velocity falls below this limit, however an unknown number of steps is lost, and the motor position is not exactly known any more. DCIN allows for step synchronization of two drivers: it stops the execution of steps if low and sets DCO low.

**Figure 15.2 Motor moving slower than STEP input due to light overload. LOSTSTEPS incremented**

#### 15.4.2 DCO Interface to Motion Controller

In STEP/DIR mode, DCEN enables DcStep. It is up to the external motion controller to enable DcStep either, once a minimum step velocity is exceeded within the motion ramp, or to use the automatic threshold _VDCMIN_ for DcStep enable.

The STEP/DIR interface works in microstep resolution, even if the internal step execution is based on fullstep. This way, no switching to a different mode of operation is required within the motion controller. The DcStep output DCO signals if the motor is ready for the next step based on the DcStep measurement of the motor. If the motor has not yet mechanically taken the last step, this step cannot be executed, and the driver stops automatically before execution of the next fullstep. This situation is signaled by DCO. The external motion controller shall stop step generation if DCOUT is low and wait until it becomes high again. Figure 15.4 shows this principle. The driver buffers steps during the waiting period up to the number of microstep setting minus one. In case, DCOUT does not go high within the lower step limit time e.g., due to a severe motor overload, a step can be enforced: override the stop status by a long STEP pulse with min. 1024 system clocks length. When using internal clock, a pulse length of minimum 125µs is recommended.

**Figure 15.3 Full signal interconnection for DcStep**

**Figure 15.4 DCO Interface to motion controller – step generator stops when DCO is asserted**

## 16 Sine-Wave Look-up Table

The TMC2160 driver provides a programmable look-up table for storing the microstep current wave. As a default, the table is pre-programmed with a sine wave, which is a good starting point for most stepper motors. Reprogramming the table to a motor specific wave allows drastically improved microstepping especially with low-cost motors.

### 16.1 User Benefits

- _Microstepping_ – extremely improved with low-cost motors _Motor_ – runs smooth and quiet _Torque_ – reduced mechanical resonances yields improved torque

### 16.2 Microstep Table

In order to minimize required memory and the amount of data to be programmed, only a quarter of the wave becomes stored. The internal microstep table maps the microstep wave from 0° to 90°. It becomes symmetrically extended to 360°. When reading out the table the 10-bit microstep counter _MSCNT_ addresses the fully extended wave table. The table is stored in an incremental fashion, using each one bit per entry. Therefore only 256 bits ( _ofs00_ to _ofs255_ ) are required to store the quarter wave. These bits are mapped to eight 32-bit registers. Each _ofs_ bit controls the addition of an inclination _Wx_ or _Wx_ +1 when advancing one step in the table. When _Wx_ is 0, a 1 bit in the table at the actual microstep position means “add one” when advancing to the next microstep. As the wave can have a higher inclination than 1, the base inclinations _Wx_ can be programmed to -1, 0, 1, or 2 using up to four flexible programmable segments within the quarter wave. This way even negative inclination can be realized. The four inclination segments are controlled by the position registers _X1_ to _X3_ . Inclination segment 0 goes from microstep position 0 to _X1_ -1 and its base inclination is controlled by _W0_ , segment 1 goes from _X1_ to _X2_ -1 with its base inclination controlled by _W1_ , etc.

When modifying the wave, care must be taken to ensure a smooth and symmetrical zero transition when the quarter wave becomes expanded to a full wave. The maximum resulting swing of the wave should be adjusted to a range of -248 to 248, to give the best possible resolution while leaving headroom for the hysteresis-based chopper to add an offset.

**Figure 16.1 LUT programming example**

When the microstep sequencer advances within the table, it calculates the actual current values for the motor coils with each microstep and stores them to the registers _CUR_A_ and _CUR_B_ . However, the incremental coding requires an absolute initialization, especially when the microstep table becomes modified. Therefore _CUR_A_ and _CUR_B_ become initialized whenever _MSCNT_ passes zero.

Two registers control the starting values of the tables:

- As the starting value at zero is not necessarily 0 (it might be 1 or 2), it can be programmed into the starting point register _START_SIN_ .

- In the same way, the start of the second wave for the second motor coil needs to be stored in _START_SIN90_ . This register stores the resulting table entry for a phase shift of 90° for a 2- phase motor.

_Hint_

Refer chapter 5.3 for the register set and for the default table function stored in the drivers. The default table is a good base for realizing an own table. The TMC2160-EVAL comes with a calculation tool for own waves.

_Initialization example for the default microstep table:_

_MSLUT[0]_ = %10101010101010101011010101010100 = 0xAAAAB554 _MSLUT[1]_ = %01001010100101010101010010101010 = 0x4A9554AA _MSLUT[2]_ = %00100100010010010010100100101001 = 0x24492929 _MSLUT[3]_ = %00010000000100000100001000100010 = 0x10104222 _MSLUT[4]_ = %11111011111111111111111111111111 = 0xFBFFFFFF _MSLUT[5]_ = %10110101101110110111011101111101 = 0xB5BB777D _MSLUT[6]_ = %01001001001010010101010101010110 = 0x49295556 _MSLUT[7]_ = %00000000010000000100001000100010 = 0x00404222

_MSLUTSEL_ = 0xFFFF8056: _X1_ =128, _X2_ =255, _X3_ =255 _W3_ =%01, _W2_ =%01, _W1_ =%01, _W0_ =%10

_MSLUTSTART_ = 0x00F70000: _START_SIN_0_ = 0, _START_SIN90_ = 247

## 17 Emergency Stop

The driver provides a negative active enable pin DRV_ENN to safely switch off all power MOSFETs. This allows putting the motor into freewheeling. Further, it is a safe hardware function whenever an emergency-stop not coupled to software is required. Some applications may require the driver to be put into a state with active holding current or with a passive braking mode. This is possible by programming the pin DCIN to act as a step disable function. Set GCONF flag _stop_enable_ to activate this option. Whenever DCIN becomes pulled up, the motor will stop abruptly and go to the power down state, as configured via _IHOLD_ , _IHOLDDELAY_ and StealthChop standstill options. Disabling the driver via DRV_ENN will require three clock cycles to safely switch off the driver.

## 18 Quick Configuration Guide

This guide is meant as a practical tool to come to a first configuration and do a minimum set of measurements and decisions for tuning the driver. It does not cover all advanced functionalities but concentrates on the basic function set to make a motor run smoothly. Once the motor runs, you may decide to explore additional features, e.g., freewheeling, and further functionality in more detail. A current probe on one motor coil is a good aid to find the best settings, but it is not a must.

##### CURRENT SETTING AND FIRST STEPS WITH STEALTHCHOP

**Figure 18.1 Current setting and first steps with StealthChop**

##### TUNING STEALTHCHOP AND SPREADCYCLE

**Figure 18.2 Tuning StealthChop and SpreadCycle**

##### ENABLING COOLSTEP (ONLY IN COMBINATION WITH SPREADCYCLE)

**Figure 18.3 Enabling CoolStep (only in combination with SpreadCycle)**

##### SETTING UP DCSTEP

**Figure 18.4 Setting up DcStep (using TMC4361 as motion controller)**

## 19 Getting Started

Please refer to the TMC2160 evaluation board to allow a quick start with the device, and to allow interactive tuning of the device setup in your application. Chapter 18 will guide you through the process of correctly setting up all registers.

### 19.1 Initialization Examples

SPI datagram example sequence to enable the driver for step and direction operation and initialize the chopper for SpreadCycle operation and for StealthChop at <30 RPM @ 12MHz clock:

SPI send: 0xEC000100C3; // CHOPCONF: TOFF=3, HSTRT=4, HEND=1, TBL=2, CHM=0 (SpreadCycle) SPI send: 0x9000061F0A; // IHOLD_IRUN: IHOLD=10, IRUN=31 (max. current), IHOLDDELAY=6 SPI send: 0x910000000A; // TPOWERDOWN=10: Delay before power down in stand still SPI send: 0x8000000004; // EN_PWM_MODE=1 enables StealthChop (with default PWMCONF) SPI send: 0x93000001F4; // TPWM_THRS=500 yields a switching velocity about 35000 = ca. 30RPM

_Hint_

Tune the configuration parameters for your motor and application for optimum performance.

## 20 Standalone Operation

For standalone operation, no SPI interface is required to configure the TMC2160. All pins with suffix CFG0 to CFG6 have a special meaning in this mode and can be tied either to VCC_IO or to GND.

**Figure 20.1 Standalone operation with TMC2160 (pins shown with their standalone mode names)**

To activate standalone mode, tie pin SPI_MODE to GND. In this mode, the driver acts as a pure STEP and DIR driver. SPI and single wire are off. The driver works in SpreadCycle mode or StealthChop mode. With regard to the register set, the following settings are activated:

The following settings are affected by the CFG pins to ensure correct configuration:

**CFG0/CFG1: CONFIGURATION OF MICROSTEP RESOLUTION FOR STEP INPUT**

|**CFG1**|**CFG0**|**Microstep Setting**|
|---|---|---|
|GND|GND|8 microsteps, _MRES_=5|
|GND|VCC_IO|16 microsteps, _MRES_=4|
|VCC_IO|GND|32 microsteps, _MRES_=3|
|VCC_IO|VCC_IO|64 microsteps, _MRES_=2|

**CFG4/CFG3/CFG2: CONFIGURATION OF RUN CURRENT**

|**CFG4**|**CFG3**|**CFG2**|**_IRUN_ Setting**|
|---|---|---|---|
|GND|GND|GND|_IRUN_=16|
|GND|GND|VCC_IO|_IRUN_=18|
|GND|VCC_IO|GND|_IRUN_=20|
|GND|VCC_IO|VCC_IO|_IRUN_=22|
|VCC_IO|GND|GND|_IRUN_=24|
|VCC_IO|GND|VCC_IO|_IRUN_=26|
|VCC_IO|VCC_IO|GND|_IRUN_=28|
|VCC_IO|VCC_IO|VCC_IO|_IRUN_=31|

**CFG5: SELECTION OF CHOPPER MODE**

|**CFG5**|**Chopper Setting**|
|---|---|
|GND|SpreadCycle operation.(_TOFF_=3)|
|VCC_IO|StealthChopoperation.(_GCONF_.en_PWM_mode=1)|
|**CFG6: CONFI**|**GURATION OFHOLDCURRENTREDUCTION**|
|**CFG6*)**|**Chopper Setting**|
|GND|No hold current reduction. IHOLD=IRUN|
|VCC_IO|Reduction to 50%. IHOLD=1/2 IRUN|

> **Hint:** Be sure to allow the motor to rest for at least 100ms (assuming a minimum of 10MHz f CLK ) before starting a motion using StealthChop. This will allow the current regulation to set the initial motor current.

##### ) CFG6: Attention

CFG6 pin draws significant current (20mA) when driven to a different level than CFG5, because the output driver tries to make CFG6 level equal to CFG5. Therefore, a 0 Ohm resistor is required to pull up/down CFG6. Due to this, setting CFG6 different from CFG5 is only recommended with external VCC_IO supply at 3.3V level.

> **Attention:** DIAG outputs are not configured per default. They can be activated using the interfaces before switching to standalone mode.

## 21 Power-Up Reset

The chip is loaded with default values during power-up via its internal power-on reset. It will also reset to power-up defaults in case any of the supply voltages monitored by internal reset circuitry (VSA, +5VOUT or VCC_IO) falls below the undervoltage threshold. VCC is not monitored. Therefore, VCC must not be lost during operation of the chip. In case of a microcontroller software re-boot, disable the driver ( _TOFF_ =0), re-initialize all registers used by the software and stop any motion in progress by slowing down the ramp generator. A hardware reset requires cycling VCC_IO while keeping all digital inputs at a low level at the same time. Actively drive VCC_IO to a low level to ensure that it falls below the lower reset threshold. Current consumed from VCC_IO is low and therefore it has simple driving requirements. Due to the input protection diodes not allowing the digital inputs to rise above VCC_IO level, any active high input would hinder VCC_IO from going down.

## 22 Clock Oscillator and Input

The clock is the timing reference for all functions: the chopper, DcStep, blank time, etc. Many parameters are scaled with the clock frequency; thus, a precise reference allows a more deterministic result. The factory-trimmed on-chip clock oscillator provides a good and stable timing for most use cases.

### 22.1 Using the Internal Clock

Directly tie the CLK input to GND near to the IC if the internal clock oscillator is to be used. It will be sufficient for applications, where a velocity precision of roughly +-4% is tolerable.

### 22.2 Using an External Clock

When an external clock is available, a frequency of 10 MHz to 16 MHz is recommended for optimum performance. The duty cycle of the clock signal is uncritical, as long as minimum high or low input time for the pin is satisfied (refer to electrical characteristics). Up to 18 MHz can be used, when the clock duty cycle is 50%. Make sure, that the clock source supplies clean CMOS output logic levels and steep slopes when using a high clock frequency. The external clock input is enabled with the second positive polarity seen on the CLK input.

_Hint_

Switching off the external clock frequency prevents the driver from operating normally. Therefore, an internal watchdog switches back to internal clock in case the external signal is missing for more than roughly 32 internal clock cycles.

#### 22.2.1 Considerations on the Frequency

A higher frequency allows faster SPI operation and higher chopper frequencies. On the other hand, it causes more power dissipation in the TMC2160 digital core and 5V voltage regulator. Generally, a frequency of 10 MHz to 12 MHz should be sufficient for most applications. At higher clock frequency, the VSA supply voltage should be connected to a lower voltage for applications working at more than 24V nominal supply voltage. For reduced requirements concerning the motor dynamics, a clock frequency of down to 8 MHz (or even lower) can be considered.

## 23 Absolute Maximum Ratings

The maximum ratings may not be exceeded under any circumstances. Operating the circuit at or near more than one maximum rating at a time for extended periods shall be avoided by application design.

|**Parameter**|**Symbol**|**Min**|**Max**|**Unit**|
|---|---|---|---|---|
|Supplyvoltage operatingwith inductive load|VVS,VVSA|-0.5|60|V|
|Supply and bridge voltage short time peak (limited by<br>peak voltage on chargepumpoutput and Cxxpins*)|VVSMAX||64|V|
|VSA when different from VS|VVSAMAX|-0.5|60|V|
|Peak voltages on Cxx bootstrap pins and VCP|VCxCP||76|V|
|Supplyvoltage V12|V12VOUT|-0.5|14|V|
|Peak voltages on BMpins (due to strayinductivity)|VBMx|-6|VVS+6|V|
|Peak voltages on Cxx bootstrap pins relative to BM|VCxBMx|-0.5|16|V|
|I/O supplyvoltage on VCC_IO|VVIO|-0.5|5.5|V|
|digital VCC supplyvoltage(normallysupplied by5VOUT)|VVCC|-0.5|5.5|V|
|Logic input voltage|VI|-0.5|VVIO+0.5|V|
|Maximum current to / from digital pins<br>and analoglow voltage I/Os (short timepeak current)|IIO||+/-500|mA|
|5V regulator output current (internalplus external load)|I5VOUT||30|mA|
|5V regulator continuouspower dissipation(VVSA-5V)* I5VOUT|P5VOUT||1|W|
|12V regulator output current(internalplus external load)|I12VOUT||20|mA|
|12V regulator continuous power dissipation (VVSA-12V) *<br>I12VOUT|P12VOUT||0.5|W|
|Junction temperature|TJ|-50|150|°C|
|Storage temperature|TSTG|-55|150|°C|
|ESD-Protection for interface pins (Human body model,<br>HBM)|VESDAP||4|kV|
|ESD-Protection for handling (Human bodymodel,HBM)|VESD||1|kV|

*) Stray inductivity of power routing will lead to ringing of the supply voltage when driving an inductive load. This ringing results from the fast switching slopes of the driver outputs in combination with reverse recovery of the body diodes of the output driver MOSFETs. Even small trace inductivities as well as stray inductivity of sense resistors can easily generate a few volts of ringing leading to temporary voltage overshoot. This should be considered when working near the maximum voltage.

## 24 Electrical Characteristics

### 24.1 Operational Range

|**Parameter**|**Symbol**|**Min**|**Max**|**Unit**|
|---|---|---|---|---|
|Junction temperature|TJ|-40|125|°C|
|Supplyvoltage for motor and bridge|VVS|10|55|V|
|Supplyvoltage VSA|VVSA|10|50|V|
|Supply voltage for VSA and 12OUT (internal gate voltage<br>regulator bridged)|V12VOUT,<br>VVSA|10|13|V|
|Lower Supply voltage (reduced spec, short to GND<br>protection not functional), lower limit depending on<br>MOSFETsgate threshold voltage and load current|VVS|8||V|
|I/O supplyvoltage on VCC_IO|VVIO|3.00|5.25|V|

### 24.2 DC and Timing Characteristics

DC characteristics contain the spread of values guaranteed within the specified supply voltage range unless otherwise specified. Typical values represent the average value of all parts measured at +25°C. Temperature variation also causes stray to some values. A device with typical values will not leave Min/Max range within the full temperature range.

|**Power supply current**|**DC-Chara**<br>VVS= VVSA|**cteristics**<br>= 24.0V|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Total supply current, driver<br>disabled IVS+ IVSA|IS|fCLK=12MHz / internal<br>clock||18|24|mA|
|VSA supply current (VS and VSA<br>separated)|IVSA|fCLK=12MHz / internal<br>clock,driver disabled||15||mA|
|Total supply current, operating,<br>MOSFETs AOD4126,IVS+ IVSA|IS|fCLK=12MHz, 23.4kHz<br>chopper,no load||25||mA|
|Internal current consumption<br>from 5V supplyon VCCpin|IVCC|fCLK=12MHz||10||mA|
|Internal current consumption<br>from 5V supplyon VCCpin|IVCC|fCLK=16MHz||12.5||mA|
|IO supply current on VCC_IO<br>(typ. at 5V)|IVIO|no load on outputs,<br>inputs at VIOor GND<br>Excludes pullup /<br>pull-down resistors||15|30|µA|

|**Motor driver section**|**DC- and T**<br>VVS= 24.0|**iming-Characteristic**<br>V; Tj=50°C|**s**||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|RDSONlowside off driver|RONL|Gate off||1.8|3|Ω|
|RDSONhighside off driver|RONH|Gate off||2.2|3.5|Ω|
|Gate drive current low side|ISLP0|_DRVSTRENGTH_=0||200||mA|
|MOSFET turning on/off at 2V VGS|ISLP2|_DRVSTRENGTH_=2||400||mA|
||ISLP3|_DRVSTRENGTH_=3||600||mA|
|Gate drive current high side|ISLP0|_DRVSTRENGTH_=0||150||mA|
|MOSFET turning on/off at 2V VGS|ISLP2|_DRVSTRENGTH_=2||300||mA|
||ISLP3|_DRVSTRENGTH_=3||450||mA|
|BBM time via internal delay (start<br>of gate switching off to start of|tBBM0|_BBMCLKS_=0<br>_BBMTIME_=0|75|100||ns|
|gate switching on)|tBBM16|_BBMTIME_=16||200||ns|
||tBBM16|_BBMTIME_=24||375|500|ns|

|**Charge pump**|**DC-Chara**|**cteristics**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Charge pump output voltage|VVCP-VVS|operating|V12VOUT-<br>2|V12VOUT-<br>1||V|
|Charge pump voltage threshold<br>for undervoltage detection|VVCP-VVS|rising, using internal<br>5V regulator voltage|<br>4.5|5|6.5|V|
|Charge pump frequency|fCP|||1/16<br>fCLKOSC|||

|**Linear regulator**|**DC-Chara**<br>VVS= VVSA|**cteristics**<br>= 24.0V|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Output voltage|V5VOUT|TJ= 25°C|4.80|5.0|5.20|V|
|Deviation of output voltage over<br>the full temperature range|V5VOUT(DEV)|drivers disabled<br>TJ= full range||+/-30|+/-100|mV|
|Deviation of output voltage over<br>the full supply voltage range|V5VOUT(DEV)|drivers disabled,<br>internal clock<br>TA= 25°C<br>VVSA= 10V to 30V|||+/-50|mV /<br>10V|
|Output voltage|V12VOUT|operating, internal<br>clock<br>TJ= 25°C|10.8|11.5|12.2|V|

|**Clock oscillator and input**|**Timing-C**|**haracteristics**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Clock oscillator frequency|fCLKOSC|tJ=-50°C||11.7||MHz|
|(factory calibrated)|fCLKOSC|tJ=50°C|11.5|12.0|12.5|MHz|
||fCLKOSC|tJ=150°C||12.1||MHz|
|External clock frequency<br>(operating)|fCLK||4|10-16|18|MHz|
|External clock high / low level<br>time|tCLKH/<br>tCLKL|CLK driven to<br>0.1 VVIO/ 0.9 VVIO|16|||ns|
|External clock first pulse to<br>trigger switchingto external CLK|tCLKH/<br>tCLKL|CLK driven high<br>_A-version_|16|||ns|
|External clock first pulse to<br>trigger switchingto external CLK|tCLKH/<br>tCLKL|CLK driven high<br>_non-A-version_only|30|25||ns|
|External clock timeout detection<br>in cycles of internal fCLKOSC|tCLKH1|CLK driven high|32||48|cycles<br>fCLKOSC|

|**Short detection**|**DC-Chara**|**cteristics**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Short to GND / Short to VS<br>detector delay (Start of gate<br>switch on to short detected)|tSD0|_FILT_ISENSE_=0<br>_S2xx_LEVEL_=6<br>_shortdelay_=0|0.5|0.85|1.1|µs|
|Including100ns filteringtime|tSD1|_shortdelay_=1|1.1|1.6|2.2|µs|
|Short detector level S2VS|VBM|_S2VS_LEVEL_=15|1.4|1.56|1.72|V|
|(measurement includes drop in<br>sense resistor)||_S2VS_LEVEL_=6|0.55|0.625|0.70|V|
|Short detector level S2G|VS- VBM|_S2G_LEVEL_=15;<br>VS<52V|1.2|1.56|1.9|V|
|||_S2G_LEVEL_=15;<br>VS<55V|0.85|||V|
|||_S2G_LEVEL_=6;<br>VS<52V|0.46|0.625|0.80|V|

|**Detector levels**|**DC-Chara**|**cteristics**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|VVSAundervoltage threshold for<br>RESET|VUV_VSA|VVSArising|3.6|4|4.6|V|
|V5VOUTundervoltage threshold for<br>RESET|VUV_5VOUT|V5VOUTrising||3.5||V|
|VVCC_IOundervoltage threshold for<br>RESET|<br>VUV_VIO|VVCC_IOrising (delay<br>typ. 10µs)|2.0|2.5|3.0|V|
|VVCC_IOundervoltage detector<br>hysteresis|VUV_VIOHYST|||0.3||V|
|Overtemperature prewarning<br>120°C|TOTPW|Temperature rising|100|120|140|°C|
|Overtemperature shutdown<br>136 °C|TOT136|Temperature rising||136||°C|
|Overtemperature shutdown<br>143 °C|TOT143|Temperature rising||143||°C|
|Overtemperature shutdown<br>150 °C|TOT150|Temperature rising|135|150|170|°C|

|**Sense resistor voltage levels**|**DC-Chara**<br>**fCLK=16MH**|**cteristics**<br>**z**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Sense input peak threshold<br>voltage<br>(VSRxH-VSRxL)|VSRT|_GLOBALSCALER_=0<br>_csactual_=31<br>_sin_x_=248<br>Hyst.=0;IBRxy=0||325||mV|
|Sense input tolerance / motor<br>current full-scale tolerance<br>-usinginternal reference|ICOIL|_GLOBALSCALER_=0|-5||+5|%|

|**Digitalpins**|**DC-Chara**|**cteristics**|||||
|---|---|---|---|---|---|---|
|**Parameter**|**Symbol**|**Conditions**|**Min**|**Typ**|**Max**|**Unit**|
|Input voltage low level|VINLO||-0.3||0.3 VVIO|V|
|Input voltage high level|VINHI||0.7 VVIO||VVIO+0.3|<br>V|
|Input Schmitt trigger hysteresis|VINHYST|||0.12<br>VVIO||V|
|Output voltage low level|VOUTLO|IOUTLO= 2mA|||0.2|V|
|Output voltage high level|VOUTHI|IOUTHI= -2mA|VVIO-0.2|||V|
|Input leakage current|IILEAK||-10||10|µA|
|Pullup/pull-down resistors|RPU/RPD||132|166|200|kΩ|
|Digitalpin capacitance|C|||3.5||pF|

### 24.3 Thermal Characteristics

The following table shall give an idea on the thermal resistance of the package. The thermal resistance for a four-layer board will provide a good idea on a typical application. Actual thermal characteristics will depend on the PCB layout, PCB type and PCB size. The thermal resistance will benefit from thicker CU (inner) layers for spreading heat horizontally within the PCB. Also, air flow will reduce thermal resistance.

|**Parameter**|**Symbol**|**Conditions**|**Typ**|**Unit**|
|---|---|---|---|---|
|Typical power dissipation|PD|StealthChop or SpreadCycle, 40 or<br>20kHz chopper, 24V, internal supply<br>regulators|0.6|W|
|Thermal resistance junction to<br>ambient on a multilayer board|RTMJA|Dual signal and two internal power<br>plane board (2s2p) as defined in<br>JEDEC EIA JESD51-5 and JESD51-7<br>(FR4, 35µm CU, 70mm x 133mm,<br>d=1.5mm)|21|K/W|
|Thermal resistance junction to<br>board|RTJB|PCB temperature measured within<br>1mm distance to the package leads|8|K/W|
|Thermal resistance junction to<br>case|RTJC|Junction temperature to heat slug of<br>package|3|K/W|

##### Table 24.1 Thermal characteristics TQFP48-EP

The thermal resistance in an actual layout can be tested by checking for the heat up caused by the standby power consumption of the chip. When no motor is attached, all power seen on the power supply is dissipated within the chip.

## 25 Layout Considerations

### 25.1 Exposed Die Pad

The TMC2160 uses its die attach pad to dissipate heat from the gate drivers and the linear regulator to the board. For best electrical and thermal performance, use a reasonable amount of solid, thermally conducting vias between the die attach pad and the ground plane. The printed circuit board should have a solid ground plane spreading heat into the board and providing for a stable GND reference.

### 25.2 Wiring GND

All signals of the TMC2160 are referenced to their respective GND. Directly connect all GND pins under the device to a common ground area (GND, GNDP, GNDA and die attach pad). The GND plane right below the die attach pad should be treated as a virtual star point. For thermal reasons, the PCB top layer shall be connected to a large PCB GND plane spreading heat within the PCB.

_Attention_

Place the TMC2160 near to the MOSFET bridge and sense resistor GND to avoid ringing leading to GND differences and to dangerous inductive peak voltages.

### 25.3 Wiring Bridge Supply

The power bridge will draw the full coil current in pulses with extremely high dI/dt. Thus, any inductivity between VS supply filtering and the MOSFETs can lead to severe voltage spikes. This must be avoided. Avoid any bend in the supply traces between filtering capacitors and MOSFET switches and keep distance as small as possible. Especially for high current, use a separate plane for the supply voltage, and a sufficient number and capacity for supply filtering. Use an additional capacitor for the IC VS pin, as additional ripple voltage would cause severe current spikes on the charge pump capacitor. A tiny series resistor can be added to avoid this.

> **Attention:** Keep supply voltage ripple low, by using sufficient filtering capacity close to the MOSFET bridge.

### 25.4 Supply Filtering

The 5VOUT output voltage ceramic filtering capacitor (2.2 to 4.7 µF recommended) should be placed as close as possible to the 5VOUT pin, with its GND return going directly to the GNDA pin. This ground connection shall not be shared with other loads or additional vias to the GND plane. Use as short and as thick connections as possible. For best microstepping performance and lowest chopper noise an additional filtering capacitor should be used for the VCC pin to GND, to avoid digital part ripple influencing motor current regulation. Therefore, place a ceramic filtering capacitor (470nF recommended) as close as possible (1-2mm distance) to the VCC pin with GND return going to the ground plane. VCC can be coupled to 5VOUT using a 2.2 Ω or 3.3 Ω resistor to supply the digital logic from 5VOUT while keeping ripple away from this pin. A 100 nF filtering capacitor should be placed as close as possible to the VSA pin to ground plane. Make sure, that VS does not see excessive voltage spikes caused by bridge operation and place a 100 nF or larger filter capacitor to GND close to the VS pin.

Please carefully read chapters 3.3 and 3.4 to understand the special considerations regarding layout and component selection for the external MOSFET power bridges.

### 25.5 Layout Example

##### Schematic (TMC2160+MOSFETs shown)

##### 3- Inner Layer (supply VS) 4- Bottom Layer

##### Components

**Figure 25.1 Layout example**

_Hint_

When using the TQFP package in designs for more than 30V consider PCB coating to satisfy sufficient creeping distances.

## 26 Package Mechanical Data

### 26.1 Dimensional Drawings TQFP48-EP

_Drawings not to scale._

**Figure 26.1 Dimensional drawings TQFP48-EP**

|**Parameter**|**Ref**|**Min**|**Nom**|**Max**|
|---|---|---|---|---|
|total thickness|A|-|-|1.2|
|stand off|A1|0.05|-|0.15|
|mold thickness|A2|0.95|1|1.05|
|lead width(plating)|b|0.17|0.22|0.27|
|lead width|b1|0.17|0.2|0.23|
|lead frame thickness<br>(plating)|c|0.09|-|0.2|
|lead frame thickness|c1|0.09|-|0.16|
|bodysize X(overpins)|D||9.0||
|bodysize Y(overpins)|E||9.0||
|bodysize X|D1||7.0||
|bodysize Y|E1||7.0||
|leadpitch|e||0.5||
|lead|L|0.45|0.6|0.75|
|footprint|L1||1 REF||
|||0°|3.5°|7°|
||1|0°|-|-|
||2|11°|12°|13°|
||3|11°|12°|13°|
||R1|0.08|-|-|
||R2|0.08|-|0.2|
||S|0.2|-|-|
|exposed diepad size X|M|4.9|5|5.1|
|exposed diepad size Y|N|4.9|5|5.1|
|package edge tolerance|aaa|||0.2|
|lead edge tolerance|bbb|||0.2|
|coplanarity|ccc|||0.08|
|lead offset|ddd|||0.08|
|mold flatness|eee|||0.05|

### 26.2 Package Codes

|**Type**|**Package**|**Temperature range**|**Code & marking**|
|---|---|---|---|
|TMC2160A-TA|TQFP-EP48 (RoHS)|-40°C ... +125°C|TMC2160A-TA|
|TMC2160A-TA|TQFP-EP48 (RoHS)|-40°C ... +125°C|TMC2160A-_L_A<br>(by mistake printed for<br>devices produced with<br>Date Codes: 2002, 2007,<br>2016, 2019)|

## 27 Disclaimer

TRINAMIC Motion Control GmbH & Co. KG does not authorize or warrant any of its products for use in life support systems, without the specific written consent of TRINAMIC Motion Control GmbH & Co. KG. Life support systems are equipment intended to support or sustain life, and whose failure to perform, when properly used in accordance with instructions provided, can be reasonably expected to result in personal injury or death.

Information given in this data sheet is believed to be accurate and reliable. However, no responsibility is assumed for the consequences of its use nor for any infringement of patents or other rights of third parties which may result from its use.

Specifications are subject to change without notice.

All trademarks used are property of their respective owners.

## 28 ESD Sensitive Device

The TMC2160 is an ESD sensitive CMOS device sensitive to electrostatic discharge. Take special care to use adequate grounding of personnel and machines in manual handling. After soldering the devices to the board, ESD requirements are more relaxed. Failure to do so can result in defect or decreased reliability.

## 29 Designed for Sustainability

Sustainable growth is one of the most important and urgent challenges today. We at Trinamic try to contribute by designing highly efficient IC products, to minimize energy consumption, ensure best customer experience and long-term satisfaction by smooth and silent run, while minimizing the demand for external resources, e.g., for power supply, cooling infrastructure, reduced motor size and magnet material by intelligent control interfaces and advanced algorithms.

Please help and design efficient and durable products made for a sustainable world.

## 30 Table of Figures

- Figure 1.1 TMC2160 STEP/DIR application diagram
- Figure 1.2 TMC2160 standalone driver application diagram
- Figure 1.3 Automatic Motor Current Power Down
- Figure 1.4 Energy efficiency with CoolStep (example)
- Figure 2.1 TMC2160-TA package and pinning TQFP-EP 48 (7x7mm² body, 9x9mm² with leads)
- Figure 3.1 Standard application circuit
- Figure 3.2 External gate voltage supply
- Figure 3.3 Miller charge determines switching slope
- Figure 3.4 Slopes, Miller plateau and blank time
- Figure 3.5 Bridge protection options for power routing inductivity
- Figure 3.6 Ringing of output (blue) and Gate voltages (Yellow, Purple) with untuned brige
- Figure 3.7 Switching event with optimized components (without / after bulk diode conduction)
- Figure 3.8 Example for bridge with tuned components (see scope shots)
- Figure 4.1 SPI timing
- Figure 6.1 Motor coil sine wave current with StealthChop (measured with current probe)
- Figure 6.2 StealthChop2 automatic tuning procedure
- Table 6.1 Choice of PWM frequency – green / light green: recommended
- Figure 6.3 Scope shot: good setting for PWM_REG
- Figure 6.4 Scope shot: too small setting for PWM_REG during AT#2
- Figure 6.5 Successfully determined PWM_GRAD(_AUTO) and PWM_OFS(_AUTO)
- Figure 6.6 Velocity based PWM scaling (pwm_autoscale=0)
- Figure 6.7 TPWMTHRS for optional switching to SpreadCycle
- Figure 7.2 No ledges in current wave with sufficient hysteresis (magenta: current A, yellow & blue: sense resistor voltages A and B)
- Figure 7.3 SpreadCycle chopper scheme showing coil current during a chopper cycle
- Figure 7.4 Classic const. off time chopper with offset showing coil current
- Figure 7.5 Zero crossing with classic chopper and correction using sine wave offset
- Figure 10.1 Short detection
- Figure 11.1 Function principle of StallGuard2
- Figure 12.1 CoolStep adapts motor current to the load
- Figure 13.1 STEP and DIR timing, Input pin filter
- Figure 13.2 MicroPlyer microstep interpolation with rising STEP frequency (Example: 16 to 256)
- Figure 14.1 DIAG outputs
- Figure 15.1 DcStep extended application operation area
- Figure 15.2 Motor moving slower than STEP input due to light overload. LOSTSTEPS incremented
- Figure 15.3 Full signal interconnection for DcStep
- Figure 15.4 DCO Interface to motion controller – step generator stops when DCO is asserted
- Figure 16.1 LUT programming example
- Figure 18.1 Current setting and first steps with StealthChop
- Figure 18.2 Tuning StealthChop and SpreadCycle
- Figure 18.3 Enabling CoolStep (only in combination with SpreadCycle)
- Figure 18.4 Setting up DcStep (using TMC4361 as motion controller)
- Figure 20.1 Standalone operation with TMC2160 (pins shown with their standalone mode names)
- Figure 25.1 Layout example
- Figure 26.1 Dimensional drawings TQFP48-EP
- Table 31.1 Document Revisions

## 31 Revision History

|**Version**|**Date**|**Author**<br>**BD= Bernhard Dwersteg**|**Description**|
|---|---|---|---|
|V0.91|2018-MAY-25|BD|First version of datasheet based on datasheet TMC5160 V1.04|
|V1.00|2018-JUN-06|BD|Added errata / limitations for initial tuning of AT#1 / AT#2 phase<br>Minor wording,added evaluation board drawing|
|V1.01|2018-OKT-29|BD|Minor changes, added -T suffix option, S2G >52V hints/limits updated|
|V1.02|2018-NOV-19|BD|Added hints for tuningMOSFET bridge, added wiringbridge supply|
|V1.03|2018-FEB-05|BD|Corrected timing requirements for CLK input (30ns for first pulse) /<br>some minor fixes|
|V1.04|2019-AUG-05|BD|Added changes for TMC2160A, Errata for DIAG output in standalone<br>mode|
|V1.05|2019-NOV-18|BD|Minor changes|
|V1.06|2020-MAY-19|BD|Updated logo, added markingerror|
|V1.07|2021-JUN-01|BD|Minor changes, Corrected CUR_A / CUR_B position, Corrected<br>DRVSTRENGTH reset default is 0 (instead of 2)|
|V1.08|2022-FEB-01|BD|Updated logo & order codes; minor re-wording; Corrected condition<br>for autotuning to include current scale CS; Corrected pre-conditions<br>for open-load detection;added Attention texts|
|V1.09|2022-MAY-25|BD|P52: Added attention box for open load condition; UV_CP not visible<br>on DIAG0_ERR;Minor fixes|
|V1.10|2023-MAR-01|BD|P14: Improve attention/hint boxes for supply ripple<br>P49: Corrected PWM_SCALE_SUM formula to integrate CS_ACTUAL<br>P52: Improved description for open load<br>Replace term “slave” by“node”;corrected “NCS” to “CSN”|

**Table 31.1 Document Revisions**

## 32 References

[TMC2160-EVAL] TMC2160-EVAL Evaluation board

[AN001] Trinamic Application Note 001 - Parameterization of SpreadCycle™, <u>www.trinamic.com</u> [AN002] Trinamic Application Note 002 - Parameterization of StallGuard2™ & CoolStep™,

<u>www.trinamic.com</u>

[AN003] Trinamic Application Note 003 - DcStep™, <u>www.trinamic.com</u> Calculation sheet TMC2160_Calculations.xlsx
