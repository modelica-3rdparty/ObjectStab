within ObjectStab.Base;
connector Pin "Electrical connector for ObjectStab models"
  Base.Voltage va;
  Base.Voltage vb;
  flow Base.Current ia;
  flow Base.Current ib;

  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-10,30},{30,-10}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-20,20},{20,-20}},
          lineColor={0,0,255},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid)}),
    Documentation(info="The electrical connectors of ObjectStab models are modelled by the voltages and
currents in phasor representation:

I =   ia + j ib
V = 1+va + j vb

The constant one has been introduced in order to help the initial value solver.
Two connected Pins results in the following equations:

Pin1.va = Pin2.va
Pin1.vb = Pin2.vb
Pin1.ia + Pin2.ia = 0
Pin1.ib + Pin2.ib = 0

By definition, currents are considered positive when injected into a component.
"));
end Pin;
