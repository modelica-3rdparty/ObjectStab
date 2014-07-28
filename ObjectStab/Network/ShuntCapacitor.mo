within ObjectStab.Network;
model ShuntCapacitor "Shunt Capacitor"
  extends ObjectStab.Base.OnePin;

  parameter ObjectStab.Base.Conductance G=0;
  parameter ObjectStab.Base.Susceptance B=0.5;
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
        Line(points={{-100,0},{-10,0}}, color={0,0,0}),
        Line(points={{-10,40},{-10,-40}}, color={0,0,0}),
        Line(points={{10,40},{10,-40}}, color={0,0,0}),
        Text(extent={{-100,-40},{100,-80}}, textString=
                                                "j%B")}));
end ShuntCapacitor;
