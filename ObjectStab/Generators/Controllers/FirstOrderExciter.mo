within ObjectStab.Generators.Controllers;
model FirstOrderExciter
  extends Partials.Exciter;

  parameter Real T=0.05 "Voltage Regulator Time Constant";

  Modelica.Blocks.Continuous.TransferFunction AVR(a={T,1}, b={K})
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));

initial equation
  Ef0 = 0;
  der(AVR.x) = {0};

equation
  connect(AVR.y,Limiter.u)             annotation (Line(points={{41,0},{72,
          0}}, color={0,0,255}));
  connect(Verror.y,AVR.u)             annotation (Line(points={{-59,0},{18,
          0}}, color={0,0,255}));
end FirstOrderExciter;
