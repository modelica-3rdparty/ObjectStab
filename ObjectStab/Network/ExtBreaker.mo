within ObjectStab.Network;
model ExtBreaker
  extends Partials.BreakerBase;

  Modelica.Blocks.Interfaces.BooleanInput u annotation (Placement(
        transformation(
        origin={0,110},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  closed = u;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{0,18},{0,112},{0,108}}, color={0,
              0,0})}),
    Documentation(info="The ideal breaker model is governed by the following models:


if breaker is closed then
  V1 = V2
  I1 + I2 = 0

else
  I1 = 0
  I2 = 0

"));
end ExtBreaker;
