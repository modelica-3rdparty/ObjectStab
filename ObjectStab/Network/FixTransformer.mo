within ObjectStab.Network;
model FixTransformer "Fixed Ratio Transformer"
  extends Partials.ImpTransformer;
  parameter ObjectStab.Base.TapRatio n=1 "Transformer Ratio";
equation
  Tr.n = n;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{0,40},{-40,80}}, textString=
                                           "1"),
        Text(extent={{20,40},{-20,80}}, textString=
                                            ":"),
        Text(extent={{40,40},{0,80}}, textString=
                                          "n")}));
end FixTransformer;
