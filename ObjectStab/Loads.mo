within ObjectStab;
package Loads "Loads subpackage"
  extends Modelica.Icons.Library;

  package Partials "Contains uninstatiable classes related to loads"
    extends Modelica.Icons.Library;

    partial model Load "Shell model for loads"
      extends Base.OnePin;

      parameter Base.ActivePower P0=1 "Initial Active Load Power";
      parameter Base.ReactivePower Q0=0.2 "Initial Reactive Load Power";
      Base.ActivePower Pl "Active Load Power";
      Base.ReactivePower Ql "Reactive Load Power";
      Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb)
        "Voltage Amplitude";
      Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va))
        "Voltage Angle";

      discrete Base.Voltage V0(start=1)
        "Inital Terminal Voltage (automatically initialized)";
    equation
      V0 = pre(V0);
      T.ia = (T.vb*Ql + Pl + Pl*T.va)/(1 + 2*T.va + T.va*T.va + T.vb*T.vb);
      T.ib = (Pl*T.vb - Ql - T.va*Ql)/(1 + 2*T.va + T.va*T.va + T.vb*T.vb);

    initial equation
      V0 = V;
      annotation (
        Window(
          x=0.2,
          y=0.04,
          width=0.71,
          height=0.93),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
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

    partial model ExtLoad "Shell model for loads"
      extends Base.OnePin;

      Base.ActivePower P0(start=1) "Initial Active Load Power";
      Base.ReactivePower Q0(start=0.2) "Initial Reactive Load Power";

      Base.ActivePower Pl "Active Load Power";
      Base.ReactivePower Ql "Reactive Load Power";

      Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb)
        "Voltage Amplitude";
      Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va))
        "Voltage Angle";

      discrete Base.Voltage V0(start=1) "Inital Terminal Voltage";
      Modelica.Blocks.Interfaces.RealInput InPort[2]
        annotation (Placement(transformation(
            origin={0,-90},
            extent={{-10,-10},{10,10}},
            rotation=90)));
    equation
      V0 = pre(V0);
      T.ia = (T.vb*Ql + Pl + Pl*T.va)/(1 + 2*T.va + T.va*T.va + T.vb*T.vb);
      T.ib = (Pl*T.vb - Ql - T.va*Ql)/(1 + 2*T.va + T.va*T.va + T.vb*T.vb);

      P0 =InPort[1];
      Q0 =InPort[2];

    initial equation
      V0 = V;
      annotation (
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            extent={{-100,-100},{100,100}},
            grid={2,2}), graphics),
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
            Text(extent={{-60,60},{60,20}}, textString=
                                                "%P0 + j %Q0")}),
        Documentation(info="The complex power a load draws from the network is given by:

S = P+jQ = v * conj(i)

The parameters P0 and Q0 denote the rated load power, i.e., the power
the load draws if the voltage is 1 p.u.
"));
    end ExtLoad;
    annotation (             Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65,
        library=1,
        autolayout=1));
  end Partials;

  model PQLoad "Constant power (PQ) Load"
    extends Partials.Load;
  equation
    Pl = P0;
    Ql = Q0;
    annotation (
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Text(extent={{-40,-60},{42,-20}}, textString=
                                                   "PQ")}),
      Documentation(info="For a constant power the actual load powers drawn from the network
are given by:

  Pl = P0
  Ql = Q0
"),   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end PQLoad;

  model ImpedanceLoad "Impedance Load"
    extends Partials.Load;
  equation
    Pl = P0*(V/V0)^2;
    Ql = Q0*(V/V0)^2;
    annotation (
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Text(extent={{-40,-60},{40,-20}}, textString=
                                                   "Zload")}),
      Documentation(info="R = P*V^2/(Q^2+P^2)
X = Q*V^2/(Q^2+P^2)

"));
  end ImpedanceLoad;

  model ZIPLoad "Impedance Load"
    extends Partials.Load;
    parameter Real pZ=0.33;
    parameter Real pI=0.33;
    parameter Real pP=(1 - pZ - pI);
    parameter Real qZ=0.33;
    parameter Real qI=0.33;
    parameter Real qP=(1 - pZ - pI);

  equation
    Pl = P0*(pZ*(V/V0)^2 + pI*(V/V0) + pP);
    Ql = Q0*(qZ*(V/V0)^2 + qI*(V/V0) + qP);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Text(extent={{-40,-60},{40,-20}}, textString=
                                                   "ZIP")}),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end ZIPLoad;

  model DynLoad
    "Dynamic exponential recovery load according to Karlsson & Hill"
    extends Partials.Load;
    parameter Real as=0.5 "Steady-state active power voltage dependency";
    parameter Real at=2 "Transient active power voltage dependency";
    parameter Real bs=1 "Steady-state reactive power voltage dependency";
    parameter Real bt=2 "Transient reactive power voltage dependency";
    parameter Base.Time Tp=60 "Active power recovery time constant";
    parameter Base.Time Tq=60 "Reactive power recovery time constant";

    Real xp "Internal Load State";
    Real xq "Internal Load State";

  equation
    Pl = (xp/Tp + P0*(V/V0)^at);
    Ql = (xq/Tq + Q0*(V/V0)^bt);
    der(xp) = P0*((V/V0)^(as) - (V/V0)^at) - xp/Tp;
    der(xq) = Q0*((V/V0)^(bs) - (V/V0)^bt) - xq/Tq;

  initial equation
    der(xp) = 0;
    der(xq) = 0;

    annotation (
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Line(points={{-40,-40},{-20,-40},{-20,-60},{-6,
                -50},{6,-46},{24,-44},{40,-44}})}),
      Documentation(info="Dynamic exponential recovery load according to Karlsson & Hill [1].

The load powers are given by:

  der(xp) = P0*(V^(as) - V^at) - xp/Tp;
  Pl = (xp/Tp + P0*V^at);
  der(xq) = Q0*(V^(bs) - V^bt) - xq/Tq;
  Ql = (xq/Tq + Q0*V^bt);

where xp is a continuous dynamic state that can be interpreted as a
measure of the energy deficit in the load and Ps(V) = P0*V^as
is the steady-state and Pt(V)=P0*V^at the transient voltage dependency.
Pl is the actual active load power and Tp is the active power recovery
time constant.

For the reactive load power, a similar model is used with corresponding
characteristics x_q, Qs(V)=Q0 V^bs, Qt(V) = Q0 V^bt and time constant Tq.

---
[1] D. Karlsson and D.J. Hill, \"Modelling and identification of nonlinear
dynamic loads in power systems\", IEEE Transactions on Power Systems,
vol. 9, no. 1, pp. 157-163, February 1994.

"),   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end DynLoad;

  class FreqLoad "Frequency Sensitive Load"
    extends ObjectStab.Loads.Partials.Load;

    parameter Real a=1;
    parameter Real b=1;
    parameter Real c=1;
    parameter Real d=1;
    outer Base.AngularVelocity wref;
  equation
    Pl = P0*(1 + (V - V0)*a + c*(wref - 1));
    Ql = Q0*(1 + (V - V0)*b + d*(wref - 1));
  end FreqLoad;

  model MotorLoad "Simplified Induction Motor Load Model"
    extends Partials.Load;
    parameter Real H=3;
    parameter Real xp=0.1/P0;
    parameter Real scr=0.2;

    Real Tm(start=1);
    Real s(start=0.2);
    Real B;
    Real w;
    outer Real wref;
  equation
    Pl = V^2/xp*(1/(s/scr + scr/s));
    Ql = V^2/xp*((s/scr)/(s/scr + scr/s)) + B*V^2;
    der(B) = 0;
    der(Tm) = 0;

    w = (1 - s)*wref;

    2*H*der(s) = Tm*w - V^2/xp/((s/scr + scr/s));

  initial equation
    s = 1/2/P0/xp*(V^2 - (V^4 - 4*P0^2*xp^2)^(1/2))*scr;
    Tm = V^2/xp/((s/scr + scr/s))/(1 - s);
    B = -(-Q0*xp*s^2 - Q0*xp*scr^2 + V^2*s^2)/xp/(s^2 + scr^2)/V^2;
    annotation (             Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end MotorLoad;

  model ExtDynLoad
    "Dynamic exponential recovery load according to Karlsson & Hill"
    extends Partials.ExtLoad;
    parameter Real as=1 "Steady-state active power voltage dependency";
    parameter Real at=2 "Transient active power voltage dependency";
    parameter Real bs=1 "Steady-state reactive power voltage dependency";
    parameter Real bt=2 "Transient reactive power voltage dependency";
    parameter Base.Time Tp=60 "Active power recovery time constant";
    parameter Base.Time Tq=60 "Reactive power recovery time constant";

    Real xp "Internal Load State";
    Real xq "Internal Load State";
  equation
    Pl = (xp/Tp + P0*(V/V0)^at);
    Ql = (xq/Tq + Q0*(V/V0)^bt);
    der(xp) = P0*((V/V0)^(as) - (V/V0)^at) - xp/Tp;
    der(xq) = Q0*((V/V0)^(bs) - (V/V0)^bt) - xq/Tq;

  initial equation
    der(xp) = 0;
    der(xq) = 0;
    annotation (
      Window(
        x=0.11,
        y=0.02,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Line(points={{-40,-40},{-20,-40},{-20,-60},{-6,
                -50},{6,-46},{24,-44},{40,-44}})}),
      Documentation(info="Dynamic exponential recovery load according to Karlsson & Hill [1].
with external input of P0 and Q0.

The load powers are given by:

  der(xp) = P0*(V^(as) - V^at) - xp/Tp;
  Pl = (xp/Tp + P0*V^at);
  der(xq) = Q0*(V^(bs) - V^bt) - xq/Tq;
  Ql = (xq/Tq + Q0*V^bt);

where xp is a continuous dynamic state that can be interpreted as a
measure of the energy deficit in the load and Ps(V) = P0*V^as
is the steady-state and Pt(V)=P0*V^at the transient voltage dependency.
Pl is the actual active load power and Tp is the active power recovery
time constant.

For the reactive load power, a similar model is used with corresponding
characteristics x_q, Qs(V)=Q0 V^bs, Qt(V) = Q0 V^bt and time constant Tq.

---
[1] D. Karlsson and D.J. Hill, \"Modelling and identification of nonlinear
dynamic loads in power systems\", IEEE Transactions on Power Systems,
vol. 9, no. 1, pp. 157-163, February 1994.

"),   Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end ExtDynLoad;
  annotation (
    Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6,
      library=1,
      autolayout=1),
    Documentation(info="The loads subpackage contains definitions of various load models.

"));
end Loads;
