within ObjectStab.Loads;
model MotorLoad "Simplified Induction Motor Load Model"
  extends Partials.Load;
  parameter Real H=3;
  parameter Real xp=0.1/P0;
  parameter Real scr=0.2;

  Real Tm(start=1);
  Real s(start=0.2);
  Real B;
  Real w;
  outer Real wref;
equation
  Pl = V^2/xp*(1/(s/scr + scr/s));
  Ql = V^2/xp*((s/scr)/(s/scr + scr/s)) + B*V^2;
  der(B) = 0;
  der(Tm) = 0;

  w = (1 - s)*wref;

  2*H*der(s) = Tm*w - V^2/xp/((s/scr + scr/s));

initial equation
  s = 1/2/P0/xp*(V^2 - (V^4 - 4*P0^2*xp^2)^(1/2))*scr;
  Tm = V^2/xp/((s/scr + scr/s))/(1 - s);
  B = -(-Q0*xp*s^2 - Q0*xp*scr^2 + V^2*s^2)/xp/(s^2 + scr^2)/V^2;
  annotation (Documentation(info="<html>
</html>"));
end MotorLoad;
