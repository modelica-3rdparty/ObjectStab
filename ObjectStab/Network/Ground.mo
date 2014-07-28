within ObjectStab.Network;
model Ground "Ground Point"
  extends ObjectStab.Base.OnePin;

equation
  1 + T.va = 0;
  T.vb = 0;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-40,24},{-40,-30}}),
        Line(points={{-20,10},{-20,-10}}),
        Line(points={{0,4},{0,-2}}),
        Line(points={{-60,40},{-60,-40}}),
        Line(points={{-60,0},{-100,0}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-40,24},{-40,-30}}),
        Line(points={{-20,10},{-20,-10}}),
        Line(points={{0,4},{0,-2}}),
        Line(points={{-60,40},{-60,-40}}),
        Line(points={{-60,0},{-100,0}})}),
    Documentation(info="This model can be used to define a ground point, i.e., a point where the voltage is
zero:

V = 0   <=> 1+va = 0, vb = 0

Several (or no) ground points may be used in a power system model.
"));
end Ground;
