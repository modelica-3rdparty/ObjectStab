within ObjectStab.Extras;
model ExtSlack
  extends Generators.Partials.Generator(isSlack=true);

public
  Modelica.Blocks.Interfaces.RealInput InPort   annotation (Placement(
        transformation(
        origin={20,-70},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  if online then
    if not isSlack then
      V = V0;
      Pg = Pg0;
    else
      1 + T.va = V0*cos(theta0);
      T.vb = V0*sin(theta0);
    end if;
  else
    T.ia = 0;
    T.ib = 0;
  end if;
  // contribute to angle reference calculation
  wrl.wr.Hwsum = if online then Modelica.Constants.inf else 0;
  wrl.wr.Hsum = if online then Modelica.Constants.inf else 0;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,60},{80,-60}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Text(extent={{-60,100},{100,60}}, textString=
                                              "%name"),
        Text(extent={{-40,-20},{80,20}}, textString=
                                             "Slack")}));
end ExtSlack;
