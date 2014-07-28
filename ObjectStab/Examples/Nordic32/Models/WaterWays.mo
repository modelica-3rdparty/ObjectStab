within ObjectStab.Examples.Nordic32.Models;
model WaterWays
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real Tw=1;

  Real x(start=0);
equation
  Tw*der(x) = (1 - (x/(u + 1e-8))^2);
  y = (x/(u + 1e-8))^2*x;

initial equation
  der(x) = 0;
end WaterWays;
