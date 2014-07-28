within ObjectStab.Loads;
model PQLoad "Constant power (PQ) Load"
  extends Partials.Load;
equation
  Pl = P0;
  Ql = Q0;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-40,-60},{42,-20}}, textString=
                                                 "PQ")}),
    Documentation(info="For a constant power the actual load powers drawn from the network
are given by:

  Pl = P0
  Ql = Q0
"));
end PQLoad;
