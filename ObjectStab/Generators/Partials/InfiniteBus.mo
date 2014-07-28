within ObjectStab.Generators.Partials;
model InfiniteBus "Infinite Bus Model"
  extends Generator;
equation
  if online then
    if not isSlack then
      V = V0;
      Pg = Pg0;
    else
      1 + T.va = V0*cos(theta0);
      T.vb = V0*sin(theta0);
    end if;
  else
    T.ia = 0;
    T.ib = 0;
  end if;
  // contribute to angle reference calculation
  wrl.wr.Hwsum = if online then Modelica.Constants.inf else 0;
  wrl.wr.Hsum = if online then Modelica.Constants.inf else 0;
  annotation (
    Documentation(info="The variables Pg and Qg corresponds to the actual active and reactive power
delivered to the network referred at the system base.
"));
end InfiniteBus;
