within ObjectStab.Network.Partials;
model Place32 "Place with two input and two output transitions"
  parameter Boolean initialState=false "Initial value of state";
  Boolean state(final start=initialState) "State of place";
protected
  Boolean newState(final start=initialState);
public
  ModelicaAdditions.PetriNets.Interfaces.FirePortOut outTransition1
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  ModelicaAdditions.PetriNets.Interfaces.FirePortOut outTransition2
    annotation (Placement(transformation(extent={{100,70},{120,50}})));
  ModelicaAdditions.PetriNets.Interfaces.SetPortIn inTransition1
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  ModelicaAdditions.PetriNets.Interfaces.SetPortIn inTransition2
    annotation (Placement(transformation(extent={{-140,80},{-100,40}})));
public
  ModelicaAdditions.PetriNets.Interfaces.SetPortIn inTransition3
    annotation (Placement(transformation(
        origin={120,0},
        extent={{-20,20},{20,-20}},
        rotation=180)));
equation
  // Set new state for next iteration
  state = pre(newState);
  newState = inTransition1.set or inTransition2.set or inTransition3.set
     or state and not (outTransition1.fire or outTransition2.fire);

  // Report state to input and output transitions
  inTransition1.state = state;
  inTransition2.state = inTransition1.state or inTransition1.set;
  inTransition3.state = inTransition1.state or inTransition1.set;
  outTransition1.state = state;
  outTransition2.state = outTransition1.state and not outTransition1.fire;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-100,-100},{100,100}},
          lineColor={255,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{-100,60},{-80,60}}, color={255,0,0}),
        Line(points={{-100,-60},{-80,-60}}, color={255,0,0}),
        Line(points={{80,-60},{100,-60}}, color={255,0,0}),
        Line(points={{82,60},{102,60}}, color={255,0,0}),
        Text(extent={{0,99},{0,159}}, textString=
                                          "%name")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-100,-100},{100,100}}, lineColor={255,0,0}),
        Line(points={{-100,60},{-80,60}}, color={255,0,0}),
        Line(points={{-100,-60},{-80,-60}}, color={255,0,0}),
        Line(points={{80,60},{100,60}}, color={255,0,0}),
        Line(points={{80,-60},{100,-60}}, color={255,0,0})}));
end Place32;
