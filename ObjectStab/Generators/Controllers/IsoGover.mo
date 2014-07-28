within ObjectStab.Generators.Controllers;
model IsoGover "Governor Control With Frequency Regulation"
  extends Partials.Governor;

  parameter Base.AngularVelocity wref=1 "Reference Angular Velocity";
  parameter Real Kgov=1 "Governor Gain";
  parameter Real TRH=10;
  parameter Real PROPH=0.3;

  parameter Real Tfreq=15;

  Modelica.Blocks.Continuous.TransferFunction Gov(
    x(start={0}),
    a={TRH,1},
    b={Kgov*PROPH*TRH,Kgov})
                  annotation (Placement(transformation(extent={{-20,20},{0,
            40}})));
  Modelica.Blocks.Continuous.TransferFunction IsoFreq(a={1,0}, b={Kgov/
        Tfreq})
            annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Add3 Add3 annotation (Placement(transformation(
          extent={{40,-10},{60,10}})));

initial equation
  Add3.u1 = 0;
  Add3.u2 = 0;

equation
  Add3.u3 = Pm0;

  connect(werror.y,Gov.u)             annotation (Line(points={{-59,0},{-40,
          0},{-40,30},{-22,30}}, color={0,0,255}));
  connect(Add3.y,Limiter.u)             annotation (Line(points={{61,0},{74,
          0}}, color={0,0,255}));
  connect(Add3.u1,Gov.y)             annotation (Line(points={{38,8},{16,8},
          {16,30},{1,30}}, color={0,0,255}));
  connect(werror.y,IsoFreq.u)             annotation (Line(points={{-59,0},
          {-40,0},{-40,-30},{-22,-30}}, color={0,0,255}));
  connect(IsoFreq.y,Add3.u2)             annotation (Line(points={{1,-30},{
          12,-30},{12,0},{38,0}}, color={0,0,255}));
end IsoGover;
