within ObjectStab.Network;
model IdealTransformer
  extends ObjectStab.Base.TwoPin;
  parameter Real eps=1e-6 "samll number, replacing '1' in Mat's equations";
  ObjectStab.Base.TapRatio n(start=1);
  Modelica.Blocks.Interfaces.RealInput inPort annotation (Placement(
        transformation(
        origin={0,-80},
        extent={{-10,-10},{10,10}},
        rotation=90)));
equation
  (1 + T1.va)*n = 1 + T2.va;
  T1.vb*n = T2.vb;
  T1.ia = -T2.ia*n;
  T1.ib = -T2.ib*n;
  n =inPort;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(extent={{-70,40},{12,-40}}, lineColor={0,0,0}),
        Ellipse(extent={{-12,40},{70,-40}}, lineColor={0,0,0}),
        Line(points={{70,0},{100,0}}, color={0,0,0}),
        Line(points={{-100,0},{-70,0}}, color={0,0,0}),
        Text(extent={{-60,80},{60,40}}, textString=
                                            "%name"),
        Text(extent={{-10,-78},{-50,-38}}, textString=
                                               "1"),
        Text(extent={{20,-76},{-20,-36}}, textString=
                                              ":"),
        Text(extent={{50,-76},{10,-36}}, textString=
                                             "n")}));
end IdealTransformer;
