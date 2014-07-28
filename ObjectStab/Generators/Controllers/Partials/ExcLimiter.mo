within ObjectStab.Generators.Controllers.Partials;
model ExcLimiter "Limiter Logic For Excitation System"
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real DelayTime=10;
  parameter Real Limit=2.1;

  discrete Real countstart(start=1e6, fixed=true);
  //  Integer status1;
  //  Integer status2;
  ModelicaAdditions.PetriNets.Transition LimitExc annotation (Placement(
        transformation(extent={{-30,20},{-10,40}})));
  ModelicaAdditions.PetriNets.Transition LimitOK annotation (Placement(
        transformation(
        origin={-20,-10},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ModelicaAdditions.PetriNets.Transition TimerExp annotation (Placement(
        transformation(extent={{30,20},{50,40}})));
  ModelicaAdditions.PetriNets.Place11 activated annotation (Placement(
        transformation(extent={{60,20},{80,40}})));
  ModelicaAdditions.PetriNets.Transition UnActivate annotation (Placement(
        transformation(
        origin={50,-30},
        extent={{-10,-10},{10,10}},
        rotation=180)));
  ModelicaAdditions.PetriNets.Place21 wait(initialState=true) annotation (Placement(
        transformation(extent={{-60,20},{-40,40}})));
  ModelicaAdditions.PetriNets.Place12 count annotation (Placement(
        transformation(extent={{-2,20},{18,40}})));

initial equation
  count.state = false;
  wait.state = true;
  activated.state = false;

equation
  connect(LimitExc.inTransition, wait.outTransition) annotation (Line(
        points={{-26.05,29.95},{-33.025,29.95},{-33.025,30},{-39,30}},
        color={255,0,0}));
  connect(LimitExc.outTransition, count.inTransition) annotation (Line(
        points={{-15,30},{-4,30}}, color={255,0,0}));
  connect(TimerExp.outTransition, activated.inTransition) annotation (Line(
        points={{45,30},{58,30}}, color={255,0,0}));
  connect(count.outTransition1, LimitOK.inTransition) annotation (Line(
        points={{19,24},{28,24},{28,-9.95},{-13.95,-9.95}}, color={255,0,
          0}));
  connect(activated.outTransition, UnActivate.inTransition) annotation (Line(
        points={{81,30},{86,30},{86,-29.95},{56.05,-29.95}}, color={255,0,
          0}));
  connect(UnActivate.outTransition, wait.inTransition2) annotation (Line(
        points={{45,-30},{-76,-30},{-76,36},{-62,36}}, color={255,0,0}));
  connect(LimitOK.outTransition, wait.inTransition1) annotation (Line(
        points={{-25,-10},{-67,-10},{-67,24},{-62,24}}, color={255,0,0}));
  connect(count.outTransition2, TimerExp.inTransition) annotation (Line(
        points={{19.1,36},{26,36},{26,29.95},{33.95,29.95}}, color={255,0,
          0}));
  LimitExc.condition = y > Limit;
  LimitOK.condition = y < (Limit - 1e-5);
  UnActivate.condition = y < (Limit - 1e-5);
  TimerExp.condition = ((time - countstart) > DelayTime) and (y > Limit);

  when count.state then
    countstart = time;
    //   status1 = LogVariable(count.state);
  end when;
  when activated.state then
    //  status2 = LogVariable(activated.state);
  end when;

  y = if activated.state then min(u, Limit) else u;

end ExcLimiter;
