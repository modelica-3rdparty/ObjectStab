within ObjectStab.Network.Controllers;
partial model TCULController "Common definitions for TCUL control systems"

  extends Modelica.Blocks.Interfaces.SI2SO(y(start=1));
  parameter Integer method=3 "Method number";
  parameter ObjectStab.Base.TapRatio n=1 "Transformer Ratio";

  parameter ObjectStab.Base.TapRatio stepsize=0.01 "Step Size";
  parameter ObjectStab.Base.TapStep mintap=-12 "Minimum tap step";
  parameter ObjectStab.Base.TapStep maxtap=12 "Maximum tap step";

  parameter ObjectStab.Base.Duration Tm0=10 "Mechanical Time Delay";
  parameter ObjectStab.Base.Duration Td0=20 "Controller Time Delay 1";
  parameter ObjectStab.Base.Duration Td1=20 "Controller Time Delay 2";
  parameter ObjectStab.Base.Voltage DB=0.03
    "TCUL Voltage Deadband (double-sided)";
  parameter ObjectStab.Base.Voltage Vref=1 "TCUL Voltage Reference";
  parameter ObjectStab.Base.Voltage Vblock=0.82 "Tap locking voltage";
  parameter Boolean InitByVoltage=false "Initialize to V=Vref?";
  Real tappos(start=(n - 1)/stepsize) "Current tap step [number]";
  ObjectStab.Base.Voltage udev;
  Boolean blocked=u2 < Vblock "Tap locked ?";
equation
  tappos = (y - 1)/stepsize;
  udev = u1 - Vref;
  annotation (
    Documentation(info="Common definitions for TCUL control systems according to [1].
Using the parameter the characteristics of the mechanical delay time (Tm)
and the controlled delay time (Td) the TCUL can be influenced according
to the table below:

----------------------------------
|method|    Td     |    Tm       |
----------------------------------
|  1   |  constant |  constant   |
|  2   |  inverse  |  constant   |
|  3   |  inverse  |  inverse    |
|  4   |  both     |  constant   |
----------------------------------

Use the subclasses TCULContinuous for continuous approximation (more computationally)
efficient or the the subclass TCULDiscrete for the true discrete realization.

The tap changer is locked if the primary side voltage decreases below the
tap locking voltage specified in Vblock.

---
[1] P.W. Sauer and M.A. Pai, \"A comparison of discrete vs. continuous
dynamic models of tap-changing-under-load transformers\", in Proceedings
of NSF/ECC Workshop on Bulk power System Voltage Phenomena - III :
Voltage Stability, Security and Control,  Davos, Switzerland, 1994.
"));
end TCULController;
