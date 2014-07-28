within ObjectStab.Generators.Controllers.Partials;
partial model Exciter
  extends Modelica.Blocks.Interfaces.SISO;
  parameter Real K=100 "Steady-State Gain";
  parameter Base.Voltage Efmax=Modelica.Constants.inf "Maximum Field Voltage";
  parameter Base.Voltage Efmin=0 "Minimum Field Voltage";
  parameter Base.Voltage Vref(fixed=false, start=1);
  parameter Base.Voltage Ef0(fixed=false, start=1);

  Modelica.Blocks.Nonlinear.Limiter Limiter(uMax=Efmax, uMin=Efmin)
    annotation (Placement(transformation(extent={{74,-10},{94,10}})));
  Modelica.Blocks.Math.Add Verror(k1=-1, k2=1) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));

equation
  Verror.u2 = Vref;

  connect(Limiter.y,y)              annotation (Line(points={{95,0},{110,
          0}}));
  connect(u,Verror.u1)            annotation (Line(points={{-120,0},{-92,
          0},{-92,6},{-82,6}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Line(points={{-84,-6},{-90,-18}}), Text(
            extent={{-100,-20},{-80,-28}}, textString=
                           "Vref")}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-80,-20},{80,-60}},
            textString=                          "System"), Text(extent={
              {-80,60},{80,20}}, textString=
                                     "Excitation")}));
end Exciter;
