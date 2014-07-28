within ObjectStab.Examples.KundurHJW;
partial model Net
  extends ObjectStab.Base.System;
  ObjectStab.Network.Bus bus1 annotation (Placement(transformation(extent={{-170,
            -10},{-150,10}})));
  ObjectStab.Network.FixTransformer T15(X=0.15/9) annotation (Placement(
        transformation(extent={{-150,-10},{-130,10}})));
  ObjectStab.Network.Bus bus2 annotation (Placement(transformation(
        origin={-120,-30},
        extent={{-10,-10},{10,10}})));
  ObjectStab.Network.FixTransformer T26(X=0.15/9) annotation (Placement(
        transformation(
        origin={-100,-30},
        extent={{-10,-10},{10,10}})));
  ObjectStab.Network.Bus bus5 annotation (Placement(transformation(extent={{-130,
            -10},{-110,10}})));
  ObjectStab.Network.Pilink L56(
    R=0.0001*25,
    X=0.001*25,
    B=0.00175*25) annotation (Placement(transformation(extent={{-110,-10},{
            -90,10}})));
  ObjectStab.Network.Bus bus6 annotation (Placement(transformation(extent={{-90,-10},
            {-70,10}})));
  ObjectStab.Network.Pilink L67(
    R=0.0001*10,
    X=0.001*10,
    B=0.00175*10) annotation (Placement(transformation(extent={{-70,-10},{
            -50,10}})));
  ObjectStab.Network.Bus bus7 annotation (Placement(transformation(
        origin={-40,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Base.PowerMeasurement sensorP7 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,-40})));
  ObjectStab.Loads.ZIPLoad L7(
    P0=9.67,
    Q0=1,
    pZ=0,
    pI=1,
    qZ=1,
    qI=0) annotation (Placement(transformation(
        origin={-40,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C7(B=2) annotation (Placement(
        transformation(
        origin={-20,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Bus bus3 annotation (Placement(transformation(extent={{150,-10},
            {170,10}})));
  ObjectStab.Network.FixTransformer T311(X=0.15/9) annotation (Placement(
        transformation(extent={{130,-10},{150,10}})));
  ObjectStab.Network.Bus bus4 annotation (Placement(transformation(
        origin={120,-30},
        extent={{-10,-10},{10,10}})));
  ObjectStab.Network.FixTransformer T410(X=0.15/9) annotation (Placement(
        transformation(
        origin={100,-30},
        extent={{10,-10},{-10,10}})));
  ObjectStab.Network.Bus bus11 annotation (Placement(transformation(extent={{110,-10},
            {130,10}})));
  ObjectStab.Network.Pilink L1011(
    R=0.0001*25,
    X=0.001*25,
    B=0.00175*25) annotation (Placement(transformation(extent={{90,-10},{
            110,10}})));
  ObjectStab.Network.Bus bus10 annotation (Placement(transformation(extent={{70,-10},
            {90,10}})));
  ObjectStab.Network.Pilink L910(
    R=0.0001*10,
    X=0.001*10,
    B=0.00175*10) annotation (Placement(transformation(extent={{50,-10},{70,
            10}})));
  ObjectStab.Network.Bus bus9 annotation (Placement(transformation(
        origin={40,0},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  Base.PowerMeasurement sensorP9 annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={40,-40})));
  ObjectStab.Loads.ZIPLoad L9(
    P0=17.67,
    Q0=1,
    pZ=0,
    pI=1,
    qZ=1,
    qI=0) annotation (Placement(transformation(
        origin={40,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.ShuntCapacitor C9(B=3.5) annotation (Placement(
        transformation(
        origin={20,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Bus bus8 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ObjectStab.Network.Pilink L78_2(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{-30,-10},{
            -10,10}})));
  ObjectStab.Network.Pilink L89_2(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{10,-10},{
            30,10}})));
  ObjectStab.Network.Pilink L89_1(
    R=0.0001*110,
    X=0.001*110,
    B=0.00175*110) annotation (Placement(transformation(extent={{10,30},{30,
            50}})));
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
  connect(bus2.T, T26.T1) annotation (Line(
      points={{-120,-30},{-110,-30}},
      color={0,0,255}));
  connect(T26.T2,bus6. T) annotation (Line(
      points={{-90,-30},{-80,-30},{-80,0}},
      color={0,0,255}));
  connect(bus3.T, T311.T2) annotation (Line(
      points={{160,0},{150,0}},
      color={0,0,255}));
  connect(T311.T1,bus11. T) annotation (Line(
      points={{130,0},{120,0}},
      color={0,0,255}));
  connect(bus11.T, L1011.T2) annotation (Line(
      points={{120,0},{110,0}},
      color={0,0,255}));
  connect(L1011.T1,bus10. T) annotation (Line(
      points={{90,0},{80,0}},
      color={0,0,255}));
  connect(bus4.T, T410.T1) annotation (Line(
      points={{120,-30},{110,-30}},
      color={0,0,255}));
  connect(T410.T2,bus10. T) annotation (Line(
      points={{90,-30},{80,-30},{80,0}},
      color={0,0,255}));
  connect(bus6.T, L67.T1) annotation (Line(
      points={{-80,0},{-70,0}},
      color={0,0,255}));
  connect(L67.T2,bus7. T) annotation (Line(
      points={{-50,0},{-40,0}},
      color={0,0,255}));
  connect(bus7.T, L78_2.T1) annotation (Line(
      points={{-40,0},{-30,0}},
      color={0,0,255}));
  connect(L78_2.T2,bus8. T) annotation (Line(
      points={{-10,0},{0,0}},
      color={0,0,255}));
  connect(bus10.T, L910.T2) annotation (Line(
      points={{80,0},{70,0}},
      color={0,0,255}));
  connect(L910.T1,bus9. T) annotation (Line(
      points={{50,0},{40,0}},
      color={0,0,255}));
  connect(bus9.T, L89_2.T2) annotation (Line(
      points={{40,0},{30,0}},
      color={0,0,255}));
  connect(L89_2.T1,bus8. T) annotation (Line(
      points={{10,0},{0,0}},
      color={0,0,255}));
  connect(bus9.T, L89_1.T2) annotation (Line(
      points={{40,0},{40,40},{30,40}},
      color={0,0,255}));
  connect(L89_1.T1,bus8. T) annotation (Line(
      points={{10,40},{0,40},{0,0}},
      color={0,0,255}));
  connect(bus7.T, C7.T) annotation (Line(
      points={{-40,0},{-40,-20},{-20,-20},{-20,-60}},
      color={0,0,255}));
  connect(bus9.T, C9.T) annotation (Line(
      points={{40,0},{40,-20},{20,-20},{20,-60}},
      color={0,0,255}));
  connect(bus7.T, sensorP7.T1) annotation (Line(
      points={{-40,0},{-40,-30}},
      color={0,0,255}));
  connect(sensorP7.T2, L7.T) annotation (Line(
      points={{-40,-50},{-40,-60}},
      color={0,0,255}));
  connect(bus9.T, sensorP9.T1) annotation (Line(
      points={{40,0},{40,-30}},
      color={0,0,255}));
  connect(sensorP9.T2, L9.T) annotation (Line(
      points={{40,-50},{40,-60}},
      color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-200,-100},{200,100}},
        grid={2,2}), graphics={Line(points={{156,0},{156,0}}),     Line(
            points={{86,-40},{86,-40}})}));
end Net;
