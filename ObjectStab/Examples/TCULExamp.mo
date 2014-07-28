within ObjectStab.Examples;
model TCULExamp
  extends ObjectStab.Base.System;

  ObjectStab.Network.Bus Bus1 annotation (Placement(transformation(
        origin={-60,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Bus Bus2 annotation (Placement(transformation(
        origin={-20,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Bus Bus3 annotation (Placement(transformation(
        origin={0,30},
        extent={{-10,-40},{10,40}},
        rotation=270)));
  ObjectStab.Network.Bus Bus4 annotation (Placement(transformation(
        origin={20,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Bus Bus5 annotation (Placement(transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Bus Bus6 annotation (Placement(transformation(
        origin={30,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Generators.Slack Slack1 annotation (Placement(transformation(
          extent={{20,60},{40,80}})));
  ObjectStab.Generators.GovExc6thGen Gen(
    V0=1.05,
    Pg0=1,
    Sbase=200,
    redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc,
    redeclare ObjectStab.Generators.Controllers.IsoGover Gov) annotation (Placement(
        transformation(
        origin={-70,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Loads.ImpedanceLoad ImpedanceLoad1 annotation (Placement(
        transformation(
        origin={0,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Loads.ImpedanceLoad ImpedanceLoad2 annotation (Placement(
        transformation(
        origin={30,-20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor ShuntCapacitor1(B=0.6) annotation (Placement(
        transformation(
        origin={-26,20},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.OpenedPilink OpenedPilink1 annotation (Placement(
        transformation(extent={{-10,60},{10,80}})));
  ObjectStab.Network.Pilink Line1(X=0.2) annotation (Placement(transformation(
          extent={{-50,60},{-30,80}})));
  ObjectStab.Network.Pilink Line4(X=0.02, B=0.05) annotation (Placement(
        transformation(
        origin={-10,50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.TCULDis T1(Controller(InitByVoltage=true)) annotation (Placement(
        transformation(
        origin={0,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.TCULCon T2(n=1, Controller(InitByVoltage=true))
    annotation (Placement(transformation(
        origin={30,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(Bus4.T, Slack1.T) annotation (Line(points={{20,70},{20,70}}));
  connect(T1.T2, Bus5.T) annotation (Line(points={{-1.77636e-15,0},{0,-10}}));
  connect(ImpedanceLoad1.T, Bus5.T) annotation (Line(points={{1.77636e-15,-10},
          {0,-10}}));
  connect(ImpedanceLoad2.T, Bus6.T) annotation (Line(points={{30,-10},{30,-10}}));
  connect(T2.T2, Bus6.T) annotation (Line(points={{30,0},{30,-10}}));
  connect(Line4.T1, Bus3.T) annotation (Line(points={{-10,40},{-10,30},{0,30}}));
  connect(T2.T1, Bus3.T) annotation (Line(points={{30,20},{30,30},{0,30}}));
  connect(Bus3.T, ShuntCapacitor1.T) annotation (Line(points={{0,30},{-26,30}}));
  connect(T1.T1, Bus3.T) annotation (Line(points={{1.77636e-15,20},{0,30}}));
  connect(Bus4.T, OpenedPilink1.T2) annotation (Line(points={{20,70},{10,70}}));
  connect(Line4.T2, Bus2.T) annotation (Line(points={{-10,60},{-20,70}}));
  connect(OpenedPilink1.T1, Bus2.T) annotation (Line(points={{-10,70},{-20,70}}));
  connect(Line1.T2, Bus2.T) annotation (Line(points={{-30,70},{-20,70}}));
  connect(Bus1.T, Line1.T1) annotation (Line(points={{-60,70},{-50,70}}));
  connect(Gen.T, Bus1.T) annotation (Line(points={{-60,70},{-60,70}}));
end TCULExamp;
