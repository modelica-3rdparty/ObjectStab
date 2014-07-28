within ObjectStab.Base;
partial model TwoPin
  "Shell model for ObjectStab models with two electrical connectors "

  ObjectStab.Base.Pin T1 annotation (Placement(transformation(extent={{-110,
            -10},{-90,10}})));
  ObjectStab.Base.Pin T2 annotation (Placement(transformation(extent={{90,-10},
            {110,10}})));
end TwoPin;
