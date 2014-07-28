within ObjectStab.Extras;
model UVLSLoad
  extends ObjectStab.Loads.Partials.Load;
  parameter Real as=1 "Steady-state active power voltage dependency";

  parameter Real at=2 "Transient active power voltage dependency";
  parameter Real bs=1 "Steady-state reactive power voltage dependency";
  parameter Real bt=2 "Transient reactive power voltage dependency";
  parameter Base.Time Tp=60 "Active power recovery time constant";
  parameter Base.Time Tq=60 "Reactive power recovery time constant";

  Real xp "Internal Load State";
  Real xq "Internal Load State";

  Real k;

  ShedRelay Relay1(
    Threshold=0.8,
    DelayTime=1.5,
    ShedAmount=0.05)
                    annotation (Placement(transformation(extent={{-85,15},{
            -15,85}})));
  ShedRelay Relay2(
    Threshold=0.82,
    DelayTime=3,
    ShedAmount=0.05)
                    annotation (Placement(transformation(extent={{15,15},{85,
            85}})));
  ShedRelay Relay3(
    DelayTime=6,
    ShedAmount=0.05,
    Threshold=0.92)
                   annotation (Placement(transformation(extent={{-85,-85},{
            -15,-15}})));
equation
  Pl = (1 - k)*(xp/Tp + P0*(V/V0)^at);
  Ql = (1 - k)*(xq/Tq + Q0*(V/V0)^bt);
  der(xp) = P0*((V/V0)^(as) - (V/V0)^at) - xp/Tp;
  der(xq) = Q0*((V/V0)^(bs) - (V/V0)^bt) - xq/Tq;

  Relay1.u = V;
  Relay2.u = V;
  Relay3.u = V;
  k = Relay1.y + Relay2.y + Relay3.y;

initial equation
  der(xp) = 0;
  der(xq) = 0;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-20,0}}, color={0,0,0}),
        Polygon(
          points={{40,-2},{-20,18},{-20,-22},{40,-2}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,0}),
        Line(points={{-40,-40},{-20,-40},{-20,-60},{-6,-50},{6,-46},{24,-44},
              {40,-44}}),
        Text(extent={{-100,60},{100,20}}, textString=
                                              "%P0 + j %Q0"),
        Text(extent={{-100,100},{100,60}}, textString=
                                               "UVLS")}));
end UVLSLoad;
