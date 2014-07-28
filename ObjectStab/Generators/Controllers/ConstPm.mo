within ObjectStab.Generators.Controllers;
model ConstPm
  extends Partials.Governor;

initial equation
  wref = u;

equation
  Limiter.u = Pm0;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{48,-20},{64,-28}}, textString=
                                                   "Pm0"), Line(points={{72,
              0},{56,0},{56,-14}})}));
end ConstPm;
