within ObjectStab.Network.Controllers;
model TCULDiscrete "Discrete implementation of TCUL control system"
  extends TCULController;

  ObjectStab.Base.Time up_counter(start=-10, fixed=true);
  ObjectStab.Base.Time down_counter(start=-10, fixed=true);
  ObjectStab.Base.Time Td;
  ObjectStab.Base.Time Tm;

  ObjectStab.Network.Partials.Place32 wait(initialState=true) annotation (Placement(
        transformation(
        origin={0,70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr1(condLabel="Verr<-DB/2")
    annotation (Placement(transformation(
        origin={-50,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr2(condLabel="Verr>-DB/2")
    annotation (Placement(transformation(
        origin={-90,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Place12 countup annotation (Placement(
        transformation(
        origin={-50,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr3(condLabel="Timer>Td")
    annotation (Placement(transformation(
        origin={-70,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place11 actionup annotation (Placement(
        transformation(
        origin={-70,-76},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr4(condLabel="Timer>Td+Tm")
    annotation (Placement(transformation(
        origin={-30,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr6(condLabel="Verr>DB/2")
    annotation (Placement(transformation(
        origin={50,30},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr7(condLabel="Verr<DB/2")
    annotation (Placement(transformation(
        origin={90,30},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Place12 countdown annotation (Placement(
        transformation(
        origin={50,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr8(condLabel="Timer>Td")
    annotation (Placement(transformation(
        origin={30,-50},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr9(condLabel="Timer>Td")
    annotation (Placement(transformation(
        origin={70,-50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place11 actiondown annotation (Placement(
        transformation(
        origin={70,-74},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place21 updatetap annotation (Placement(
        transformation(
        origin={0,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr5(condLabel="") annotation (Placement(
        transformation(
        origin={0,24},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(Tr1.outTransition, countup.inTransition) annotation (Line(points=
          {{-50,25},{-50,2}}));
  connect(countup.outTransition1, Tr2.inTransition) annotation (Line(points=
         {{-56,-21},{-56,-28},{-90,-28},{-89.95,23.95}}));
  connect(countdown.inTransition, Tr6.outTransition) annotation (Line(
        points={{50,2},{50,25}}));
  connect(countdown.outTransition2, Tr7.inTransition) annotation (Line(
        points={{56,-21.1},{56,-30},{90,-30},{90.05,23.95}}));
  connect(actionup.inTransition, Tr3.outTransition) annotation (Line(points=
         {{-70,-64},{-70,-55}}));
  connect(actiondown.inTransition, Tr9.outTransition) annotation (Line(
        points={{70,-62},{70,-55}}));
  connect(Tr8.inTransition, actiondown.outTransition) annotation (Line(
        points={{30.05,-56.05},{30.05,-96},{70,-96},{70,-85}}));
  connect(Tr3.inTransition, countup.outTransition2) annotation (Line(points=
         {{-70.05,-43.95},{-70,-36},{-44,-36},{-44,-21.1}}));
  connect(actionup.outTransition, Tr4.inTransition) annotation (Line(points=
         {{-70,-87},{-70,-96},{-30,-96},{-29.95,-56.05}}));
  connect(updatetap.inTransition2, Tr4.outTransition) annotation (Line(
        points={{-6,-22},{-6,-36},{-30,-36},{-30,-45}}));
  connect(updatetap.inTransition1, Tr8.outTransition) annotation (Line(
        points={{6,-22},{6,-34},{30,-34},{30,-45}}));
  connect(Tr5.inTransition, updatetap.outTransition) annotation (Line(
        points={{0.05,17.95},{6.73533e-016,1}}));
  connect(Tr2.outTransition, wait.inTransition1) annotation (Line(points={{
          -90,35},{-90,92},{-6,92},{-6,82}}));
  connect(Tr1.inTransition, wait.outTransition1) annotation (Line(points={{
          -50.05,36.05},{-50,48},{-6,48},{-6,59}}));
  connect(wait.outTransition2, Tr6.inTransition) annotation (Line(points={{
          6,59},{6,48},{50,48},{49.95,36.05}}));
  connect(Tr7.outTransition, wait.inTransition2) annotation (Line(points={{
          90,35},{90,92},{6,92},{6,82}}));
  connect(Tr5.outTransition, wait.inTransition3) annotation (Line(points={{
          3.06152e-016,29},{-2.20429e-015,58}}));
  connect(Tr9.inTransition, countdown.outTransition1) annotation (Line(
        points={{69.95,-43.95},{70,-36},{44,-36},{44,-21}}));
  if (method == 1) then
    Td = Td0;
    Tm = Tm0;
  elseif (method == 2) then
    Td = Td0*DB/2/noEvent(max(abs(udev), 1e-6));
    Tm = Tm0;
  elseif (method == 3) then
    Td = Td0*DB/2/noEvent(max(abs(udev), 1e-6));
    Tm = Tm0*DB/2/noEvent(max(abs(udev), 1e-6));
  else
    Td = Td1 + Td0*DB/2/noEvent(max(abs(udev), 1e-6));
    Tm = Tm0;
  end if;

    //  Td = if (method == 1) then Td0 else if (method == 2 or method == 3) then Td0*
  //    DB/2/abs(udev + 1e-6) else Td1 + Td0*DB/2/abs(1e-6 + udev);
  //  Tm = if method == 3 then Tm0*DB/2/abs(1e-6 + udev) else Tm0;

  Tr1.condition = (udev < -DB/2) and (tappos < maxtap) and not blocked;
  Tr2.condition = not ((udev < -DB/2) and (tappos < maxtap)) or blocked;
  Tr3.condition = time - up_counter > Td;
  Tr4.condition = time - up_counter > Td + Tm;
  Tr5.condition = not (abs(tappos - pre(tappos)) > stepsize/10);
  Tr6.condition = ((udev > DB/2) and (tappos > mintap));
  Tr7.condition = not ((udev > DB/2) and (tappos > mintap));
  Tr8.condition = time - down_counter > Td + Tm;
  Tr9.condition = time - down_counter > Td;

  when countup.state then
    up_counter = time;
  end when;

  when countdown.state then
    down_counter = time;
  end when;

  when updatetap.state then
    if (up_counter > down_counter) then
      tappos = pre(tappos) + 1;
    else
      tappos = pre(tappos) - 1;
    end if;
  end when;
initial equation
  if InitByVoltage then
    udev = 0;
  else
    tappos = (n - 1)/stepsize;
  end if;
  wait.state = true;
  countup.state = false;
  countdown.state = false;
  actionup.state = false;
  actiondown.state = false;
  updatetap.state = false;
  annotation (
    Documentation(info="Discrete implementation of Tap-Changing Under Load (TCUL) control system
according to method D1-D4 in [1] using a state-machine implementation of the
control system and tap changer mechanism.

Ideally the variable 'tappos' should be initialized to give a voltage deviation
within the deadband at the start of the simulatation. Failure to do so may result in
convergence problems with the initial value solver.

---
[1] P.W. Sauer and M.A. Pai, \"A comparison of discrete vs. continuous
dynamic models of tap-changing-under-load transformers\", in Proceedings
of NSF/ECC Workshop on Bulk power System Voltage Phenomena - III :
Voltage Stability, Security and Control,  Davos, Switzerland, 1994.
"));
end TCULDiscrete;
