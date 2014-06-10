within ObjectStab;
package Base "Base package"
  extends Modelica.Icons.Library;

  // Time and Space
  type Time = Real (final quantity="Time", final unit="s");
  type Duration = Time (min=0);
  type AngularVelocity = Real (
      final quantity="AngularVelocity",
      final unit="p.u.",
      displayUnit="p.u.");
  type Angle = Real (
      final quantity="Angle",
      final unit="rad",
      displayUnit="deg",
      min=-Modelica.Constants.pi,
      max=Modelica.Constants.pi);
  type InertiaConstant = Real (final quantity="InertiaConstant", final unit="s");
  type DampingCoefficient = Real (final quantity="DampingCoefficient", final
        unit="1");

  // per.unit. definitions - Electric  voltage and current phasors
  type Current = Real (final quantity="CurrentPhasor", final unit="p.u.");
  type Voltage = Real (final quantity="VoltagePhasor", final unit="p.u");
  type VoltageAngle = Angle;
  type Resistance = Real (
      final quantity="Resistance",
      final unit="p.u.",
      min=0);
  type Reactance = Real (final quantity="Resistance", final unit="p.u.");
  type Conductance = Real (
      final quantity="Conductance",
      final unit="p.u.",
      min=0);
  type Capacitance = Real (final quantity="Capacitance", final unit="p.u.");
  type Susceptance = Real (final quantity="Conductance", final unit="p.u.");
  type ActivePower = Real (final quantity="Power", final unit="p.u.");
  type ApparentPower = Real (final quantity="Power", final unit="p.u.");
  type ReactivePower = Real (final quantity="Power", final unit="p.u.");
  type PowerFactor = Real (final quantity="PowerFactor", final unit="1");
  type TapRatio = Real (final quantity="Transformer Ratio", final unit="p.u.");
  type TapStep = Integer;
  type ElectricalTorque = Real (final quantity="Torque", final unit="p.u.");
  type MechanicalTorque = Real (final quantity="Torque", final unit="p.u.");
  type MechanicalPower = Real (final quantity="Power", final unit="p.u.");

  // nominal frequency
  constant Real f0=50;
  constant AngularVelocity ws=2*Modelica.Constants.pi*f0;

  // System Sbase (in MVA)
  constant ApparentPower Sbase=100;

  //
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

  partial model OnePin
    "Shell model for ObjectStab models with one electrical connector "

    ObjectStab.Base.Pin T annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
  equation
    //  assert(cardinality(T) > 0, "One Pin not connected");
    annotation (
      Documentation(info=""));
  end OnePin;

  partial model OnePinCenter
    "Shell model for models with one connector in the center of the model"

    ObjectStab.Base.Pin T annotation (Placement(transformation(extent={{-10,-10},
              {10,10}})));
    annotation (
      Documentation(info=""));
  end OnePinCenter;

  partial model TwoPin
    "Shell model for ObjectStab models with two electrical connectors "

    ObjectStab.Base.Pin T1 annotation (Placement(transformation(extent={{-110,
              -10},{-90,10}})));
    ObjectStab.Base.Pin T2 annotation (Placement(transformation(extent={{90,-10},
              {110,10}})));
  end TwoPin;

  class VoltageMeasurement "Voltage Measurement for Electrical Cuts"
    extends ObjectStab.Base.OnePin;

    Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb) "Voltage Amplitude";
    Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va))
      "Voltage Angle";
    Modelica.Blocks.Interfaces.RealOutput outPort
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  equation
    T.ia = 0;
    T.ib = 0;
    outPort = V;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-80,0},{-10,0}}, color={0,0,0}),
          Line(points={{-80,40},{-80,-40}}, color={0,0,0}),
          Text(
            extent={{-100,100},{40,60}},
            lineColor={0,0,0},
            textString=
                 "Voltage")}));
  end VoltageMeasurement;

  class CurrentMeasurement "CurrentMeasurement"
    extends ObjectStab.Base.TwoPin;
    Modelica.Blocks.Interfaces.RealOutput outPort
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
  equation
    outPort = sqrt((T1.ia)^2 + T1.ib^2);
    T1.va = T2.va;
    T1.vb = T2.vb;
    T1.ia = -T2.ia;
    T1.ib = -T2.ib;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Text(
            extent={{-100,-60},{100,-100}},
            lineColor={0,0,0},
            textString=
                 "Current"),
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Ellipse(extent={{-6,20},{6,-20}}, lineColor={0,0,0}),
          Line(points={{0,20},{0,60},{20,60}}, color={0,0,0}),
          Line(points={{-40,-40},{40,-40}}, color={0,0,0}),
          Polygon(
            points={{40,-40},{20,-32},{20,-48},{40,-40}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="Current Measurement for Electrical Cuts.
Should be connected in series.
"));
  end CurrentMeasurement;

  class PowerMeasurement "Power Measurement"
    extends ObjectStab.Base.TwoPin;
    Real P=(1 + T1.va)*T1.ia + T1.vb*T1.ib;
    Real Q=(T1.vb*T1.ia - (1 + T1.va)*T1.ib);
    Modelica.Blocks.Interfaces.RealOutput outPort[2]
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
  equation

    outPort[1] = P;
    outPort[2] = Q;
    T1.va = T2.va;
    T1.vb = T2.vb;
    T1.ia = -T2.ia;
    T1.ib = -T2.ib;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{-100,0},{100,0}}, color={0,0,0}),
          Ellipse(extent={{-6,20},{6,-20}}, lineColor={0,0,0}),
          Line(points={{0,20},{0,60},{20,60}}, color={0,0,0}),
          Text(
            extent={{-100,-60},{100,-100}},
            lineColor={0,0,0},
            textString=
                 "Power"),
          Line(points={{-40,-40},{40,-40}}, color={0,0,0}),
          Polygon(
            points={{40,-40},{20,-32},{20,-48},{40,-40}},
            lineColor={0,0,0},
            fillColor={0,0,0},
            fillPattern=FillPattern.Solid)}),
      Documentation(info="Current Measurement for Electrical Cuts.
Should be connected in series.
"));
  end PowerMeasurement;

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

  class System "Shell model for connected systems"
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

  model Scaler
    extends TwoPin;
    Real k=InPort;
    Modelica.Blocks.Interfaces.RealInput InPort
      annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  equation
    [T2.ia; T2.ib] = k*[T1.ia; T1.ib];
    [T2.va; T2.vb] = k*[T1.va; T1.vb];
    annotation (             Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(points={{0,10},{0,60},{-20,60}}, color={0,0,0}),
          Line(points={{-20,20},{20,0},{-20,-22},{-20,20}}, color={0,0,0}),
          Line(points={{-102,0},{100,0}}, color={0,0,0})}));
  end Scaler;

  class wRefContainer
    wRefPin wr annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Text(extent={{-60,40},{62,-42}}, textString=
                                                  "wref")}));
  end wRefContainer;
  annotation (
    Documentation(info="The base package contains definitions common to all
subpackages, including the new datatypes for the p.u.
quantities are defined.

The constant f0 sets the rated frequency.
This can be changed into 60 Hz for american users.
"));
end Base;
