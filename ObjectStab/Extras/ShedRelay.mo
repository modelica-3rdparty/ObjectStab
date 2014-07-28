within ObjectStab.Extras;
model ShedRelay
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real Threshold=0.95;
  parameter Real DelayTime=1;

  parameter Real ShedAmount=0.05;
  ObjectStab.Base.Time timerstart(start=-1, fixed=true);

  ModelicaAdditions.PetriNets.Transition T1 annotation (Placement(
        transformation(extent={{-30,40},{-10,60}})));
  ModelicaAdditions.PetriNets.Transition T2 annotation (Placement(
        transformation(
        origin={-20,-14},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ModelicaAdditions.PetriNets.Place12 delay annotation (Placement(
        transformation(extent={{0,40},{20,60}})));
  ModelicaAdditions.PetriNets.Transition T3 annotation (Placement(
        transformation(
        origin={-20,20},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ModelicaAdditions.PetriNets.Place21 wait(initialState=true) annotation (Placement(
        transformation(extent={{-60,40},{-40,60}})));
equation
  connect(delay.inTransition, T1.outTransition) annotation (Line(points={{-2,
          50},{-15,50}}));
  connect(T3.inTransition, delay.outTransition1) annotation (Line(points={{
          -13.95,20.05},{30,20},{30,44},{21,44}}));
  connect(delay.outTransition2, T2.inTransition) annotation (Line(points={{
          21.1,56},{46,56},{46,-14},{-13.95,-13.95}}));
  connect(T1.inTransition, wait.outTransition) annotation (Line(points={{
          -26.05,49.95},{-39,50}}));
  connect(T2.outTransition, wait.inTransition2) annotation (Line(points={{-25,
          -14},{-72,-14},{-72,56},{-62,56}}));
  connect(T3.outTransition, wait.inTransition1) annotation (Line(points={{-25,20},
          {-68,20},{-68,44},{-62,44}}));
  T1.condition = (u < Threshold) and (y < ShedAmount/10);
  T2.condition = (u > Threshold);
  T3.condition = time > timerstart + DelayTime;

  when delay.state then
    timerstart = time;
  end when;

  when T3.condition and delay.state then
    y = ShedAmount;
  end when;
initial equation
  wait.state = true;
  delay.state = true;
  y = 0;
end ShedRelay;
