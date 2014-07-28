within ObjectStab.Examples.KundurHJW;
model System
  extends Net;
  Gen G1(
    V0=1.03,
    Pg0=7,
    Sbase=900,
    H=6.5) annotation (Placement(transformation(
        origin={-180,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Gen G2(
    Pg0=7,
    Sbase=900,
    H=6.5,
    V0=1.01) annotation (Placement(transformation(
        origin={-140,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Gen G3(
    V0=1.03,
    theta0=-6.8*Modelica.Constants.pi/180,
    Pg0=7,
    Sbase=900,
    H=6.175,
    isSlack=true) annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Gen G4(
    Pg0=7,
    Sbase=900,
    H=6.175,
    V0=1.01) annotation (Placement(transformation(extent={{130,-40},{150,-20}})));
  replaceable ObjectStab.Network.Pilink L78_1(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
equation
  connect(G1.T, bus1.T) annotation (Line(
      points={{-170,0},{-160,0}},
      color={0,0,255}));
  connect(G2.T, bus2.T) annotation (Line(
      points={{-130,-30},{-120,-30}},
      color={0,0,255}));
  connect(G3.T, bus3.T) annotation (Line(
      points={{170,0},{160,0}},
      color={0,0,255}));
  connect(G4.T, bus4.T) annotation (Line(
      points={{130,-30},{120,-30}},
      color={0,0,255}));
  connect(bus7.T, L78_1.T1) annotation (Line(
      points={{-40,0},{-40,40},{-30,40}},
      color={0,0,255}));
  connect(L78_1.T2, bus8.T) annotation (Line(
      points={{-10,40},{0,40},{0,0}},
      color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-100},{200,100}},
        grid={2,2}), graphics),
    experiment(StopTime=6));
end System;
