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
      min=-Modelica.Constants.PI, 
      max=Modelica.Constants.PI);
  type InertiaConstant = Real (final quantity="InertiaConstant", final unit="s"
      );
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
  constant AngularVelocity ws=2*Modelica.Constants.PI*f0;
  
  // System Sbase (in MVA)
  constant ApparentPower Sbase=100;
  
  //  
  connector Pin "Electrical connector for ObjectStab models" 
    Base.Voltage va;
    Base.Voltage vb;
    flow Base.Current ia;
    flow Base.Current ib;
    
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6), 
      Diagram(Rectangle(extent=[-10, 30; 30, -10], style(fillColor=3, 
              fillPattern=1))), 
      Icon(Rectangle(extent=[-20, 20; 20, -20], style(fillColor=3, fillPattern=
                1))), 
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
    
    ObjectStab.Base.Pin T annotation (extent=[-110, -10; -90, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6), 
      Documentation(info=""));
  equation 
    //  assert(cardinality(T) > 0, "One Pin not connected");
  end OnePin;
  
  partial model OnePinCenter 
    "Shell model for models with one connector in the center of the model" 
    
    ObjectStab.Base.Pin T annotation (extent=[-10, -10; 10, 10]);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.04, 
        y=0.26, 
        width=0.6, 
        height=0.6), 
      Diagram, 
      Icon, 
      Documentation(info=""));
  end OnePinCenter;
  
  partial model TwoPin 
    "Shell model for ObjectStab models with two electrical connectors " 
    
    ObjectStab.Base.Pin T1 annotation (extent=[-110, -10; -90, 10]);
    ObjectStab.Base.Pin T2 annotation (extent=[90, -10; 110, 10]);
    annotation (Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6));
  end TwoPin;
  annotation (
    Coordsys(
      extent=[0, 0; 606, 415], 
      grid=[2, 2], 
      component=[20, 20]), 
    Window(
      x=0.4, 
      y=0.4, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1), 
    Documentation(info="The base package contains definitions common to all
subpackages, including the new datatypes for the p.u. 
quantities are defined.
 
The constant f0 sets the rated frequency. 
This can be changed into 60 Hz for american users.
"));
  class VoltageMeasurement "Voltage Measurement for Electrical Cuts" 
    extends ObjectStab.Base.OnePin;
    
    Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb) "Voltage Amplitude";
    Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va)) 
      "Voltage Angle";
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.01, 
        width=0.6, 
        height=0.6), 
      Diagram, 
      Icon(
        Line(points=[-80, 0; -10, 0], style(color=0)), 
        Line(points=[-80, 40; -80, -40], style(color=0)), 
        Text(
          extent=[-100, 100; 40, 60], 
          string="Voltage", 
          style(color=0))));
    Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation (extent=[-
          10, -10; 10, 10]);
  equation 
    T.ia = 0;
    T.ib = 0;
    outPort.signal[1] = V;
  end VoltageMeasurement;
  
  class CurrentMeasurement "CurrentMeasurement" 
    extends ObjectStab.Base.TwoPin;
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.06, 
        width=0.6, 
        height=0.6), 
      Icon(
        Text(
          extent=[-100, -60; 100, -100], 
          string="Current", 
          style(color=0)), 
        Line(points=[-100, 0; 100, 0], style(color=0)), 
        Ellipse(extent=[-6, 20; 6, -20], style(color=0)), 
        Line(points=[0, 20; 0, 60; 20, 60], style(color=0)), 
        Line(points=[-40, -40; 40, -40], style(color=0, fillColor=0)), 
        Polygon(points=[40, -40; 20, -32; 20, -48; 40, -40], style(color=0, 
              fillColor=0))), 
      Documentation(info="Current Measurement for Electrical Cuts. 
Should be connected in series.
"));
    Modelica.Blocks.Interfaces.OutPort outPort(final n=1) annotation (extent=[
          20, 50; 40, 70]);
  equation 
    outPort.signal[1] = sqrt((T1.ia)^2 + T1.ib^2);
    T1.va = T2.va;
    T1.vb = T2.vb;
    T1.ia = -T2.ia;
    T1.ib = -T2.ib;
  end CurrentMeasurement;
  
  class PowerMeasurement "Power Measurement" 
    extends ObjectStab.Base.TwoPin;
    Real P=(1 + T1.va)*T1.ia + T1.vb*T1.ib;
    Real Q=(T1.vb*T1.ia - (1 + T1.va)*T1.ib);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.1, 
        y=0.06, 
        width=0.6, 
        height=0.6), 
      Icon(
        Line(points=[-100, 0; 100, 0], style(color=0)), 
        Ellipse(extent=[-6, 20; 6, -20], style(color=0)), 
        Line(points=[0, 20; 0, 60; 20, 60], style(color=0)), 
        Text(
          extent=[-100, -60; 100, -100], 
          string="Power", 
          style(color=0)), 
        Line(points=[-40, -40; 40, -40], style(color=0, fillColor=0)), 
        Polygon(points=[40, -40; 20, -32; 20, -48; 40, -40], style(color=0, 
              fillColor=0))), 
      Documentation(info="Current Measurement for Electrical Cuts. 
Should be connected in series.
"));
    Modelica.Blocks.Interfaces.OutPort outPort(final n=2) annotation (extent=[
          20, 50; 40, 70]);
  equation 
    
    outPort.signal[1] = P;
    outPort.signal[2] = Q;
    T1.va = T2.va;
    T1.vb = T2.vb;
    T1.ia = -T2.ia;
    T1.ib = -T2.ib;
  end PowerMeasurement;
  
  connector wRefPin 
    flow Real Hwsum(start=1);
    flow Base.InertiaConstant Hsum(start=1);
    annotation (
      Icon(Rectangle(extent=[-20, 22; 20, -20], style(color=7, fillColor=8))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6));
  end wRefPin;
  
  class System "Shell model for connected systems" 
    parameter AngularVelocity wmin=0.5;
    parameter AngularVelocity wmax=1.5;
    
    inner AngularVelocity wref(start=1);
  protected 
    inner wRefContainer wrcon annotation (extent=[-120, 100; -100, 120]);
    annotation (
      Icon(
        Text(
          extent=[0, 132; 0, 73], 
          string="%name", 
          style(color=1)), 
        Rectangle(extent=[-100, -100; 80, 50], style(fillColor=7)), 
        Polygon(points=[-100, 50; -80, 70; 100, 70; 80, 50; -100, 50], style(
              fillColor=7)), 
        Polygon(points=[100, 70; 100, -80; 80, -100; 80, 50; 100, 70], style(
              fillColor=7)), 
        Text(extent=[-83, -6; 71, -54], string="ObjectStab")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.19, 
        y=0.03, 
        width=0.76, 
        height=0.93), 
      Documentation(info="This model defines global variables necessary for the system frequency reference.
The reference is computed using the center-of-inertia method.
"));
  equation 
    wref = wrcon.wr.Hwsum/(wrcon.wr.Hsum);
    
    when (wref < wmin) or (wref > wmax) then
      terminate(
        "Simulation terminated since reference freqeuency is unreasonable !! (as decided by parameters wmin and wmax)"
        );
    end when;
    
  end System;
  
  model Scaler 
    extends TwoPin;
    Real k=InPort.signal[1];
    annotation (Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), Icon(
        Line(points=[0, 10; 0, 60; -20, 60], style(color=0)), 
        Line(points=[-20, 20; 20, 0; -20, -22; -20, 20], style(color=0)), 
        Line(points=[-102, 0; 100, 0], style(color=0))));
    Modelica.Blocks.Interfaces.InPort InPort annotation (extent=[-40, 50; -20, 
          70]);
  equation 
    [T2.ia; T2.ib] = k*[T1.ia; T1.ib];
    [T2.va; T2.vb] = k*[T1.va; T1.vb];
  end Scaler;
  
  class wRefContainer 
    wRefPin wr annotation (extent=[-10, -10; 10, 10]);
    annotation (
      Icon(Text(extent=[-60, 40; 62, -42], string="wref")), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6));
  end wRefContainer;
end Base;
