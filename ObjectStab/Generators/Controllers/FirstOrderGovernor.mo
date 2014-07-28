within ObjectStab.Generators.Controllers;
model FirstOrderGovernor
  extends Partials.Governor;

  parameter Real K=10 "Governor Gain";
  parameter Real T=5;

  Modelica.Blocks.Continuous.TransferFunction TF(
    x(start={0}),
    a={T,1},
    b={K})        annotation (Placement(transformation(extent={{-34,-10},{
            -14,10}})));
  Modelica.Blocks.Math.Add PmAdd annotation (Placement(transformation(
          extent={{42,-10},{62,10}})));

initial equation
  der(TF.y) = 0;

equation
  PmAdd.u2 = Pm0;

  connect(PmAdd.y,Limiter.u)             annotation (Line(points={{63,0},{
          74,0}}, color={0,0,255}));
  connect(TF.y,PmAdd.u1)             annotation (Line(points={{-13,0},{-2,0},
          {-2,6},{40,6}}, color={0,0,255}));
  connect(werror.y,TF.u)             annotation (Line(points={{-59,0},{-36,
          0}}, color={0,0,255}));

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{18,-24},{34,-32}}, textString=
                                                   "Pm0"), Line(points={{42,
              -6},{26,-6},{26,-20}})}));
end FirstOrderGovernor;
