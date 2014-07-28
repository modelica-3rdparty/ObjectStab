within ObjectStab.Network;
model ShuntReactor "Shunt Reactor"
  extends ObjectStab.Base.OnePin;

  parameter ObjectStab.Base.Conductance G=0;
  parameter ObjectStab.Base.Susceptance B=-0.5;
  ObjectStab.Base.ActivePower Pg "Generated Active Power";
  ObjectStab.Base.ReactivePower Qg "Generated Reactive Power";

equation
  [T.ia; T.ib] = [G, -B; B, G]*[1 + T.va; T.vb];
  Pg = -((1 + T.va)*T.ia + T.vb*T.ib);
  Qg = -(T.vb*T.ia - (1 + T.va)*T.ib);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-50,0}}, color={0,0,0}),
        Text(extent={{32,46},{-48,86}}, textString=
                                            "%name"),
        Line(points={{-50,0},{-40,20},{-20,-20},{0,20},{18,-20},{30,0}},
            color={0,0,0}),
        Text(extent={{-40,-20},{20,-60}}, textString=
                                              "j%B")}));
end ShuntReactor;
