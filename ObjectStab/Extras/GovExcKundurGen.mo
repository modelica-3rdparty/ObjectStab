within ObjectStab.Extras;
model GovExcKundurGen
  "6th Order Detailed Generator according to Kundur sec 13.3"
  extends ObjectStab.Generators.Partials.DetGen;

public
  constant Real Ksd=1;
  // generator saturation (not implemented keep at 1);
  constant Real Ksq=1;

  parameter ObjectStab.Base.Resistance ra=0 "Armature Resistance";
  parameter ObjectStab.Base.Reactance xl=0.15 "Leakage Reactance";
  parameter ObjectStab.Base.Reactance xd=0.8948
    "Direct Axis Synchronous Reactance";
  parameter ObjectStab.Base.Reactance xq=0.84
    "Quadrature Axis Synchronous Reactance";
  parameter ObjectStab.Base.Reactance xdp=0.30
    "Direct Axis Transient Reactance";
  parameter ObjectStab.Base.Reactance xqp=0.10
    "Quadrature Axis Transient Reactance";
  parameter ObjectStab.Base.Reactance xdpp=0.20
    "Direct Axis Subtransient Reactance";
  parameter ObjectStab.Base.Reactance xqpp=0.10
    "Quadrature Axis Subtransient Reactance";

  parameter ObjectStab.Base.Time Td0p=7
    "Open-circuit Direct Axis Transient Time Constant";
  parameter ObjectStab.Base.Time Tq0p=0.44
    "Open-circuit Quadrature Axis Transient Time Constant";
  parameter ObjectStab.Base.Time Td0pp=0.02
    "Open-circuit Direct Axis Subtransient Time Constant";
  parameter ObjectStab.Base.Time Tq0pp=0.03
    "Open-circuit Quadrature Axis Subtransient Time Constant";

protected
  parameter Real Ladu=xd - xl;
  parameter Real Laqu=xq - xl;
  parameter Real Lfd=-Ladu*(xdp - xl)/(xdp - xl - Ladu);
  parameter Real L1q=-Laqu*(-xqp + xl)/(-xqp + xl + Laqu);
  parameter Real L1d=-Ladu*Lfd*(-xdpp + xl)/(-xdpp*Ladu - xdpp*Lfd + xl*Ladu
       + xl*Lfd + Ladu*Lfd);
  parameter Real L2q=-Laqu*L1q*(-xqpp + xl)/(-xqpp*Laqu - xqpp*L1q + xl*Laqu
       + xl*L1q + Laqu*L1q);
  parameter Real Rfd=(Ladu + Lfd)/(Td0p*ObjectStab.Base.ws);
  parameter Real R1d=(L1d + (Ladu*Lfd)/(Ladu + Lfd))/(Td0pp*ObjectStab.Base.
      ws);
  parameter Real R1q=(Laqu + L1q)/(Tq0p*ObjectStab.Base.ws);
  parameter Real R2q=(L2q + (Laqu*L1q)/(Laqu + L1q))/(Tq0pp*ObjectStab.Base.
      ws);

  parameter Real Ladspp=1/(1/(Ksd*Ladu) + 1/Lfd + 1/L1d);
  parameter Real Laqspp=1/(1/(Ksq*Laqu) + 1/L1q + 1/L2q);
  parameter Real Ldpp=xl + Ladspp;
  parameter Real Lqpp=xl + Laqspp;
public
  Real lamfd(start=1);
  Real lam1d;
  Real lam1q;
  Real lam2q;
  Real lamad;
  Real lamaq;
  Real Ifd(start=1);
  Real efd=Efd*Rfd/Ladu;

  replaceable ObjectStab.Generators.Controllers.ConstPm Gov annotation (Placement(
        transformation(extent={{12,-96},{32,-76}})));

  replaceable ObjectStab.Generators.Controllers.ConstEfd Exc annotation (Placement(
        transformation(extent={{14,70},{34,90}})));

initial equation
  der(lamfd) = 0;
  der(lam1d) = 0;
  der(lam1q) = 0;
  der(lam2q) = 0;

equation
  der(lamfd) = ObjectStab.Base.ws*((Efd*Rfd/Ladu) + (lamad - lamfd)*Rfd/Lfd);
  der(lam1d) = ObjectStab.Base.ws*(lamad - lam1d)/L1d*R1d;
  der(lam1q) = ObjectStab.Base.ws*(lamaq - lam1q)/L1q*R1q;
  der(lam2q) = ObjectStab.Base.ws*(lamaq - lam2q)/L2q*R2q;
  lamad = Ladspp*(-iq + lamfd/Lfd + lam1d/L1d);
  lamaq = Laqspp*(-id + lam1q/L1q + lam2q/L2q);

  // stator eqs
  //vq = -ra*iq + w*Lqpp*id + (-w*Laqspp*(lam1q/L1q + lam2q/L2q));
  //vd = -ra*id - w*Ldpp*iq + (w*Ladspp*(lamfd/Lfd + lam1d/L1d));
  if online then
    iq = -(w*Lqpp*L1q*L2q*vd*Lfd*L1d - w^2*Lqpp*L1q*L2q*Ladspp*lamfd*L1d - w^
      2*Lqpp*L1q*L2q*Ladspp*lam1d*Lfd + vq*L1q*L2q*ra*Lfd*L1d + w*Laqspp*
      lam1q*L2q*ra*Lfd*L1d + w*Laqspp*lam2q*L1q*ra*Lfd*L1d)/L1q/L2q/Lfd/L1d/(
      w^2*Lqpp*Ldpp + ra^2);
    id = (-vd*Lfd*L1d*L1q*L2q*ra + w*Ldpp*vq*L1q*L2q*Lfd*L1d + w^2*Ldpp*
      Laqspp*lam1q*L2q*Lfd*L1d + w^2*Ldpp*Laqspp*lam2q*L1q*Lfd*L1d + w*Ladspp
      *lamfd*L1d*L1q*L2q*ra + w*Ladspp*lam1d*Lfd*L1q*L2q*ra)/L1q/L2q/(w^2*
      Lqpp*Ldpp + ra^2)/Lfd/L1d;
  else
    iq = 0;
    id = 0;
  end if;

  Pe = w*(lamad*id - lamaq*iq);
  Ifd = Ladu*(lamfd - lamad)/Lfd;

  // connection of governor and exciter
  Gov.u = w;
  Pm = Gov.y;
  Exc.u = sqrt(vd^2 + vq^2);
  Efd = Exc.y;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-100,0},{-20,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Ellipse(
          extent={{-20,40},{60,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Text(
          extent={{44,68},{64,48}},
          lineColor={0,0,0},
          textString=
               "Efd"),
        Text(
          extent={{58,-56},{78,-76}},
          lineColor={0,0,0},
          textString=
               "Pm"),
        Line(points={{80,40},{80,80},{34,80}}, color={0,0,0}),
        Line(
          points={{80,40},{54,20}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-6,30},{-46,30},{-46,86},{12,86},{4,86}}, color={0,0,0}),
        Line(points={{2,36},{-20,36},{-20,74},{12,74}}, color={0,0,0}),
        Text(
          extent={{-68,66},{-48,46}},
          lineColor={0,0,0},
          textString=
               "Vt"),
        Text(
          extent={{-12,68},{8,48}},
          lineColor={0,0,0},
          textString=
               "dw"),
        Line(
          points={{32,-86},{80,-86},{80,-40},{54,-22}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Line(points={{-18,-14},{-44,-14},{-44,-86},{12,-86}}, color={0,0,0}),
        Text(
          extent={{-66,-54},{-46,-74}},
          lineColor={0,0,0},
          textString=
               "w")}));
end GovExcKundurGen;
