within ObjectStab.Network.Controllers;
model TCULContinuous "Continuous approximation of TCUL control system"
  extends TCULController;
  ObjectStab.Base.Time Tc;
  Modelica.Blocks.Continuous.LimIntegrator integrator(
    k=1,
    outMax=1 + maxtap*stepsize,
    outMin=1 + mintap*stepsize,
    y(start=n))   annotation (Placement(transformation(extent={{-20,-20},{
            20,20}})));
equation
  connect(integrator.y,y)              annotation (Line(points={{22,0},{110,
          0}}));
  if (method == 2) then
    Tc = (Td0*DB/2 + Tm0*noEvent(abs(udev)))/stepsize;
  elseif (method == 3) then
    Tc = (Tm0 + Td0)*DB/2/stepsize;
  else
    Tc = (Td0*DB/2 + (Tm0 + Td1)*noEvent(abs(udev)))/stepsize;
  end if;
  if not blocked then
    integrator.u = -udev/Tc;
  else
    integrator.u = 0;
  end if;
initial equation
  if InitByVoltage then
    der(integrator.y) = 0;
  else
    integrator.y = n;
  end if;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-88,36},{82,-36}}, textString=
                                                "Continuous")}),
    Documentation(info="Continuous implementation of Tap-Changing Under Load (TCUL) control
system  according to method C1-C4 in [1] using a state-machine implementation
of the control system and tap changer mechanism.


---
[1] P.W. Sauer and M.A. Pai, \"A comparison of discrete vs. continuous
dynamic models of tap-changing-under-load transformers\", in Proceedings
of NSF/ECC Workshop on Bulk power System Voltage Phenomena - III :
Voltage Stability, Security and Control,  Davos, Switzerland, 1994.
"), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-74,10},{-42,-14}}, textString=
                                              "input"),
        Text(extent={{-80,-10},{-28,-28}}, textString=
                                               "determined"),
        Text(extent={{-74,-22},{-30,-36}}, textString=
                                               "by equation"),
        Text(extent={{-72,-36},{-46,-56}}, textString=
                                               "layer")}));
end TCULContinuous;
