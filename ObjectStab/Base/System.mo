within ObjectStab.Base;
model System "Shell model for connected systems"
  parameter AngularVelocity wmin=0.5;
  parameter AngularVelocity wmax=1.5;

  inner AngularVelocity wref(start=1);
protected
  inner wRefContainer wrcon annotation (Placement(transformation(extent={{
            -120,100},{-100,120}})));
equation
  wref = wrcon.wr.Hwsum/(wrcon.wr.Hsum);

  when (wref < wmin) or (wref > wmax) then
    terminate(
      "Simulation terminated since reference freqeuency is unreasonable !! (as decided by parameters wmin and wmax)");
  end when;

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Text(
          extent={{0,132},{0,73}},
          lineColor={255,0,0},
          textString=
               "%name"),
        Rectangle(
          extent={{-100,-100},{80,50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{-100,50},{-80,70},{100,70},{80,50},{-100,50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{100,70},{100,-80},{80,-100},{80,50},{100,70}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(extent={{-83,-6},{71,-54}}, textString=
                                             "ObjectStab")}),
    Documentation(info="This model defines global variables necessary for the system frequency reference.
The reference is computed using the center-of-inertia method.
"));
end System;
