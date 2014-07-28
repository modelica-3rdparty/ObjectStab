within ObjectStab.Examples.BPA;
class system
  extends ObjectStab.Base.System;
  Real Ploss;
  Real Qloss;
  Real Pload;
  Real Qload;

  BPAGen G2(
    V0=0.9646,
    Pg0=17.36,
    Sbase=2200,
    H=2.33,
    D=0.2) annotation (Placement(transformation(
        origin={-90,-10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  BPAGen G3(
    V0=0.9553,
    Pg0=11.55,
    Sbase=1600,
    H=2.09,
    D=0.2) annotation (Placement(transformation(extent={{60,60},{80,80}})));
  replaceable ObjectStab.Loads.DynLoad L8(
    P0=33.7,
    Q0=10.5,
    as=0,
    at=2,
    bs=0,
    bt=2,
    Tp=1,
    Tq=1) annotation (Placement(transformation(extent={{60,20},{80,40}})));
  replaceable ObjectStab.Loads.ImpedanceLoad L11(P0=34.9, Q0=0) annotation (Placement(
        transformation(extent={{130,-40},{152,-20}})));
  ObjectStab.Network.Bus Bus1 annotation (Placement(transformation(extent={
            {-120,60},{-100,80}})));
  ObjectStab.Network.Bus Bus2 annotation (Placement(transformation(extent={
            {-80,-20},{-60,0}})));
  ObjectStab.Network.Bus Bus3 annotation (Placement(transformation(extent={
            {40,60},{60,80}})));
  ObjectStab.Network.Bus Bus5 annotation (Placement(transformation(extent={
            {-80,60},{-60,80}})));
  ObjectStab.Network.Bus Bus6 annotation (Placement(transformation(
        origin={-30,20},
        extent={{-10,-80},{10,80}},
        rotation=180)));
  ObjectStab.Network.Bus Bus7 annotation (Placement(transformation(
        origin={10,20},
        extent={{-10,-80},{10,80}},
        rotation=180)));
  ObjectStab.Network.Bus Bus8 annotation (Placement(transformation(extent={
            {40,20},{60,40}})));
  ObjectStab.Network.Bus Bus9 annotation (Placement(transformation(extent={
            {40,-40},{60,-20}})));
  ObjectStab.Network.Bus Bus10 annotation (Placement(transformation(extent=
            {{80,-40},{100,-20}})));
  ObjectStab.Network.Bus Bus11 annotation (Placement(transformation(extent=
            {{120,-40},{140,-20}})));
  ObjectStab.Network.ShuntCapacitor C7(B=9.63) annotation (Placement(
        transformation(
        origin={0,-44},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C8(B=7) annotation (Placement(
        transformation(
        origin={40,10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C9(B=4) annotation (Placement(
        transformation(
        origin={40,-44},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C11(B=1) annotation (Placement(
        transformation(
        origin={120,-44},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.FixTransformer T1(X=0.0020, n=0.8857) annotation (Placement(
        transformation(
        origin={-90,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.FixTransformer T2(X=0.0045, n=0.8857) annotation (Placement(
        transformation(
        origin={-50,-10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.FixTransformer T3(X=0.0125/2, n=0.9024) annotation (Placement(
        transformation(extent={{20,60},{40,80}})));
  ObjectStab.Network.FixTransformer T5(X=0.0026, n=1.08) annotation (Placement(
        transformation(
        origin={30,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  replaceable ObjectStab.Network.TCULDis T6(
    X=0.0010,
    n=1/0.96,
    Controller(
      method=3,
      Vref=0.922,
      maxtap=15,
      mintap=-15,
      stepsize=0.01,
      DB=0.02,
      Vblock=0.01)) annotation (Placement(transformation(extent={{102,-40},
            {122,-20}})));
  ObjectStab.Network.Pilink L56(
    R=0,
    X=0.0040,
    B=2) annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  replaceable ObjectStab.Extras.PQPilink L67_1(
    R=0.0015,
    X=0.0288,
    B=1.1730) annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  replaceable ObjectStab.Extras.PQPilink L67_2(
    R=0.0015,
    X=0.0288,
    B=1.1730) annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  replaceable ObjectStab.Extras.PQPilink L67_3(
    R=0.0015,
    X=0.0288,
    B=1.1730) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  replaceable ObjectStab.Extras.PQPilink L67_4(
    R=0.0015,
    X=0.0288,
    B=1.1730) annotation (Placement(transformation(extent={{-20,0},{0,20}})));
  replaceable ObjectStab.Extras.PQPilink L67_5(
    R=0.0015,
    X=0.0288,
    B=1.1730) annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  ObjectStab.Network.Impedance L910(R=0.0010, X=0.0030) annotation (Placement(
        transformation(extent={{60,-40},{80,-20}})));
  ObjectStab.Network.FixTransformer T4(X=0.0030, n=1.0664) annotation (Placement(
        transformation(
        origin={30,30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Generators.Slack G1(V0=0.98) annotation (Placement(
        transformation(
        origin={-130,70},
        extent={{-10,-10},{10,10}},
        rotation=180)));
equation
  connect(L910.T1, Bus9.T) annotation (Line(points={{60,-30},{54,-30},{50,
          -30}}));
  connect(L910.T2, Bus10.T) annotation (Line(points={{80,-30},{90,-30}}));
  connect(L11.T, Bus11.T) annotation (Line(points={{130,-30},{130,-30}}));
  connect(G3.T, Bus3.T) annotation (Line(points={{60,70},{50,70}}));
  connect(L67_1.T1, Bus6.T) annotation (Line(points={{-20,70},{-30,70},{-30,
          20}}));
  connect(L67_2.T1, Bus6.T) annotation (Line(points={{-20,50},{-30,50},{-30,
          20}}));
  connect(C7.T, Bus7.T) annotation (Line(points={{1.77636e-15,-34},{0,-30},
          {10,-30},{10,20}}));
  connect(L67_1.T2, Bus7.T) annotation (Line(points={{0,70},{10,70},{10,20}}));
  connect(L67_2.T2, Bus7.T) annotation (Line(points={{0,50},{10,50},{10,20}}));
  connect(L8.T, Bus8.T) annotation (Line(points={{60,30},{50,30}}));
  connect(L8.T, Bus8.T) annotation (Line(points={{60,30},{50,30}}));
  connect(L67_4.T1, Bus6.T) annotation (Line(points={{-20,10},{-30,10},{-30,
          20}}));
  connect(L67_4.T2, Bus7.T) annotation (Line(points={{0,10},{10,10},{10,20}}));
  connect(L67_5.T1, Bus6.T) annotation (Line(points={{-20,-10},{-30,-10},{
          -30,10},{-30,20}}));
  connect(L67_5.T2, Bus7.T) annotation (Line(points={{0,-10},{10,-10},{10,
          20}}));
  connect(L56.T1, Bus5.T) annotation (Line(points={{-60,70},{-70,70}}));
  connect(L56.T2, Bus6.T) annotation (Line(points={{-40,70},{-30,70},{-30,
          20}}));
  connect(L67_3.T1, Bus6.T) annotation (Line(points={{-20,30},{-30,30},{-30,
          20}}));
  connect(T1.T2, Bus1.T) annotation (Line(points={{-100,70},{-110,70}}));
  connect(T1.T1, Bus5.T) annotation (Line(points={{-80,70},{-72,70},{-70,70}}));
  connect(T3.T1, Bus7.T) annotation (Line(points={{20,70},{10,70},{10,20}}));
  connect(L67_3.T2, Bus7.T) annotation (Line(points={{0,30},{10,30},{10,10},
          {10,20}}));
  connect(T3.T2, Bus3.T) annotation (Line(points={{40,70},{50,70}}));
  connect(G2.T, Bus2.T) annotation (Line(points={{-80,-10},{-70,-10}}));
  connect(Bus2.T, T2.T2) annotation (Line(points={{-70,-10},{-60,-10}}));
  connect(T2.T1, Bus6.T) annotation (Line(points={{-40,-10},{-30,-10},{-30,
          20}}));
  connect(C8.T, Bus8.T) annotation (Line(points={{40,20},{40,26},{50,26},{
          50,30}}));
  connect(C11.T, Bus11.T) annotation (Line(points={{120,-34},{130,-34},{130,
          -30}}));
  connect(C9.T, Bus9.T) annotation (Line(points={{40,-34},{50,-34},{50,-34},
          {50,-30}}));
  connect(T6.T1, Bus10.T) annotation (Line(points={{102,-30},{90,-30}}));
  connect(T6.T2, Bus11.T) annotation (Line(points={{122,-30},{130,-30}}));
  connect(T5.T2, Bus7.T) annotation (Line(points={{20,-30},{10,-30},{10,20}}));
  connect(T5.T1, Bus9.T) annotation (Line(points={{40,-30},{50,-30}}));
  connect(T4.T2, Bus7.T) annotation (Line(points={{20,30},{10,30},{10,20}}));
  connect(T4.T1, Bus8.T) annotation (Line(points={{40,30},{50,30}}));
  connect(G1.T, Bus1.T) annotation (Line(points={{-120,70},{-110,70}}));
  Ploss = L67_1.Ploss + L67_2.Ploss + L67_3.Ploss + L67_4.Ploss + L67_5.
    Ploss;
  Qloss = L67_1.Qloss + L67_2.Qloss + L67_3.Qloss + L67_4.Qloss + L67_5.
    Qloss;
  Pload = L8.Pl + L11.Pl;
  Qload = L8.Ql + L11.Ql;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-140,-60},{160,120}},
        grid={2,2}), graphics));
end system;
