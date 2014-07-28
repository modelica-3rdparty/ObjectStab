within ObjectStab.Generators;
model GovExc3rdGen
  "3rd order generator model with constant mechanical power and field voltage"

  extends ObjectStab.Generators.Partials.DetGen3;
  replaceable ObjectStab.Generators.Controllers.ConstPm Gov
     constrainedby ObjectStab.Generators.Controllers.Partials.Governor
   annotation (Placement(
        transformation(extent={{12,-96},{32,-76}})));

  replaceable ObjectStab.Generators.Controllers.ConstEfd Exc annotation (Placement(
        transformation(extent={{12,70},{32,90}})));

equation
  // connection equations for governor and exciter
  Gov.u = w;
  Pm = Gov.y;
  Exc.u = sqrt(vd^2 + vq^2);
  Efd = Exc.y;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(
          points={{-100,0},{-20,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Ellipse(
          extent={{-20,40},{60,-40}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Line(points={{80,40},{80,80},{34,80}}, color={0,0,0}),
        Line(points={{-8,28},{-48,28},{-48,80},{8,80}}, color={0,0,0}),
        Text(
          extent={{-68,66},{-48,46}},
          lineColor={0,0,0},
          textString=
               "Vt"),
        Text(
          extent={{44,68},{64,48}},
          lineColor={0,0,0},
          textString=
               "Efd"),
        Line(
          points={{32,-86},{80,-86},{80,-40},{54,-22}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled}),
        Text(
          extent={{58,-56},{78,-76}},
          lineColor={0,0,0},
          textString=
               "Pm"),
        Text(
          extent={{-66,-54},{-46,-74}},
          lineColor={0,0,0},
          textString=
               "w"),
        Line(points={{-18,-14},{-44,-14},{-44,-86},{12,-86}}, color={0,0,0}),
        Line(
          points={{80,40},{54,20}},
          color={0,0,0},
          arrow={Arrow.None,Arrow.Filled})}),
    Documentation(info="The 3rd order Generator model extended with governor and exciter

The governor and exciter models can be redeclared with models
from the controller library or used-defined models.

"));
end GovExc3rdGen;
