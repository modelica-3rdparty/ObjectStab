within ObjectStab.Examples.Nordic32.Models;
model SweExcLim
  extends ObjectStab.Generators.Controllers.Partials.Exciter(
    K=120,
    Efmax=5,
    Efmin=0);
  parameter Real Sbase=100;
  parameter Real Ta=5;
  parameter Real Tb=50;
  parameter Real Tc=0.1;
  parameter Real Limits=100;
  parameter Real Kpss=1;
  parameter Real Limitf=3.74;

  parameter ObjectStab.Base.Time StepTime=1.0 "Time for voltage reference step";

  Real u3;
  Real u4;
  Real u5;
  Modelica.Blocks.Math.Add PSSAdd annotation (Placement(transformation(
          extent={{-44,-16},{-24,4}})));
  Nordic32.Models.Limiter ExcLimit(
    Limitf=Limitf,
    Taf=120,
    Limits=Limits,
    Tas=120) annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealInput inPort3
    annotation (Placement(transformation(extent={{-122,78},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput inPort4
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput inPort5
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Modelica.Blocks.Continuous.TransferFunction AVRtf(a={Tb*Tc,(Tc + Tb),1},
      b={K*Ta,K}) annotation (Placement(transformation(extent={{30,-10},{
            50,10}})));
  Modelica.Blocks.Continuous.TransferFunction PSStf1(a={91.125,60.75,13.5,
        1}, b={-91.125,0,0,0}) annotation (Placement(transformation(
          extent={{-70,-70},{-50,-50}})));
  Modelica.Blocks.Continuous.TransferFunction PSStf(a={2,1}, b={0.6,1.3})
    annotation (Placement(transformation(extent={{-34,-70},{-14,-50}})));
  Modelica.Blocks.Nonlinear.Limiter PSSLim(uMax=0.05, uMin=-0.05)
    annotation (Placement(transformation(extent={{34,-70},{54,-50}})));
  Modelica.Blocks.Math.Gain G(k=Kpss*ObjectStab.Base.Sbase/Sbase)
    annotation (Placement(transformation(extent={{0,-70},{20,-50}})));
equation
  connect(PSStf1.y, PSStf.u) annotation (Line(points={{-49,-60},{-38,-60}}));
  connect(G.u, PSStf.y) annotation (Line(points={{-2,-60},{-13,-60}}));
  connect(G.y, PSSLim.u) annotation (Line(points={{21,-60},{32,-60}}));
  connect(PSSAdd.u2, PSSLim.y) annotation (Line(points={{-46,-12},{-52,
          -12},{-52,-40},{66,-40},{66,-60},{56,-60}}, color={0,0,255}));
  connect(ExcLimit.inPort3, PSSAdd.y)
    annotation (Line(points={{-4,-3},{-12,-3},{-12,-6},{-22,-6}}, color={
          0,0,255}));
  connect(ExcLimit.inPort2, inPort3) annotation (Line(points={{-4,3},{-12,
          3},{-12,90},{-111,90}}, color={0,0,255}));
  connect(ExcLimit.outPort, AVRtf.u)
    annotation (Line(points={{21,0},{26,0}}, color={0,0,255}));
  connect(AVRtf.y, Limiter.u)
    annotation (Line(points={{51,0},{70,0}}, color={0,0,255}));
  connect(Limiter.y, ExcLimit.inPort1) annotation (Line(points={{95,0},{
          100,0},{100,72},{-9,72},{-9,8},{-4,8}}, color={0,0,255}));
  connect(PSStf1.u, inPort5)
    annotation (Line(points={{-72,-60},{-110,-60}}, color={0,0,255}));
  connect(ExcLimit.inPort4, inPort4) annotation (Line(points={{-2,-8},{
          -18,-8},{-18,30},{-100,30}}, color={0,0,255}));
  connect(Verror.y, PSSAdd.u1)
    annotation (Line(points={{-58,0},{-48,0}}, color={0,0,255}));

  u3 =inPort3;
  u4 =inPort4;
  u5 =inPort5;
  Ef0 = 0;
initial equation

  der(AVRtf.x) = {0,0};
  der(PSStf.x) = {0};
  der(PSStf1.x) = {0,0,0};
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-82,30},{84,-32}},
            textString=                         "SweExcLim")}));
end SweExcLim;
