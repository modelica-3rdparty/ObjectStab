within ObjectStab.Network.Partials;
partial model ImpTransformer
  extends ObjectStab.Base.TwoPin;
  parameter ObjectStab.Base.Resistance R=0.0 "Leakage Resistance";
  parameter ObjectStab.Base.Reactance X=0.1 "Leakage Reactance";

  ObjectStab.Network.IdealTransformer Tr annotation (Placement(
        transformation(extent={{20,-20},{60,20}})));
  ObjectStab.Network.Impedance Imp(R=R, X=X) annotation (Placement(
        transformation(extent={{-60,-20},{-20,20}})));
equation
  connect(Imp.T1, T1) annotation (Line(points={{-60,0},{-100,0}}));
  connect(Imp.T2, Tr.T1) annotation (Line(points={{-20,0},{20,0}}));
  connect(Tr.T2, T2) annotation (Line(points={{60,0},{100,0}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-70,40},{12,-40}}, lineColor={0,0,0}),
        Ellipse(extent={{-12,40},{70,-40}}, lineColor={0,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,0}),
        Line(points={{-100,0},{-70,0}}, color={0,0,0}),
        Text(extent={{-98,-40},{100,-80}}, textString=
                                               "%name")}));
end ImpTransformer;
