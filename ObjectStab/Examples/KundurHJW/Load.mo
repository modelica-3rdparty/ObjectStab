within ObjectStab.Examples.KundurHJW;
model Load
  extends ObjectStab.Base.System;
  Generators.Slack slack(V0=1.03)
    annotation (Placement(transformation(extent={{-170,-10},{-190,10}})));
  Network.Bus            bus1 annotation (Placement(transformation(extent={{-170,
            -10},{-150,10}})));
  Network.FixTransformer            T15(X=0.15/9) annotation (Placement(
        transformation(extent={{-150,-10},{-130,10}})));
  Network.Bus            bus5 annotation (Placement(transformation(extent={{-130,
            -10},{-110,10}})));
  Network.Pilink            L56(
    R=0.0001*25,
    X=0.001*25,
    B=0.00175*25) annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Network.Bus            bus6 annotation (Placement(transformation(extent={{-90,-10},
            {-70,10}})));
  Network.Pilink            L67(
    R=0.0001*10,
    X=0.001*10,
    B=0.00175*10) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Network.Bus            bus7 annotation (Placement(transformation(
        origin={-40,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Base.PowerMeasurement Pmeter7 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-40})));
  Loads.ZIPLoad            L7(
    P0=9.67,
    Q0=1,
    pZ=0,
    pI=1,
    qZ=1,
    qI=0) annotation (Placement(transformation(
        origin={-40,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  Network.ShuntCapacitor            C7(B=2) annotation (Placement(
        transformation(
        origin={-20,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(bus1.T, T15.T1) annotation (Line(
      points={{-160,0},{-150,0}},
      color={0,0,255}));
  connect(T15.T2,bus5. T) annotation (Line(
      points={{-130,0},{-120,0}},
      color={0,0,255}));
  connect(bus5.T, L56.T1) annotation (Line(
      points={{-120,0},{-110,0}},
      color={0,0,255}));
  connect(L56.T2,bus6. T) annotation (Line(
      points={{-90,0},{-80,0}},
      color={0,0,255}));
  connect(bus6.T, L67.T1) annotation (Line(
      points={{-80,0},{-70,0}},
      color={0,0,255}));
  connect(L67.T2,bus7. T) annotation (Line(
      points={{-50,0},{-40,0}},
      color={0,0,255}));
  connect(bus7.T, C7.T) annotation (Line(
      points={{-40,0},{-40,-20},{-20,-20},{-20,-60}},
      color={0,0,255}));
  connect(slack.T,bus1. T) annotation (Line(
      points={{-170,0},{-160,0}},
      color={0,0,255}));
  connect(bus7.T, Pmeter7.T1) annotation (Line(
      points={{-40,0},{-40,-30}},
      color={0,0,255}));
  connect(Pmeter7.T2, L7.T) annotation (Line(
      points={{-40,-50},{-40,-60}},
      color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-100},{200,100}},
        grid={2,2}), graphics),
    experiment);
end Load;
