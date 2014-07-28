within ObjectStab.Generators.Partials;
partial model Generator
  extends Base.OnePin;
  parameter Boolean isSlack=false
    "Acts as slack node during initialization ? (true=yes)";
  parameter Base.Voltage V0=1 "Initial Terminal Voltage";
  parameter Base.VoltageAngle theta0=0
    "Initial Voltage Angle (only used if isSlack=true)";
  parameter Base.ActivePower Pg0=1
    "Initial Generated Active Power (on system base, only used if isSlack=false)";
  parameter Base.Time TripTime=Modelica.Constants.inf
    "Time of Tripping of Generator";

  Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb);
  Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va));
  Base.ActivePower Pg=-((1 + T.va)*T.ia + T.vb*T.ib) "Generated Active Power";
  Base.ReactivePower Qg=-(T.vb*T.ia - (1 + T.va)*T.ib)
    "Generated Reactive Power";
  inner Boolean online=if time < TripTime then true else false;

protected
  ObjectStab.Base.wRefContainer wrl annotation (Placement(transformation(
        origin={-95,95},
        extent={{-5,-5},{5,5}},
        rotation=180)));
  outer ObjectStab.Base.wRefContainer wrcon annotation (Placement(
        transformation(extent={{-90,90},{-80,100}})));
equation
  connect(wrcon.wr, wrl.wr) annotation (Line(points={{-85,95},{-95,95}}));
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={
        Ellipse(
          extent={{-40,60},{80,-60}},
          lineColor={0,0,0},
          pattern=LinePattern.Solid,
          lineThickness=0.25),
        Line(
          points={{-100,0},{-40,0}},
          color={0,0,0},
          pattern=LinePattern.Solid,
          thickness=0.25,
          arrow={Arrow.None,Arrow.None}),
        Text(extent={{-60,-60},{100,-100}}, textString=
                                                "%name")}));
end Generator;
