within ObjectStab.Base;
partial model OnePin
  "Shell model for ObjectStab models with one electrical connector "

  ObjectStab.Base.Pin T annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
equation
  //  assert(cardinality(T) > 0, "One Pin not connected");
  annotation (
    Documentation(info=""));
end OnePin;
