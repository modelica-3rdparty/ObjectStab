within ObjectStab.Generators.Controllers;
model Gover2
  extends ObjectStab.Generators.Controllers.Partials.Governor(Pmmax=100,
      Pmmin=-100);
  parameter Base.AngularVelocity wref=1 "Reference Angular Velocity";
  parameter Real Kgov=1 "Governor Gain";
  parameter Real TRH=10;
  parameter Real PROPH=0.3;
  Modelica.Blocks.Continuous.TransferFunction TF(
    x(start={0}),
    a={TRH,1},
    b={Kgov*PROPH*TRH,Kgov})
                  annotation (Placement(transformation(extent={{-20,-10},{0,
            10}})));
  Modelica.Blocks.Math.Add PmAdd annotation (Placement(transformation(
          extent={{42,-10},{62,10}})));

initial equation
  der(TF.y) = 0;

equation
  PmAdd.u2 = Pm0;

  connect(TF.y,PmAdd.u1)             annotation (Line(points={{1,0},{20.5,0},
          {20.5,6},{40,6}}, color={0,0,255}));
  connect(Limiter.u,PmAdd.y)             annotation (Line(points={{74,0},{
          63,0}}, color={0,0,255}));
  connect(werror.y,TF.u)             annotation (Line(points={{-59,0},{-22,
          0}}, color={0,0,255}));

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{42,-6},{26,-6},{26,-20}}),
          Text(extent={{18,-24},{34,-32}}, textString=
                             "Pm0")}));
end Gover2;
