within ObjectStab.Generators.Controllers;
model ExcST1ALim
  extends Partials.Exciter(
    K=200,
    Efmin=0,
    Efmax=7);

  parameter Real Tr=1.5 "AVR Time Constant";
  parameter Real Kstab=20 "Power System Stabilizer (PSS) Gain";
  parameter Real Tw=10 "Signal Washout Filter Time Constant";
  parameter Real T1=0.05 "PSS Phase Compensation Time Constant 1";
  parameter Real T2=0.02 "PSS Phase Compensation Time Constant 2";
  parameter Real T3=3 "PSS Phase Compensation Time Constant 3";
  parameter Real T4=5.4 "PSS Phase Compensation Time Constant 4";

  parameter Real vsmax=0.2 "PSS Maximum Output Limit";
  parameter Real vsmin=-0.2 "PSS Maximum Output Limit";

  outer Real w;
  Modelica.Blocks.Continuous.TransferFunction AVR(a={Tr,1}, b={1})
    annotation (Placement(transformation(extent={{-48,-10},{-28,10}})));
  Modelica.Blocks.Math.Add Sum(k1=+K, k2=+K) annotation (Placement(
        transformation(extent={{-4,-10},{16,10}})));
  Modelica.Blocks.Math.Gain PSSGain(k=Kstab)   annotation (Placement(
        transformation(extent={{-80,-70},{-60,-50}})));
  Modelica.Blocks.Continuous.TransferFunction WashOut(a={Tw,1}, b={Tw,0})
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Continuous.TransferFunction Phase_Compensation1(a={T2,1},
      b={T1,1})   annotation (Placement(transformation(extent={{0,-70},{20,
            -50}})));
  Modelica.Blocks.Nonlinear.Limiter PSSLimiter(uMax=vsmax, uMin=vsmin)
    annotation (Placement(transformation(extent={{64,-70},{84,-50}})));
  Modelica.Blocks.Continuous.TransferFunction Phase_Compensation2(a={T4,1},
      b={T3,1})   annotation (Placement(transformation(extent={{34,-70},{54,
            -50}})));
  Partials.ExcLimiter ExcLimit annotation (Placement(transformation(extent=
            {{36,-10},{56,10}})));

initial equation
  Ef0 = 0;
  der(AVR.y) = 0;
  WashOut.y = 0;
  Phase_Compensation2.y = 0;
  Phase_Compensation1.y = 0;

equation
  PSSGain.u = w;

  connect(AVR.y,Sum.u1)             annotation (Line(points={{-27,0},{-18,0},
          {-18,6},{-6,6}}));
  connect(WashOut.u,PSSGain.y)             annotation (Line(points={{-42,
          -60},{-59,-60}}));
  connect(Phase_Compensation1.u,WashOut.y)             annotation (Line(
        points={{-2,-60},{-19,-60}}));
  connect(PSSLimiter.y,Sum.u2)             annotation (Line(points={{85,-60},
          {90,-60},{90,-34},{-18,-34},{-18,-6},{-6,-6}}));
  connect(Phase_Compensation2.u,Phase_Compensation1.y)
    annotation (Line(points={{32,-60},{21,-60}}));
  connect(Phase_Compensation2.y,PSSLimiter.u)             annotation (Line(
        points={{55,-60},{62,-60}}));
  connect(Sum.y,ExcLimit.u)             annotation (Line(points={{17,0},{34,
          0}}, color={0,0,255}));
  connect(ExcLimit.y,Limiter.u)             annotation (Line(points={{57,0},
          {72,0}}, color={0,0,255}));
  connect(Verror.y,AVR.u)             annotation (Line(points={{-59,0},{-50,
          0}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-88,-30},{94,-90}},
          lineColor={160,160,164},
          pattern=LinePattern.Dot),
        Text(
          extent={{92,-96},{66,-76}},
          lineColor={128,128,128},
          textString=
               "PSS"),
        Text(extent={{-112,-56},{-92,-64}}, textString=
                                                "w-1"),
        Line(points={{-96,-60},{-80,-60}})}));
end ExcST1ALim;
