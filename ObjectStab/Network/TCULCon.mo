within ObjectStab.Network;
model TCULCon
  "Tap-Changing Under Load (TCUL) transformer with continuous implementation"

  extends ObjectStab.Network.Partials.ImpTransformer;

  parameter ObjectStab.Base.TapRatio n=1 "Transformer Ratio";
  ObjectStab.Network.Controllers.TCULContinuous Controller(n=n) annotation (Placement(
        transformation(extent={{0,-60},{20,-40}})));
  ObjectStab.Base.VoltageMeasurement PrimaryVoltage annotation (Placement(
        transformation(
        origin={-80,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Base.VoltageMeasurement SecondaryVoltage annotation (Placement(
        transformation(
        origin={80,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(T1, T1) annotation (Line(
      points={{-100,0},{-100,0}},
      color={0,0,255}));
  connect(T1, PrimaryVoltage.T) annotation (Line(
      points={{-100,0},{-80,0},{-80,-20}},
      color={0,0,255}));
  connect(T2, SecondaryVoltage.T) annotation (Line(
      points={{100,0},{80,0},{80,-10}},
      color={0,0,255}));
  connect(PrimaryVoltage.V, Controller.u2) annotation (Line(
      points={{-80,-30},{-80,-56},{-2,-56}},
      color={0,0,127}));
  connect(SecondaryVoltage.V, Controller.u1) annotation (Line(
      points={{80,-20},{80,-30},{-20,-30},{-20,-44},{-2,-44}},
      color={0,0,127}));
  connect(Controller.y, Tr.inPort) annotation (Line(
      points={{21,-50},{40,-50},{40,-16}},
      color={0,0,127}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-70,40},{12,-40}}, lineColor={0,0,0}),
        Ellipse(extent={{-12,40},{70,-40}}, lineColor={0,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,0}),
        Line(points={{-100,0},{-70,0}}, color={0,0,0}),
        Line(points={{-60,-60},{0,60}}, color={0,0,0}),
        Polygon(
          points={{6,72},{-6,60},{4,56},{6,72}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="Continuous approximation of Tap-Changing Under Load (TCUL) according to
method C1-C4
"));
end TCULCon;
