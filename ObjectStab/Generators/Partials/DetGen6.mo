within ObjectStab.Generators.Partials;
partial model DetGen6 "6th Order Detailed Generator"
  extends DetGen;

  parameter Base.Resistance ra=0 "Armature Resistance";
  parameter Base.Reactance xd=0.8948 "Direct Axis Synchronous Reactance";
  parameter Base.Reactance xq=0.84 "Quadrature Axis Synchronous Reactance";
  parameter Base.Reactance xdp=0.30 "Direct Axis Transient Reactance";
  parameter Base.Reactance xqp=0.10 "Quadrature Axis Transient Reactance";
  parameter Base.Reactance xdpp=0.20 "Direct Axis Subtransient Reactance";
  parameter Base.Reactance xqpp=0.10 "Quadrature Axis Subtransient Reactance";

  parameter Base.Time Td0p=7 "Open-circuit Direct Axis Transient Time Constant";
  parameter Base.Time Tq0p=0.44
    "Open-circuit Quadrature Axis Transient Time Constant";
  parameter Base.Time Td0pp=0.02
    "Open-circuit Direct Axis Subtransient Time Constant";
  parameter Base.Time Tq0pp=0.03
    "Open-circuit Quadrature Axis Subtransient Time Constant";

  Base.Voltage Eqp(start=0, stateSelect=StateSelect.prefer);
  Base.Voltage Edp(start=0, stateSelect=StateSelect.prefer);
  Base.Voltage Eqpp(start=0, stateSelect=StateSelect.prefer);
  Base.Voltage Edpp(start=0, stateSelect=StateSelect.prefer);

initial equation
  delta = Modelica.Math.atan2(T.vb - 1/Sbase*Base.Sbase*rt*T.ib - 1/Sbase*
    Base.Sbase*xt*T.ia - 1/Sbase*Base.Sbase*ra*T.ib - 1/Sbase*Base.Sbase*xq
    *T.ia, 1.0 + T.va - 1/Sbase*Base.Sbase*rt*T.ia + 1/Sbase*Base.Sbase*xt*
    T.ib - 1/Sbase*Base.Sbase*ra*T.ia + 1/Sbase*Base.Sbase*xq*T.ib);
  der(Eqp) = 0;
  der(Edp) = 0;
  der(Eqpp) = 0;
  //  der(Edpp) = 0;

equation
  // transient and subtransient equations
  Td0pp*der(Eqpp) = Eqp - Eqpp + id*(xdp - xdpp);
  Tq0pp*der(Edpp) = Edp - Edpp - iq*(xqp - xqpp);
  Td0p*der(Eqp) = Efd - Eqp + id*(xd - xdp);
  Tq0p*der(Edp) = -Edp - iq*(xq - xqp);

  // stator equations
  //  vd = Edpp - ra*id - xqpp*iq;
  //  vq = Eqpp + xdpp*id - ra*iq;
  iq = if online then -(vq*ra - Eqpp*ra + xdpp*vd - xdpp*Edpp)/(xdpp*xqpp
     + ra^2) else 0;
  id = if online then -(vd*ra - Edpp*ra - xqpp*vq + xqpp*Eqpp)/(xdpp*xqpp
     + ra^2) else 0;

  // electrical power
  Pe = (Edpp*id + Eqpp*iq) + (xdpp - xqpp)*id*iq;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-20,0},{60,40}}, textString=
                                              "6th"), Text(extent={{-20,-40},
              {60,0}}, textString=
                             "Order")}),
    Documentation(info="The 6th order detailed generator model extends the DetGen class and
corresponds to Model 6 in [1, pp 347], and adds subtransient EMF voltage sources
in both the direct quatradure axes and the field voltage input.

This model includes the damping introduced by damper winding and eddy-currents in
the rotor, and the damping coefficient D should only model the damping
due to friction.

---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
end DetGen6;
