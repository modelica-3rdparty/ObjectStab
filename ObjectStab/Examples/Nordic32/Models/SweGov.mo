within ObjectStab.Examples.Nordic32.Models;
model SweGov
  extends ObjectStab.Generators.Controllers.Partials.Governor;

  parameter Real Rdyn=0.8;
  parameter Real Rstat=0.04;
  parameter Real Tr=5;
  parameter Real Tw=1;
  parameter Real GateMax=0.95;
  parameter Real GateMin=0.0;
  Modelica.Blocks.Continuous.TransferFunction Filter(a={0.05,1}, b={1})
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  Modelica.Blocks.Math.Feedback Feedback1 annotation (Placement(
        transformation(extent={{-50,60},{-30,80}})));
  Modelica.Blocks.Math.Gain Gain2(k=Rstat)
    annotation (Placement(transformation(
        origin={-40,40},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  Modelica.Blocks.Continuous.Integrator Int(k=1/Tr)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Math.Add Add3(k1=+1/Rdyn, k2=+1/Rdyn) annotation (Placement(
        transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Nonlinear.Limiter Limiter1(uMax=GateMax, uMin=GateMin)
    annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
  Modelica.Blocks.Continuous.TransferFunction Servo(
    x(start={1}),
    a={0.2,1},
    b={1}) annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Nordic32.Models.WaterWays Water annotation (Placement(transformation(
          extent={{50,10},{70,-10}})));
  Modelica.Blocks.Math.Add AddPm0 annotation (Placement(transformation(
          extent={{-34,-10},{-14,10}})));
equation
  connect(Int.u, Filter.y) annotation (Line(points={{18,70},{1,70}}));
  connect(Int.y, Add3.u2) annotation (Line(points={{41,70},{58,64}}));
  connect(Feedback1.u2, Gain2.y)
    annotation (Line(points={{-40,62},{-40,52},{-40,51}}));
  connect(Add3.u1, Filter.y)
    annotation (Line(points={{58,76},{50,76},{50,92},{8,92},{8,70},{1,70}}));
  connect(Gain2.u, Add3.y)
    annotation (Line(points={{-40,28},{-40,22},{90,22},{90,70},{84,70},{
          81,70}}));
  connect(Water.u, Servo.y) annotation (Line(points={{48,0},{43,0}}));
  connect(Servo.u, Limiter1.y) annotation (Line(points={{18,0},{15,0}}));
  connect(Feedback1.y, Filter.u) annotation (Line(points={{-31,70},{-24,
          70}}));
  connect(AddPm0.y, Limiter1.u)
    annotation (Line(points={{-13,0},{-8,0}}, color={0,0,255}));
  connect(werror.y, Feedback1.u1)
    annotation (Line(points={{-58,0},{-54,0},{-54,70},{-50,70}}, color={0,
          0,255}));
  connect(Water.y, Limiter.u)
    annotation (Line(points={{71,0},{72,0}}, color={0,0,255}));
  connect(AddPm0.u1, Gain2.u)
    annotation (Line(points={{-36,6},{-40,6},{-40,26}}, color={0,0,255}));

  AddPm0.u2 = {Pm0};

initial equation
  Filter.y = 0;
  der(Servo.x) = {0};
  Int.y = {0};

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-72,30},{82,-34}},
            textString=                         "BsweGov")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-56,-18},{-36,-26}},
            textString=                              "Pm0"), Line(points=
              {{-38,-6},{-44,-18}})}),
    Diagram);
end SweGov;
