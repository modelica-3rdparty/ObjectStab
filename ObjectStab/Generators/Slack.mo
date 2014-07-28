within ObjectStab.Generators;
model Slack "Slack Node"
  extends ObjectStab.Generators.Partials.InfiniteBus(isSlack=true);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-40,-20},{80,20}}, textString=
                                                "Slack"), Text(extent={{-60,
              100},{100,60}}, textString=
                                  "V=%V0,th=%theta0%")}),
    Documentation(info="The slack node model acts as slack bus in initialization or load-flow
calculations and as an infinite bus during dynamic simulation.


At least one slack node or detailed generator with its attribute 'isSlack' set to true must be included
in each network model.
"));
end Slack;
