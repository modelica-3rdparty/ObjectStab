within ObjectStab.Network.Partials;
model BreakerBase
  extends ObjectStab.Base.TwoPin;

  parameter Real small=1e-6;
  Boolean closed;

  //  Real s1;
  //  Real s2;
equation

    //  [T1.va - T2.va; T1.vb - T2.vb] = (if closed then small*[1, -1; 1, 1] else [1
  //    , 0; 0, 1])*[s1; s2];

    //  [T1.ia; T1.ib] = (if closed then [1, 0; 0, 1] else small*[1, -1; 1, 1])*[s1
  //    ; s2];

  if closed then
    [T1.va - T2.va; T1.vb - T2.vb] = small*[1, -1; 1, 1]*[T1.ia; T1.ib];
  else
    [T1.ia; T1.ib] = small*[1, -1; 1, 1]*[T1.va - T2.va; T1.vb - T2.vb];
  end if;
  [T1.ia; T1.ib] = -[T2.ia; T2.ib];
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{44,0},{100,0}}, color={0,0,0}),
        Line(points={{-40,0},{32,34}}, color={0,0,0}),
        Ellipse(
          extent={{-44,4},{-36,-4}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,4},{44,-4}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,0},{-44,0}}, color={0,0,0}),
        Text(extent={{80,-60},{-80,-20}}, textString=
                                              "%name")}));
end BreakerBase;
