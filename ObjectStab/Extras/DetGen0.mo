within ObjectStab.Extras;
model DetGen0 "Detailed Static Generator Model"
  extends ObjectStab.Generators.Partials.Generator;

  parameter ObjectStab.Base.ApparentPower Sbase=100 "Generator rated power";
  parameter ObjectStab.Base.Resistance ra=0 "Armature Resistance";
  parameter ObjectStab.Base.Reactance xd=0.8948
    "Direct Axis Synchronous Reactance";
  parameter ObjectStab.Base.Reactance xq=0.84
    "Quadrature Axis Synchronous Reactance";
  parameter Real K=50 "Voltage Regulator Steady-State Gain";
  parameter ObjectStab.Base.Voltage Efmax=3.5 "Maximum Field Voltage";
  parameter ObjectStab.Base.Voltage Efmin=-3.5 "Minimum Field Voltage";
  parameter ObjectStab.Base.Current Iarmmax=1.05 "Armature Current Limit";
  parameter ObjectStab.Base.Resistance rt=0 "Step-up Transformer Resistance";
  parameter ObjectStab.Base.Reactance xt=0.0 "Step-up Transformer Reactance";
  parameter ObjectStab.Base.Time Tdelay=20;
  parameter Real Vref(fixed=false, start=1);
  parameter Real Pm0(fixed=false, start=1);

  Boolean up_limit(start=false);
  Boolean arm_limit(start=false);
  Real vta(start=1);
  Real vtb(start=1);
  Real Pgt(start=1);
  Real Qgt(start=1);
  Real Efd(start=1);
  Real Vt(start=1);
  Real Iarm(start=1);

initial equation
  V = V0;
  if isSlack then
    theta = theta0;
  else
    Pg = Pg0;
  end if;

equation
  //
  0 = if time > TripTime then Qgt else if arm_limit then Qgt - sqrt((Vt*
    Iarmmax)^2 - Pgt^2) else if up_limit then (Efd - Efmax) else (Vt - (Vref
     - Efd/K));
  Pgt = if time > TripTime then 0 else (Pm0 - ra*Iarm^2);

  Vt = sqrt(vta^2 + vtb^2);
  Pgt = -(vta*T.ia + vtb*T.ib)/Sbase*ObjectStab.Base.Sbase;
  Qgt = -(vtb*T.ia - vta*T.ib)/Sbase*ObjectStab.Base.Sbase;
  Efd = (Vt^4 + Vt^2*Qgt*xq + Qgt*xd*Vt^2 + Qgt^2*xd*xq + Pgt^2*xq*xd)/(sqrt(
    Pgt^2*xq^2 + Vt^4 + 2*Vt^2*Qgt*xq + Qgt^2*xq^2)*Vt);
  [T.va; T.vb] = [rt,-xt; xt,rt]*[T.ia; T.ib]/Sbase*ObjectStab.Base.Sbase
     + [vta; vtb];

  // limiter logic
  up_limit = (pre(up_limit) and Vt < (Vref)) or not pre(up_limit) and (delay(
    Efd, Tdelay) > Efmax);
  arm_limit = (pre(arm_limit) and V < (Vref)) or not pre(arm_limit) and (
    delay(Iarm, Tdelay) > Iarmmax);
  Iarm = sqrt(T.ia^2 + T.ib^2)/Sbase*ObjectStab.Base.Sbase;

  // contribute to angle reference calculation
  wrl.wr.Hwsum = if time < TripTime then Modelica.Constants.inf else 0;
  wrl.wr.Hsum = if time < TripTime then Modelica.Constants.inf else 0;

end DetGen0;
