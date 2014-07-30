within ObjectStab.Network;
model TCULDis
  "Tap-Changing Under Load (TCUL) transformer with discrete implementation"

  extends ObjectStab.Network.Partials.ImpTransformer;

  parameter ObjectStab.Base.TapRatio n=1 "Transformer Ratio";

  ObjectStab.Network.Controllers.TCULDiscrete Controller(n=n) annotation (Placement(
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
    Documentation(info="Discrete implementation of Tap-Changing Under Load (TCUL) transformer according to
method D1-D4 using a state-machine implementation of the control system and
tap changer mechanism. See documentation for 'Controllers.TCULDiscrete' for
documentation on the control system.
Note that the tap position of a discrete tap changer is not properly
initialized by the initial value solver in Dymola version 4.0c.
This can by manually by adding e.g., the string: Controller(tappos(start=8))
in the 'Modifiers' field (initializes the tap to position 8).
"));
end TCULDis;
