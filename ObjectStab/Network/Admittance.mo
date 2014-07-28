within ObjectStab.Network;
model Admittance "Admittance Model"
  extends ObjectStab.Base.TwoPin;

  parameter ObjectStab.Base.Conductance G=0.0 "Conductance";
  parameter ObjectStab.Base.Susceptance B=0.1 "Susceptance";

equation
  [T1.ia; T1.ib] = [G, -B; B, G]*[T1.va - T2.va; T1.vb - T2.vb];
  [T1.ia; T1.ib] + [T2.ia; T2.ib] = [0; 0];
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-60,20},{60,-20}}, lineColor={0,0,0}),
        Line(points={{-60,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{60,0}}, color={0,0,0}),
        Text(extent={{40,20},{-40,60}}, textString=
                                            "G+jB"),
        Text(extent={{-60,-40},{-100,-20}}, textString=
                                                "V1, I1"),
        Text(extent={{100,-40},{60,-20}}, textString=
                                              "I2,V2"),
        Line(
          points={{-92,-10},{-66,-10}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled}),
        Line(
          points={{94,-12},{66,-12}},
          color={0,0,255},
          arrow={Arrow.None,Arrow.Filled})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(extent={{-60,20},{60,-20}}, lineColor={0,0,0}),
        Line(points={{-60,0},{-100,0}}, color={0,0,0}),
        Line(points={{100,0},{60,0}}, color={0,0,0}),
        Text(extent={{40,20},{-40,60}}, textString=
                                            "%name")}),
    Documentation(info="The admittance model is governed by the equations:

           G+jB
           ----
V1, I1  ---    --- V2, I2
    ->     ----        <-


I1 = (G+jB) * (V1-V2)
I1 + I2 = 0:

"));
end Admittance;
