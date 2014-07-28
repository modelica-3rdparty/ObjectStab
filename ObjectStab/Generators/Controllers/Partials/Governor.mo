within ObjectStab.Generators.Controllers.Partials;
partial model Governor
  extends Modelica.Blocks.Interfaces.SISO;

  parameter Base.AngularVelocity wref=1;
  parameter Base.MechanicalPower Pmmax=1.05 "Maximum Mechanical Power";
  parameter Base.MechanicalPower Pmmin=0 "Minimum Mechanical Power";
  parameter Base.MechanicalPower Pm0(fixed=false, start=1)
    "Initial Mechanical Power (automatically initialized)";
public
  Modelica.Blocks.Nonlinear.Limiter Limiter(uMax=Pmmax, uMin=Pmmin)
    annotation (Placement(transformation(extent={{76,-10},{96,10}})));
  Modelica.Blocks.Math.Add werror(k1=-1, k2=+1) annotation (Placement(
        transformation(extent={{-80,-10},{-60,10}})));

equation
  werror.u2 = wref;

  connect(Limiter.y,y)              annotation (Line(points={{97,0},{110,
          0}}));
  connect(werror.u1,u)            annotation (Line(points={{-82,6},{-90,6},
          {-90,0},{-120,0}}, color={0,0,255}));
  annotation (
    Diagram(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Text(extent={{-134,32},{-106,24}}, textString=
                                               "w"),
        Text(extent={{96,18},{124,10}}, textString=
                                            "Pm"),
        Text(extent={{-100,-20},{-80,-28}}, textString=
                                                "wref"),
        Line(points={{-84,-6},{-90,-18}})}),
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Text(extent={{-80,-20},{80,-60}},
            textString=                          "System"), Text(extent={
              {-80,60},{80,20}}, textString=
                                     "Governing")}));
end Governor;
