within ObjectStab.Generators.Controllers;
model ConstEfd
  extends Partials.Exciter;

initial equation
  Vref = Modelica.Constants.inf;

equation
  Limiter.u = Ef0;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(
          extent={{-130,36},{-110,16}},
          lineColor={0,0,0},
          textString=
               "V"), Text(
          extent={{100,32},{120,12}},
          lineColor={0,0,0},
          textString=
               "Efd")}));
end ConstEfd;
