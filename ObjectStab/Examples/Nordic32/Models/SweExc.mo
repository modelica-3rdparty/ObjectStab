within ObjectStab.Examples.Nordic32.Models;
model SweExc
  extends ObjectStab.Generators.Controllers.Partials.Exciter(Efmax=5,
      Efmin=0);
  parameter Real Sbase=100;
  parameter Real Ta=5;
  parameter Real Tb=50;
  parameter Real Tc=0.1;
  parameter Real Limits=100;
  parameter Real Kpss=1;
  parameter Real Limitf=3.74;

  parameter ObjectStab.Base.Time StepTime=1.0 "Time for voltage reference step";
  Real u5=inPort5;
  Modelica.Blocks.Continuous.TransferFunction PSStf(a={2,1}, b={0.6,1.3})
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Continuous.TransferFunction AVRtf(a={Tb*Tc,(Tc + Tb),1},
      b={K*Ta,K}) annotation (Placement(transformation(extent={{26,-10},{
            46,10}})));
  Modelica.Blocks.Continuous.TransferFunction PSStf1(a={91.125,60.75,13.5,
        1}, b={-91.125,0,0,0}) annotation (Placement(transformation(
          extent={{-90,-70},{-70,-50}})));
  Modelica.Blocks.Nonlinear.Limiter PSSLim(uMax=0.05, uMin=-0.05)
    annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
  Modelica.Blocks.Math.Add PSSAdd(k1=+1, k2=+1) annotation (Placement(
        transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Interfaces.RealInput inPort5
    annotation (Placement(transformation(extent={{-138,-80},{-98,-40}})));
  Modelica.Blocks.Math.Gain G(k=Kpss*ObjectStab.Base.Sbase/Sbase)
    annotation (Placement(transformation(extent={{-26,-70},{-6,-50}})));
equation
  connect(PSStf1.y, PSStf.u) annotation (Line(points={{-69,-60},{-62,-60}}));
  connect(PSSAdd.y, AVRtf.u) annotation (Line(points={{1,0},{24,0}}));
  connect(G.u, PSStf.y)
    annotation (Line(points={{-28,-60},{-40,-60}}, color={0,0,255}));
  connect(AVRtf.y, Limiter.u)
    annotation (Line(points={{47,0},{72,0}}, color={0,0,255}));
  connect(PSSAdd.u2, PSSLim.y) annotation (Line(points={{-24,-6},{-38,-6},
          {-38,-32},{42,-32},{42,-60},{31,-60}}, color={0,0,255}));
  connect(G.y, PSSLim.u)
    annotation (Line(points={{-4,-60},{8,-60}}, color={0,0,255}));
  connect(Verror.y, PSSAdd.u1)
    annotation (Line(points={{-60,0},{-41,0},{-41,6},{-22,6}}, color={0,0,
          255}));
  connect(inPort5, PSStf1.u)
    annotation (Line(points={{-128,-60},{-92,-60}}, color={0,0,255}));

  Ef0 = 0;

initial equation

  der(AVRtf.x) = {0,0};
  PSStf.x = {0};
  PSStf1.x = {0,0,0};
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-82,30},{84,-32}},
            textString=                         "SweExc")}));
end SweExc;
