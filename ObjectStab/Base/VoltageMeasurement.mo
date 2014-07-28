within ObjectStab.Base;
model VoltageMeasurement "Voltage Measurement for Electrical Cuts"
  extends ObjectStab.Base.OnePin;
  Modelica.Blocks.Interfaces.RealOutput V "Voltage Amplitude" annotation (Placement(
        transformation(extent={{-10,-10},{10,10}})));
  Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va)) "Voltage Angle";
equation
  T.ia = 0;
  T.ib = 0;
  V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-80,0},{-10,0}}, color={0,0,0}),
        Line(points={{-80,40},{-80,-40}}, color={0,0,0}),
        Text(
          extent={{-100,100},{40,60}},
          lineColor={0,0,0},
          textString=
               "Voltage")}));
end VoltageMeasurement;
