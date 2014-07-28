within ObjectStab.Network;
model Pilink2 "Pilink transmission line model built using Basic Components"
  extends Partials.PilinkBase;

  ObjectStab.Network.Impedance Imp(R=R, X=X) annotation (Placement(
        transformation(extent={{-20,-20},{20,20}})));
  ObjectStab.Network.Admittance T2Adm(G=G/2, B=B/2) annotation (Placement(
        transformation(
        origin={60,-40},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ObjectStab.Network.Admittance T1Adm(G=G/2, B=B/2) annotation (Placement(
        transformation(
        origin={-60,-42},
        extent={{-20,-20},{20,20}},
        rotation=90)));
  ObjectStab.Network.Ground GT1 annotation (Placement(transformation(
        origin={-60,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
  ObjectStab.Network.Ground GT2 annotation (Placement(transformation(
        origin={60,-80},
        extent={{-10,-10},{10,10}},
        rotation=270)));
equation
  connect(T2Adm.T1, GT2.T) annotation (Line(points={{60,-60},{60,-70}}));
  connect(GT1.T, T1Adm.T1) annotation (Line(points={{-60,-70},{-60,-62}}));
  connect(T2, Imp.T2) annotation (Line(points={{100,0},{20,0}}));
  connect(T2Adm.T2, T2) annotation (Line(points={{60,-20},{60,0},{100,0}}));
  connect(T1, Imp.T1) annotation (Line(points={{-100,0},{-20,0}}));
  connect(T1Adm.T2, T1) annotation (Line(points={{-60,-22},{-60,0},{-100,0}}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-16,28},{16,14}}, textString=
                                            "R+jX"),
        Text(extent={{-52,-34},{-20,-48}}, textString=
                                               "(G+jB)/2"),
        Text(extent={{12,-34},{44,-48}}, textString=
                                             "(G+jB)/2")}),
    Documentation(info="Transmission line modelled in pi-equivalent form according to [1,pp. 44-45]
realized using the Impedance and Admittance submodels.

For numerical reasons, the R+jX must not be set equal to zero.

---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics
and Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
end Pilink2;
