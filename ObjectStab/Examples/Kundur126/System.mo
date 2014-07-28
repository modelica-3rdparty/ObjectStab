within ObjectStab.Examples.Kundur126;
model System
  extends ObjectStab.Base.System;
  Gen G1(
    V0=1.03,
    Pg0=7,
    Sbase=900,
    H=6.5) annotation (Placement(transformation(
        origin={-176,168},
        extent={{-20,-20},{20,20}},
        rotation=180)));
  Gen G2(
    V0=1.01,
    Pg0=7,
    Sbase=900,
    H=6.5) annotation (Placement(transformation(
        origin={-86,108},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  Gen G3(
    V0=1.03,
    theta0=-6.8*Modelica.Constants.pi/180,
    Pg0=7,
    Sbase=900,
    H=6.175,
    isSlack=true) annotation (Placement(transformation(extent={{162,148},{
            204,188}})));
  Gen G4(
    V0=1.01,
    Pg0=7,
    Sbase=900,
    H=6.175) annotation (Placement(transformation(
        origin={94,112},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  ObjectStab.Network.FixTransformer T15(X=0.15/9) annotation (Placement(
        transformation(extent={{-146,158},{-126,178}})));
  ObjectStab.Network.Bus Bus1 annotation (Placement(transformation(extent={
            {-166,158},{-146,178}})));
  ObjectStab.Network.Bus Bus2 annotation (Placement(transformation(
        origin={-86,128},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.FixTransformer T26(X=0.15
                                             /9) annotation (Placement(
        transformation(
        origin={-86,148},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Bus Bus5 annotation (Placement(transformation(extent={
            {-126,158},{-106,178}})));
  ObjectStab.Network.Bus Bus6 annotation (Placement(transformation(extent={
            {-86,158},{-66,178}})));
  ObjectStab.Network.Pilink L56(
    R=0.0001*25,
    X=0.001*25,
    B=0.00175*25) annotation (Placement(transformation(extent={{-106,158},{
            -86,178}})));
  ObjectStab.Network.Pilink L67(
    R=0.0001*10,
    X=0.001*10,
    B=0.00175*10) annotation (Placement(transformation(extent={{-66,158},{
            -46,178}})));
  ObjectStab.Loads.ZIPLoad L7(
    P0=9.67,
    Q0=1,
    pZ=0,
    pI=1,
    qZ=1,
    qI=0) annotation (Placement(transformation(
        origin={-46,148},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  replaceable ObjectStab.Network.Pilink L78_1(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{-26,168},{
            -6,188}})));
  ObjectStab.Network.Bus Bus8 annotation (Placement(transformation(
        origin={4,168},
        extent={{-10,-20},{10,20}},
        rotation=180)));
  ObjectStab.Network.Pilink L78_2(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{-26,148},{
            -6,168}})));
  ObjectStab.Network.Bus Bus7 annotation (Placement(transformation(
        origin={-36,168},
        extent={{-10,-20},{10,20}},
        rotation=180)));
  ObjectStab.Network.Bus Bus9 annotation (Placement(transformation(
        origin={44,168},
        extent={{-10,-20},{10,20}},
        rotation=180)));
  ObjectStab.Network.Pilink L89_1(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{14,168},{
            34,188}})));
  ObjectStab.Network.Pilink L89_2(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{14,148},{
            34,168}})));
  ObjectStab.Network.Pilink L910(
    R=0.0001*10,
    X=0.001*10,
    B=0.00175*10) annotation (Placement(transformation(extent={{54,158},{74,
            178}})));
  ObjectStab.Network.Bus Bus10 annotation (Placement(transformation(extent=
            {{74,158},{94,178}})));
  ObjectStab.Network.FixTransformer T410(X=0.15
                                              /9) annotation (Placement(
        transformation(
        origin={94,148},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Bus Bus4 annotation (Placement(transformation(
        origin={94,128},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Pilink L1011(
    R=0.0001*25,
    X=0.001*25,
    B=0.00175*25) annotation (Placement(transformation(extent={{94,158},{
            114,178}})));
  ObjectStab.Network.FixTransformer T311(X=0.15/9) annotation (Placement(
        transformation(extent={{134,158},{154,178}})));
  ObjectStab.Network.Bus Bus3 annotation (Placement(transformation(extent={
            {154,158},{174,178}})));
  ObjectStab.Loads.ZIPLoad L9(
    P0=17.67,
    Q0=1,
    pZ=0,
    pI=1,
    qZ=1,
    qI=0) annotation (Placement(transformation(
        origin={54,148},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C7(B=2) annotation (Placement(
        transformation(
        origin={-26,140},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C9(B=3.5) annotation (Placement(
        transformation(
        origin={36,142},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Bus Bus11 annotation (Placement(transformation(extent=
            {{114,158},{134,178}})));
equation
  connect(T15.T1, Bus1.T) annotation (Line(points={{-146,168},{-156,168}}));
  connect(Bus1.T, G1.T) annotation (Line(points={{-156,168},{-156,168}}));
  connect(G2.T, Bus2.T) annotation (Line(points={{-86,128},{-86,128}}));
  connect(T26.T1, Bus2.T) annotation (Line(points={{-86,138},{-86,128}}));
  connect(Bus5.T, T15.T2) annotation (Line(points={{-116,168},{-126,168}}));
  connect(Bus5.T, L56.T1) annotation (Line(points={{-116,168},{-106,168}}));
  connect(L56.T2, Bus6.T) annotation (Line(points={{-86,168},{-76,168}}));
  connect(T26.T2, Bus6.T) annotation (Line(points={{-86,158},{-86,162},{-76,
          162},{-76,168}}));
  connect(Bus6.T, L67.T1) annotation (Line(points={{-76,168},{-64,168},{-66,
          168}}));
  connect(L78_1.T2, Bus8.T) annotation (Line(points={{-6,178},{4,178},{4,
          168}}));
  connect(L78_2.T2, Bus8.T) annotation (Line(points={{-6,158},{4,158},{4,
          168}}));
  connect(L67.T2, Bus7.T) annotation (Line(points={{-46,168},{-36,168}}));
  connect(Bus7.T, L78_1.T1) annotation (Line(points={{-36,168},{-36,178},{
          -26,178}}));
  connect(L78_2.T1, Bus7.T) annotation (Line(points={{-26,158},{-36,158},{
          -36,168}}));
  connect(L89_2.T1, Bus8.T) annotation (Line(points={{14,158},{4,158},{4,
          168}}));
  connect(L89_1.T1, Bus8.T) annotation (Line(points={{14,178},{4,178},{4,
          168}}));
  connect(L89_1.T2, Bus9.T) annotation (Line(points={{34,178},{44,178},{44,
          168}}));
  connect(L89_2.T2, Bus9.T) annotation (Line(points={{34,158},{44,158},{44,
          168}}));
  connect(L910.T1, Bus9.T) annotation (Line(points={{54,168},{44,168}}));
  connect(Bus10.T, L910.T2) annotation (Line(points={{84,168},{74,168}}));
  connect(L7.T, Bus7.T) annotation (Line(points={{-46,158},{-36,158},{-36,
          168}}));
  connect(Bus4.T, T410.T1) annotation (Line(points={{94,128},{94,138}}));
  connect(T410.T2, Bus10.T) annotation (Line(points={{94,158},{94,162},{84,
          162},{84,168}}));
  connect(L1011.T1, Bus10.T) annotation (Line(points={{94,168},{84,168}}));
  connect(Bus3.T, T311.T2) annotation (Line(points={{164,168},{154,168}}));
  connect(L9.T, Bus9.T) annotation (Line(points={{54,158},{44,168}}));
  connect(G4.T, Bus4.T) annotation (Line(points={{94,132},{94,128}}));
  connect(G3.T, Bus3.T) annotation (Line(points={{162,168},{164,168}}));
  connect(C7.T, Bus7.T) annotation (Line(points={{-26,150},{-36,158},{-36,
          168}}));
  connect(C9.T, Bus9.T) annotation (Line(points={{36,152},{44,158},{44,168}}));
  connect(Bus11.T, L1011.T2) annotation (Line(points={{124,168},{114,168}}));
  connect(Bus11.T, T311.T1) annotation (Line(points={{124,168},{134,168}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-200},{200,200}},
        grid={2,2}), graphics={Line(points={{164,168},{164,168}}), Line(
            points={{94,128},{94,128}})}));
end System;
