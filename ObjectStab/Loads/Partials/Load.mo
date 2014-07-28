within ObjectStab.Loads.Partials;
partial model Load "Shell model for loads"
  extends Base.OnePin;

  parameter Base.ActivePower P0=1 "Initial Active Load Power";
  parameter Base.ReactivePower Q0=0.2 "Initial Reactive Load Power";
  Base.ActivePower Pl "Active Load Power";
  Base.ReactivePower Ql "Reactive Load Power";
  Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb) "Voltage Amplitude";
  Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va)) "Voltage Angle";
protected
  parameter Base.Voltage V0(fixed=false, start=1)
    "Inital Terminal Voltage (automatically initialized)";

initial equation
  V0 = V;

equation
  T.ia = (Pl*(1 + T.va) + Ql*T.vb)/((1 + T.va)*(1 + T.va) + T.vb*T.vb);
  T.ib = (-Ql*(1 + T.va) + Pl*T.vb)/((1 + T.va)*(1 + T.va) + T.vb*T.vb);

  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Line(points={{-100,0},{-20,0}}, color={0,0,0}),
        Polygon(
          points={{40,-2},{-20,18},{-20,-22},{40,-2}},
          lineColor={0,0,0},
          fillPattern=FillPattern.Sphere,
          fillColor={0,0,0}),
        Text(extent={{-100,60},{100,20}}, textString=
                                              "%P0 + j %Q0")}),
    Documentation(info="The complex power a load draws from the network is given by:

S = P+jQ = v * conj(i)

The parameters P0 and Q0 denote the rated load power, i.e., the power
the load draws if the voltage is 1 p.u.
"));
end Load;
