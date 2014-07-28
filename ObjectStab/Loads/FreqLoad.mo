within ObjectStab.Loads;
model FreqLoad "Frequency Sensitive Load"
  extends ObjectStab.Loads.Partials.Load;

  parameter Real a=1;
  parameter Real b=1;
  parameter Real c=1;
  parameter Real d=1;
  outer ObjectStab.Base.AngularVelocity wref;
equation
  Pl = P0*(1 + (V - V0)*a + c*(wref - 1));
  Ql = Q0*(1 + (V - V0)*b + d*(wref - 1));
  annotation (Documentation(info="<html>
</html>"));
end FreqLoad;
