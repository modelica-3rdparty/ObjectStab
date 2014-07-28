within ObjectStab.Examples.KundurHJW;
model SystemPV
  extends Net;
  replaceable ObjectStab.Network.Pilink L78_1(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  Generators.PVNode PV_1(V0=1.03, Pg0=7)
    annotation (Placement(transformation(extent={{-170,-10},{-190,10}})));
  Generators.PVNode PV_2(V0=1.01, Pg0=7)
    annotation (Placement(transformation(extent={{-130,-40},{-150,-20}})));
  Generators.PVNode PV_3(
    V0=1.03,
    Pg0=7,
    isSlack=true,
    theta0=-0.11868238913561)
    annotation (Placement(transformation(extent={{170,-10},{190,10}})));
  Generators.PVNode PV_4(V0=1.01, Pg0=7)
    annotation (Placement(transformation(extent={{130,-40},{150,-20}})));
equation
  connect(bus7.T, L78_1.T1) annotation (Line(
      points={{-40,0},{-40,40},{-30,40}},
      color={0,0,255}));
  connect(L78_1.T2, bus8.T) annotation (Line(
      points={{-10,40},{0,40},{0,0}},
      color={0,0,255}));
  connect(PV_1.T, bus1.T) annotation (Line(
      points={{-170,0},{-160,0}},
      color={0,0,255}));
  connect(PV_2.T, bus2.T) annotation (Line(
      points={{-130,-30},{-120,-30}},
      color={0,0,255}));
  connect(PV_3.T, bus3.T) annotation (Line(
      points={{170,0},{160,0}},
      color={0,0,255}));
  connect(PV_4.T, bus4.T) annotation (Line(
      points={{130,-30},{120,-30}},
      color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-100},{200,100}},
        grid={2,2}), graphics),
    experiment(StopTime=6));
end SystemPV;
