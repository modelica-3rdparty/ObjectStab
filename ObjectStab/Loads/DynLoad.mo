within ObjectStab.Loads;
model DynLoad "Dynamic exponential recovery load according to Karlsson & Hill"
  extends Partials.Load;
  parameter Real as=0.5 "Steady-state active power voltage dependency";
  parameter Real at=2 "Transient active power voltage dependency";
  parameter Real bs=1 "Steady-state reactive power voltage dependency";
  parameter Real bt=2 "Transient reactive power voltage dependency";
  parameter ObjectStab.Base.Time Tp=60 "Active power recovery time constant";
  parameter ObjectStab.Base.Time Tq=60 "Reactive power recovery time constant";

  Real xp "Internal Load State";
  Real xq "Internal Load State";

equation
  Pl = (xp/Tp + P0*(V/V0)^at);
  Ql = (xq/Tq + Q0*(V/V0)^bt);
  der(xp) = P0*((V/V0)^(as) - (V/V0)^at) - xp/Tp;
  der(xq) = Q0*((V/V0)^(bs) - (V/V0)^bt) - xq/Tq;

initial equation
  der(xp) = 0;
  der(xq) = 0;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{-40,-40},{-20,-40},{-20,-60},{-6,
              -50},{6,-46},{24,-44},{40,-44}})}),
    Documentation(info="Dynamic exponential recovery load according to Karlsson & Hill [1].

The load powers are given by:

  der(xp) = P0*(V^(as) - V^at) - xp/Tp;
  Pl = (xp/Tp + P0*V^at);
  der(xq) = Q0*(V^(bs) - V^bt) - xq/Tq;
  Ql = (xq/Tq + Q0*V^bt);

where xp is a continuous dynamic state that can be interpreted as a
measure of the energy deficit in the load and Ps(V) = P0*V^as
is the steady-state and Pt(V)=P0*V^at the transient voltage dependency.
Pl is the actual active load power and Tp is the active power recovery
time constant.

For the reactive load power, a similar model is used with corresponding
characteristics x_q, Qs(V)=Q0 V^bs, Qt(V) = Q0 V^bt and time constant Tq.

---
[1] D. Karlsson and D.J. Hill, \"Modelling and identification of nonlinear
dynamic loads in power systems\", IEEE Transactions on Power Systems,
vol. 9, no. 1, pp. 157-163, February 1994.

"));
end DynLoad;
