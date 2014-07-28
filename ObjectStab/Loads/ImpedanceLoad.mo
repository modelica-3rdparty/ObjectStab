within ObjectStab.Loads;
model ImpedanceLoad "Impedance Load"
  extends Partials.Load;
equation
  Pl = P0*(V/V0)^2;
  Ql = Q0*(V/V0)^2;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-40,-60},{40,-20}}, textString=
                                                 "Zload")}),
    Documentation(info="R = P*V^2/(Q^2+P^2)
X = Q*V^2/(Q^2+P^2)

"));
end ImpedanceLoad;
