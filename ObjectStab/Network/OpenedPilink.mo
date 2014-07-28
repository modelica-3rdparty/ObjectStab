within ObjectStab.Network;
model OpenedPilink "Pilink model with breakers"
  extends Partials.PilinkBase;

  parameter ObjectStab.Base.Time OpenTime=10 "Time of branch opening";
  parameter ObjectStab.Base.Duration CloseTime=1e10
    "Duration of the branch opening";
  ObjectStab.Network.Pilink2 L1(
    R=R,
    X=X,
    B=B,
    G=G) annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  ObjectStab.Network.Breaker B1(OpenTime=OpenTime, CloseTime=CloseTime)
    annotation (Placement(transformation(extent={{-80,-20},{-40,20}})));
  ObjectStab.Network.Breaker B2(OpenTime=OpenTime, CloseTime=CloseTime)
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
equation
  connect(B1.T1, T1) annotation (Line(points={{-80,0},{-100,0}}));
  connect(B1.T2, L1.T1) annotation (Line(points={{-40,0},{-20,0}}));
  connect(B2.T1, L1.T2) annotation (Line(points={{40,0},{20,0}}));
  connect(T2, B2.T2) annotation (Line(points={{100,0},{80,0}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-94,0},{-70,20}}, color={0,0,0}),
        Line(points={{-94,0},{-70,0}}, color={255,255,255}),
        Line(points={{68,0},{92,0}}, color={255,255,255}),
        Line(points={{68,0},{92,20}}, color={0,0,0})}),
    Documentation(info="Breakers B1 and B2 opens simultaneously at simulation time OpenTime, and stays
until time CloseTime, after which they are simultanously closed.

"));
end OpenedPilink;
