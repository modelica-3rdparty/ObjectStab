within ObjectStab.Extras;
model UFLSLoad

  extends ObjectStab.Loads.Partials.Load;

  parameter Real a=1;
  parameter Real b=1;
  parameter Real c=1;
  parameter Real d=1;

  Real k;
  outer Real wref;

  ShedRelay Relay1(
    DelayTime=0.1,
    ShedAmount=0.1,
    Threshold=0.96)
                   annotation (Placement(transformation(extent={{-56.6667,10},
            {-10,56.6667}})));
  ShedRelay Relay2(
    DelayTime=0.1,
    ShedAmount=0.1,
    Threshold=0.956)
                    annotation (Placement(transformation(extent={{10,10},{
            56.6667,56.6667}})));
  ShedRelay Relay3(
    DelayTime=0.1,
    ShedAmount=0.1,
    Threshold=0.952)
                    annotation (Placement(transformation(extent={{-56.6667,
            -56.6667},{-10,-10}})));
equation
  Pl = (1 - k)*P0*(1 + (V - V0)*a + c*(wref - 1));
  Ql = (1 - k)*Q0*(1 + (V - V0)*b + d*(wref - 1));

  Relay1.u = wref;
  Relay2.u = wref;
  Relay3.u = wref;
  k = Relay1.y + Relay2.y + Relay3.y;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-100,100},{100,60}}, textString=
                                                  "UFLS")}));
end UFLSLoad;
