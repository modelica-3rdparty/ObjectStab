within ObjectStab.Network.Partials;
partial model PilinkBase "Pilink"
  extends ObjectStab.Base.TwoPin;
  parameter ObjectStab.Base.Resistance R=0.0 "Series Resistance";
  parameter ObjectStab.Base.Reactance X=0.1 "Series Reactance";
  parameter ObjectStab.Base.Susceptance B=0.1 "Shunt Susceptance";
  parameter ObjectStab.Base.Conductance G=0.0 "Shunt Conductance";
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{100,0},{60,0}}, color={0,0,0}),
        Text(extent={{100,20},{-100,60}}, textString=
                                              "%name"),
        Rectangle(extent={{-60,20},{60,-20}}, lineColor={0,0,0}),
        Line(points={{-60,0},{-100,0}}, color={0,0,0})}));
end PilinkBase;
