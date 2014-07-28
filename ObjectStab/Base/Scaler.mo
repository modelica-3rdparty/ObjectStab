within ObjectStab.Base;
model Scaler
  extends TwoPin;
  Real k=InPort;
  Modelica.Blocks.Interfaces.RealInput InPort
                                           annotation (Placement(
        transformation(extent={{-40,50},{-20,70}})));
equation
  [T2.ia; T2.ib] = k*[T1.ia; T1.ib];
  [T2.va; T2.vb] = k*[T1.va; T1.vb];
  annotation (Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{0,10},{0,60},{-20,60}}, color={0,0,0}),
        Line(points={{-20,20},{20,0},{-20,-22},{-20,20}}, color={0,0,0}),
        Line(points={{-102,0},{100,0}}, color={0,0,0})}));
end Scaler;
