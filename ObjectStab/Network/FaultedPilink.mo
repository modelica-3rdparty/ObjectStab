within ObjectStab.Network;
model FaultedPilink "Pilink with shunt fault model"
  extends Partials.PilinkBase;
  parameter ObjectStab.Base.Time FaultTime=1 "Time of fault occurence [s]";
  parameter ObjectStab.Base.Duration ClearTime=0.07 "Fault Clearing Time [s]";
  parameter ObjectStab.Base.Time RecloseTime=1e60 "Time of Reclosing [s]";
  parameter Real alpha=0.5 "Position of Fault";
  parameter ObjectStab.Base.Resistance FaultR=1e-5 "Fault Resistance";
  parameter ObjectStab.Base.Reactance FaultX=0 "Fault Reactance";

  ObjectStab.Network.Pilink2 L1(
    R=R*alpha,
    X=X*alpha,
    B=B*alpha,
    G=G*alpha) annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  ObjectStab.Network.Pilink2 L2(
    R=R*(1 - alpha),
    X=X*(1 - alpha),
    B=B*(1 - alpha),
    G=G*(1 - alpha)) annotation (Placement(transformation(extent={{40,-10},{
            60,10}})));
  ObjectStab.Network.Breaker B1(OpenTime=FaultTime + ClearTime, CloseTime=
        RecloseTime) annotation (Placement(transformation(extent={{-80,-10},{
            -60,10}})));
  ObjectStab.Network.Breaker B2(OpenTime=FaultTime + ClearTime, CloseTime=
        RecloseTime) annotation (Placement(transformation(extent={{68,-10},{
            88,10}})));
  ObjectStab.Network.Impedance FaultImp(R=FaultR, X=FaultX) annotation (Placement(
        transformation(
        origin={0,-62},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Breaker B3(OpenTime=FaultTime + ClearTime, CloseTime=
        FaultTime) annotation (Placement(transformation(
        origin={0,-30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ObjectStab.Network.Ground Gr annotation (Placement(transformation(
        origin={0,-92},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(B1.T1, T1) annotation (Line(points={{-80,0},{-100,0}}));
  connect(B1.T2, L1.T1) annotation (Line(points={{-60,0},{-50,0}}));
  connect(Gr.T, FaultImp.T1) annotation (Line(points={{1.83691e-015,-82},{
          -6.12303e-016,-72}}));
  connect(FaultImp.T2, B3.T1) annotation (Line(points={{6.12303e-016,-52},{
          -6.12303e-016,-40}}));
  connect(B2.T2, T2) annotation (Line(points={{88,0},{100,0}}));
  connect(B2.T1, L2.T2) annotation (Line(points={{68,0},{60,0}}));

  connect(L1.T2, B3.T2) annotation (Line(points={{-30,0},{6.12303e-016,0},{
          6.12303e-016,-20}}));
  connect(B3.T2, L2.T1) annotation (Line(points={{6.12303e-016,-20},{0,0},{40,
          0}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{8,-48},{44,-72}}, textString=
                                                  "FaultR+jFaultX"), Text(
            extent={{34,28},{66,2}}, textString=
                                         "(R+jX)*alpha")}),
    Documentation(info="The model of the Pilink with a shunt fault is realized using the Pilink
models and the ideal breaker models.

At time FaultTime, the breaker B3 closes and the ground fault becomes active
for the duration of FaultDuration seconds, after which the line is disconnected
at both ends. The ground fault location is determined by alpha, where alpha=0
corresponds to a fault located at T1 and alpha=1 to a fault location at T2.

For numerical reasons the fault and pilink impedance may not be exactly zero,
and alpha not be equal to 0 or 1.


"), Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Polygon(
          points={{24,76},{-30,-8},{38,12},{-4,-54},{70,38},{-10,2},{24,76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}), Polygon(
          points={{4,64},{-50,-20},{20,2},{-24,-66},{50,26},{-30,-10},{4,64}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid)}));
end FaultedPilink;
