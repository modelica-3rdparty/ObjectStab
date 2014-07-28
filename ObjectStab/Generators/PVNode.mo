within ObjectStab.Generators;
model PVNode "PV Node"
  extends ObjectStab.Generators.Partials.InfiniteBus(isSlack=false);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-40,-20},{80,20}}, textString=
                                             "PV"),
        Text(extent={{-60,100},{100,60}}, textString=
                                              "V=%V0, Pg=%Pg0"),
        Text(extent={{-60,-60},{100,-100}}, textString=
                                                "%name")}),
    Documentation(info="The PV node models a load-flow PV node with unlimited reactive
power generation resources.

"));
end PVNode;
