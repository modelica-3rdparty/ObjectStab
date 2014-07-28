within ObjectStab.Examples.Nordic32.Models;
model SweLoad "Nordic32 Static Load Model\t"
  extends ObjectStab.Loads.Partials.Load;

  outer Base.AngularVelocity wref;
  parameter Real a=0.75;
equation
  Pl = P0*(V/V0)*wref^a;
  Ql = Q0*(V/V0)^2*wref^a;
  annotation (
    Documentation(info="
Static load model used in the CIGRE report.
Active power has constant current and Reactive power has
constant impedance characteristic.
"));
end SweLoad;
