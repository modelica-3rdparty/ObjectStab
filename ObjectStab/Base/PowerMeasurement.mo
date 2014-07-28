within ObjectStab.Base;
model PowerMeasurement "Power Measurement"
  extends ObjectStab.Base.TwoPin;
  Modelica.Blocks.Interfaces.RealOutput[2] PQ annotation (Placement(
        transformation(extent={{20,50},{40,70}})));
equation
  T1.va = T2.va;
  T1.vb = T2.vb;
  T1.ia = -T2.ia;
  T1.ib = -T2.ib;
  PQ = {(1 + T1.va)*T1.ia + T1.vb*T1.ib, (T1.vb*T1.ia - (1 + T1.va)*T1.ib)};
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{100,0}}, color={0,0,0}),
        Ellipse(extent={{-6,20},{6,-20}}, lineColor={0,0,0}),
        Line(points={{0,20},{0,60},{20,60}}, color={0,0,0}),
        Text(
          extent={{-100,-60},{100,-100}},
          lineColor={0,0,0},
          textString=
               "Power"),
        Line(points={{-40,-40},{40,-40}}, color={0,0,0}),
        Polygon(
          points={{40,-40},{20,-32},{20,-48},{40,-40}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="Current Measurement for Electrical Cuts.
Should be connected in series."));
end PowerMeasurement;
