within ObjectStab.Network;
model FaultedBus "Busbar model with shunt fault"
  extends ObjectStab.Base.OnePinCenter;
  Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb) "Voltage Amplitude";
  ObjectStab.Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, T.va)
    "Voltage Angle";
  Real thetadeg=theta*180/Modelica.Constants.pi;
  parameter ObjectStab.Base.Time FaultTime=10 "Time of fault occurence";
  parameter ObjectStab.Base.Duration FaultDuration=1 "Duration of fault";
  parameter ObjectStab.Base.Resistance FaultR=0.1 "Fault Resistance";
  parameter ObjectStab.Base.Reactance FaultX=0 "Fault Reactance";
  ObjectStab.Base.Current iFault "Fault Current";

  ObjectStab.Network.Impedance Imp(R=FaultR, X=FaultX) annotation (Placement(
        transformation(
        origin={-60,-30},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ObjectStab.Network.Ground G annotation (Placement(transformation(
        origin={-60,-80},
        extent={{-20,-20},{20,20}},
        rotation=270)));
  ObjectStab.Network.Breaker B1(OpenTime=FaultTime + FaultDuration, CloseTime=
       FaultTime) annotation (Placement(transformation(extent={{-60,-20},{-20,
            20}})));
equation
  connect(Imp.T1, G.T) annotation (Line(points={{-60,-50},{-60,-60}}));
  connect(Imp.T2, B1.T1) annotation (Line(points={{-60,-10},{-60,0}}));
  connect(B1.T2, T) annotation (Line(points={{-20,0},{0,0}}));
  iFault = sqrt(G.T.ia^2 + G.T.ib^2);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Rectangle(
          extent={{-12,72},{10,-72}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-20,100},{20,80}}, textString=
                                             "%name"),
        Polygon(
          points={{24,76},{-30,-8},{38,12},{-4,-54},{70,38},{-10,2},{24,76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Polygon(
          points={{4,64},{-50,-20},{20,2},{-24,-66},{50,26},{-30,-10},{4,64}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Text(extent={{-20,-80},{20,-100}}, textString=
                                               "Bus Fault")}),
    Documentation(info="The shunt fault is modelled as an impedance connected to ground through
a breaker. The fault is applied at simulation time FaultTime and stays
active for the duration of FaultDuration.

For numerical reasons, the fault impedance must not be exactly equal
to zero.
"), Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-54,-18},{-10,-46}}, textString=
                                                     "FaultR+jFaultX")}));
end FaultedBus;
