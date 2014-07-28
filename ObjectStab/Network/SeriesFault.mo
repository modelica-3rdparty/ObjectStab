within ObjectStab.Network;
model SeriesFault "Series Fault model"
  extends ObjectStab.Base.TwoPin;
  parameter ObjectStab.Base.Time FaultTime=1 "Opening time";
  parameter ObjectStab.Base.Duration FaultDuration=1 "Duration of Fault";

  ObjectStab.Network.Breaker B1(OpenTime=FaultTime, CloseTime=FaultTime +
        FaultDuration) annotation (Placement(transformation(extent={{-20,-20},
            {20,20}})));

equation
  connect(T1, B1.T1) annotation (Line(points={{-100,0},{-20,0}}));
  connect(B1.T2, T2) annotation (Line(points={{20,0},{100,0}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Polygon(
          points={{4,64},{-50,-20},{20,2},{-24,-66},{50,26},{-30,-10},{4,64}},
          lineColor={255,255,0},
          fillColor={255,255,0},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{24,76},{-30,-8},{38,12},{-4,-54},{70,38},{-10,2},{24,76}},
          lineColor={0,0,0},
          fillPattern=FillPattern.HorizontalCylinder,
          fillColor={255,0,0}),
        Line(points={{-98,0},{100,0}})}),
    Documentation(info="The series fault is realized using the ideal breaker model.
The fault becomes active (non-conductive) at time FaultTime
and stays non-conductive for the duration of FaultDuration seconds,
after which the fault is cleared.


"));
end SeriesFault;
