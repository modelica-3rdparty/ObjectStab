within ObjectStab.Examples.Nordic32.Models;
model Limiter
  extends SI4SO;

  parameter Real Limitf=3.74;
  parameter Real Tdf=20;
  parameter Real Taf=120e6;
  parameter Real Kf=20;
  parameter Real Limits=1.05;
  parameter Real Tds=20;
  parameter Real Tas=120e6;
  parameter Real Ks=2;

  ObjectStab.Base.Time counterf(start=1e6, fixed=true);
  ObjectStab.Base.Time counters(start=1e6, fixed=true);
protected
  Real fcorr(start=1e3);
  Real scorr(start=1e3);

public
  ModelicaAdditions.PetriNets.Transition Tr1f annotation (Placement(
        transformation(
        origin={-50,22},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place12 countf annotation (Placement(
        transformation(
        origin={-50,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr2f annotation (Placement(
        transformation(
        origin={-70,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place21 waitf(initialState=true)
    annotation (Placement(transformation(
        origin={-50,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place11 activatef annotation (Placement(
        transformation(
        origin={-70,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr3f annotation (Placement(
        transformation(
        origin={-90,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr4f annotation (Placement(
        transformation(
        origin={-10,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr1s annotation (Placement(
        transformation(
        origin={54,22},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place12 counts annotation (Placement(
        transformation(
        origin={54,-10},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr2s annotation (Placement(
        transformation(
        origin={34,-40},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place21 waits(initialState=true)
    annotation (Placement(transformation(
        origin={54,50},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Place11 activates annotation (Placement(
        transformation(
        origin={34,-70},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ModelicaAdditions.PetriNets.Transition Tr3s annotation (Placement(
        transformation(
        origin={14,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
  ModelicaAdditions.PetriNets.Transition Tr4s annotation (Placement(
        transformation(
        origin={94,-10},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  connect(countf.inTransition, Tr1f.outTransition) annotation (Line(
        points={{-50,2},{-50,17}}));
  connect(Tr1f.inTransition, waitf.outTransition) annotation (Line(points=
         {{-50.05,28.05},{-50,39}}));
  connect(Tr2f.inTransition, countf.outTransition1) annotation (Line(
        points={{-70.05,-33.95},{-70,-26},{-56,-26},{-56,-21}}));
  connect(activatef.inTransition, Tr2f.outTransition) annotation (Line(
        points={{-70,-58},{-70,-45}}));
  connect(activatef.outTransition, Tr3f.inTransition) annotation (Line(
        points={{-70,-81},{-70,-92},{-90,-92},{-89.95,-16.05}}));
  connect(Tr3f.outTransition, waitf.inTransition1) annotation (Line(
        points={{-90,-5},{-90,72},{-56,72},{-56,62}}));
  connect(Tr4f.inTransition, countf.outTransition2) annotation (Line(
        points={{-9.95,-16.05},{-10,-30},{-44,-30},{-44,-21.1}}));
  connect(Tr4f.outTransition, waitf.inTransition2) annotation (Line(
        points={{-10,-5},{-10,72},{-44,72},{-44,62}}));
  connect(counts.inTransition, Tr1s.outTransition) annotation (Line(
        points={{54,2},{54,17}}));
  connect(Tr1s.inTransition, waits.outTransition) annotation (Line(points=
         {{53.95,28.05},{54,39}}));
  connect(Tr2s.inTransition, counts.outTransition1) annotation (Line(
        points={{33.95,-33.95},{34,-26},{48,-26},{48,-21}}));
  connect(activates.inTransition, Tr2s.outTransition) annotation (Line(
        points={{34,-58},{34,-45}}));
  connect(activates.outTransition, Tr3s.inTransition) annotation (Line(
        points={{34,-81},{34,-92},{14,-92},{14.05,-16.05}}));
  connect(Tr3s.outTransition, waits.inTransition1) annotation (Line(
        points={{14,-5},{14,72},{48,72},{48,62}}));
  connect(Tr4s.inTransition, counts.outTransition2) annotation (Line(
        points={{94.05,-16.05},{94,-30},{60,-30},{60,-21.1}}));
  connect(Tr4s.outTransition, waits.inTransition2) annotation (Line(
        points={{94,-5},{94,72},{60,72},{60,62}}));
  // field current limiter
  Tr1f.condition = u1 > Limitf;
  Tr2f.condition = (time - counterf) > Tdf;
  Tr3f.condition = (time - counterf) > Taf and (u1 < Limitf);
  Tr4f.condition = (u1 < Limitf);

  when countf.state then
    counterf = time;
  end when;

  fcorr = if (u4 > 0) and (activatef.state) then Kf*(Limitf - u1) else
    1e3;

  // stator current limiter
  Tr1s.condition = u2 > Limits;
  Tr2s.condition = (time - counters) > Tds;
  Tr3s.condition = (time - counters) > Tas and (u2 < Limits);
  Tr4s.condition = (u2 < Limits);

  when counts.state then
    counters = time;
  end when;

  scorr = if (u4 > 0) and (activates.state) then Ks*(Limits - u2) else
    1e3;

  // output equation
  y = noEvent(min(scorr, min(fcorr, u3)));

initial equation
  waitf.state = true;
  countf.state = false;
  activatef.state = false;
  waits.state = true;
  counts.state = false;
  activates.state = false;
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-84,94},{-18,76}},
            textString=                            "Field Limiter Logic"), Text(
            extent={{18,96},{84,78}}, textString=
                                               "Stator Limiter Logic")}));
end Limiter;
