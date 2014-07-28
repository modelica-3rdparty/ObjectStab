within ObjectStab.Loads;
model ZIPLoad "Impedance Load"
  extends Partials.Load;
  parameter Real pZ=0.33;
  parameter Real pI=0.33;
  parameter Real pP=(1 - pZ - pI);
  parameter Real qZ=0.33;
  parameter Real qI=0.33;
  parameter Real qP=(1 - qZ - qI);

equation
  Pl = P0*(pZ*(V/V0)^2 + pI*(V/V0) + pP);
  Ql = Q0*(qZ*(V/V0)^2 + qI*(V/V0) + qP);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-40,-60},{40,-20}}, textString=
                                                 "ZIP")}));
end ZIPLoad;
