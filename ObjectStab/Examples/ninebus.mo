within ObjectStab.Examples;
class ninebus "Nine bus test system, using 3rd order generator models"
  extends ObjectStab.Base.System;
  ObjectStab.Network.Bus Bus1 annotation (Placement(transformation(
        origin={-2,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Bus Bus2 annotation (Placement(transformation(extent={{
            -92,40},{-72,60}})));
  ObjectStab.Network.Bus Bus3 annotation (Placement(transformation(extent={{
            68,40},{88,60}})));
  ObjectStab.Network.FaultedBus Bus4(
    FaultTime=5,
    FaultDuration=1,
    FaultR=1) annotation (Placement(transformation(
        origin={-2,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Bus Bus5 annotation (Placement(transformation(
        origin={-42,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Bus Bus6 annotation (Placement(transformation(
        origin={38,10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Bus Bus7 annotation (Placement(transformation(extent={{
            -52,40},{-32,60}})));
  ObjectStab.Network.Bus Bus8 annotation (Placement(transformation(extent={{
            -12,40},{8,60}})));
  ObjectStab.Network.Bus Bus9 annotation (Placement(transformation(extent={{
            28,40},{48,60}})));
  ObjectStab.Network.Pilink L57(
    R=0.032,
    X=0.161,
    B=0.153*2,
    G=0) annotation (Placement(transformation(
        origin={-32,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Pilink L69(
    R=0.039,
    X=0.170,
    G=0,
    B=0.179*2) annotation (Placement(transformation(
        origin={28,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Pilink L78(
    R=0.0085,
    X=0.072,
    G=0,
    B=0.0745*2) annotation (Placement(transformation(extent={{-32,40},{-12,60}})));
  ObjectStab.Network.Pilink L89(
    R=0.0119,
    X=0.1008,
    G=0,
    B=0.1045*2) annotation (Placement(transformation(extent={{8,40},{28,60}})));
  ObjectStab.Network.FixTransformer T27(R=0, X=0.0625) annotation (Placement(
        transformation(
        origin={-62,50},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.FixTransformer T39(R=0, X=0.0586) annotation (Placement(
        transformation(extent={{48,40},{68,60}})));
  ObjectStab.Network.FixTransformer T14(R=0, X=0.0576) annotation (Placement(
        transformation(
        origin={-2,-30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Pilink L45(
    R=0.01,
    X=0.085,
    B=0.088*2,
    G=0) annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
  ObjectStab.Network.Pilink L46(
    R=0.017,
    X=0.092,
    B=0.079*2,
    G=0) annotation (Placement(transformation(extent={{8,0},{28,20}})));
  ObjectStab.Generators.GovExc3rdGen G2(
    V0=1.025,
    Pg0=1.63,
    Sbase=200,
    H=6.40,
    xd=0.8958,
    xq=0.8645,
    xdp=0.1198,
    Td0p=6,
    redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc)
    annotation (Placement(transformation(
        origin={-92,50},
        extent={{-10,10},{10,-10}},
        rotation=180)));
  ObjectStab.Generators.GovExc3rdGen G3(
    isSlack=false,
    V0=1.025,
    Pg0=0.85,
    H=3.01,
    xd=1.3125,
    xq=1.2578,
    xdp=0.1813,
    Td0p=5.89,
    redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc)
    annotation (Placement(transformation(
        origin={88,50},
        extent={{10,10},{-10,-10}},
        rotation=180)));
  ObjectStab.Loads.DynLoad LoadA(P0=1.25, Q0=0.5) annotation (Placement(
        transformation(extent={{-42,0},{-62,20}})));
  ObjectStab.Loads.DynLoad LoadC(P0=1, Q0=0.35) annotation (Placement(
        transformation(
        origin={-2,68},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Loads.DynLoad LoadB(P0=0.9, Q0=0.3) annotation (Placement(
        transformation(extent={{38,0},{58,20}})));
  ObjectStab.Generators.Slack G1(V0=1.04) annotation (Placement(
        transformation(
        origin={-2,-60},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(T14.T2, Bus1.T) annotation (Line(points={{-2,-40},{-2,-50}}));
  connect(Bus5.T, L45.T1) annotation (Line(points={{-42,10},{-32,10}}));
  connect(Bus6.T, L46.T2) annotation (Line(points={{38,10},{28,10}}));
  connect(Bus5.T, L57.T1) annotation (Line(points={{-42,10},{-32,20}}));
  connect(L57.T2, Bus7.T) annotation (Line(points={{-32,40},{-42,50}}));
  connect(L69.T2, Bus9.T) annotation (Line(points={{28,40},{38,50}}));
  connect(L69.T1, Bus6.T) annotation (Line(points={{28,20},{38,10}}));
  connect(L78.T2, Bus8.T) annotation (Line(points={{-12,50},{-2,50}}));
  connect(L78.T1, Bus7.T) annotation (Line(points={{-32,50},{-42,50}}));
  connect(L89.T1, Bus8.T) annotation (Line(points={{8,50},{-2,50}}));
  connect(L89.T2, Bus9.T) annotation (Line(points={{28,50},{38,50}}));
  connect(T27.T1, Bus7.T) annotation (Line(points={{-52,50},{-42,50}}));
  connect(Bus2.T, T27.T2) annotation (Line(points={{-82,50},{-72,50}}));
  connect(T39.T1, Bus9.T) annotation (Line(points={{48,50},{38,50}}));
  connect(T39.T2, Bus3.T) annotation (Line(points={{68,50},{78,50}}));
  connect(G2.T, Bus2.T) annotation (Line(points={{-82,50},{-82,50}}));
  connect(G3.T, Bus3.T) annotation (Line(points={{78,50},{78,50}}));
  connect(Bus4.T, L46.T1) annotation (Line(points={{-2,-10},{8,10}}));
  connect(Bus4.T, L45.T2) annotation (Line(points={{-2,-10},{-12,10}}));
  connect(Bus4.T, T14.T1) annotation (Line(points={{-2,-10},{-2,-18},{-2,-20}}));
  connect(LoadB.T, Bus6.T) annotation (Line(points={{38,10},{38,10}}));
  connect(LoadA.T, Bus5.T) annotation (Line(points={{-42,10},{-42,10}}));
  connect(Bus8.T, LoadC.T) annotation (Line(points={{-2,50},{-2,58}}));
  connect(G1.T, Bus1.T) annotation (Line(points={{-2,-50},{-2,-50}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-110,-80},{112,80}},
        grid={2,2}), graphics={
        Text(extent={{-108,-18},{-32,-54}}, textString=
                                                "ObjectStab"),
        Text(extent={{-108,-34},{-32,-70}}, textString=
            "MODELICA library for power systems"),
        Line(points={{38,10},{38,10}}),
        Line(points={{-42,10},{-42,10}}),
        Line(points={{-2,-50},{-2,-50}}),
        Line(points={{-2,-50},{-2,-50}}),
        Line(points={{-2,-50},{-2,-50}}),
        Line(points={{-2,50},{-2,58}}),
        Line(points={{38,10},{38,10}}),
        Line(points={{-42,10},{-42,10}}),
        Line(points={{-82,50},{-82,50}}),
        Line(points={{78,50},{78,50}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-110,-80},{112,80}},
        grid={2,2}), graphics),
    Documentation(info="System from [1]

Nine bus test system, using 3rd order generator models
---
[1]
P.M. Anderson and A.A. Fouad, Power System Control and Stability,
ISBN 0-7803-1029-2. IEEE Press, second edition, 1994.
"),           extent=[100, 20; 120, 40],
    Placement(transformation(extent={{100,20},{120,40}})));
end ninebus;
