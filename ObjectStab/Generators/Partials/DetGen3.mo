within ObjectStab.Generators.Partials;
partial model DetGen3 "3rd Order Detailed Generator"
  extends DetGen;

  parameter Base.Resistance ra=0 "Armature Resistance";
  parameter Base.Reactance xd=0.8948 "Direct Axis Synchronous Reactance";
  parameter Base.Reactance xq=0.84 "Quadrature Axis Synchronous Reactance";
  parameter Base.Reactance xdp=0.30 "Direct Axis Transient Reactance";
  parameter Base.Time Td0p=7 "Open-circuit Direct Axis Transient Time Constant";

  Base.Voltage Eqp(start=1, stateSelect=StateSelect.prefer);

initial equation
  der(Eqp) = 0;

equation
  // Transient EMF equation
  Td0p*der(Eqp) = Efd - Eqp + id*(xd - xdp);

  // stator equations
  //vd = -ra*id - xq*iq;
  //vq = Eqp + xdp*id - ra*iq;
  iq = if online then -(vq*ra - Eqp*ra + xdp*vd)/(xdp*xq + ra^2) else 0;
  id = if online then -(vd*ra - xq*vq + xq*Eqp)/(xdp*xq + ra^2) else 0;

  // electrical power
  Pe = Eqp*iq + (xdp - xq)*id*iq;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-20,-40},{60,0}}, textString=
                                               "Order"), Text(extent={{-20,
              0},{60,40}}, textString=
                               "3rd")}),
    Documentation(info="The 3rd order detailed generator model corresponds to Model 3 in [1, pp 348],
and extends the DetGen class. It adds a single transient EMF source in
the quatradure axis and the field voltage input. This model neglects the effect
of damper windings and the damping produced by rotor eddy-currents.
The effect of this damping is usually included in the damping coefficient D.


---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
end DetGen3;
