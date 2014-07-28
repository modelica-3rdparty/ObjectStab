within ObjectStab.Base;
connector wRefPin
  flow Real Hwsum(start=1);
  flow Base.InertiaConstant Hsum(start=1);
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-20,22},{20,-20}},
          lineColor={255,255,255},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid)}));
end wRefPin;
