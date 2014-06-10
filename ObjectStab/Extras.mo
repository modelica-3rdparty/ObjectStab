within ObjectStab;
package Extras
  extends Modelica.Icons.Library;
  model PQPilink
    extends Network.Pilink;
    Real P1=T1.ib*T1.vb + T1.ia + T1.ia*T1.va;
    Real Q1=T1.ia*T1.vb - T1.ib - T1.ib*T1.va;
    Real P2=T2.ib*T2.vb + T2.ia + T2.ia*T2.va;
    Real Q2=T2.ia*T2.vb - T2.ib - T2.ib*T2.va;

    Real Ploss=noEvent(abs(P1 + P2));
    Real Qloss=noEvent(abs(Q1 + Q2));
    Real I1=sqrt(T1.ia^2 + T1.ib^2);
    Real I2=sqrt(T2.ia^2 + T2.ib^2);
    annotation (             Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end PQPilink;

  model OpenedPQPilink
    extends Network.OpenedPilink;

    Real P1=T1.ib*T1.vb + T1.ia + T1.ia*T1.va;
    Real Q1=T1.ia*T1.vb - T1.ib - T1.ib*T1.va;
    Real P2=T2.ib*T2.vb + T2.ia + T2.ia*T2.va;
    Real Q2=T2.ia*T2.vb - T2.ib - T2.ib*T2.va;

    Real Ploss=noEvent(abs(P1 + P2));
    Real Qloss=noEvent(abs(Q1 + Q2));
    Real I1=sqrt(T1.ia^2 + T1.ib^2);
    Real I2=sqrt(T2.ia^2 + T2.ib^2);
    annotation ();
  end OpenedPQPilink;

  model FaultedPQPilink
    extends Network.FaultedPilink;

    Real P1=T1.ib*T1.vb + T1.ia + T1.ia*T1.va;
    Real Q1=T1.ia*T1.vb - T1.ib - T1.ib*T1.va;
    Real P2=T2.ib*T2.vb + T2.ia + T2.ia*T2.va;
    Real Q2=T2.ia*T2.vb - T2.ib - T2.ib*T2.va;

    Real Ploss=noEvent(abs(P1 + P2));
    Real Qloss=noEvent(abs(Q1 + Q2));
    Real I1=sqrt(T1.ia^2 + T1.ib^2);
    Real I2=sqrt(T2.ia^2 + T2.ib^2);
    annotation ();
  end FaultedPQPilink;

  class ShedRelay
    extends Modelica.Blocks.Interfaces.SISO;
    parameter Real Threshold=0.95;
    parameter Real DelayTime=1;

    parameter Real ShedAmount=0.05;
    ObjectStab.Base.Time timerstart(start=-1, fixed=true);

    ObsoletePetriNets.PetriNets.Transition T1 annotation (Placement(
          transformation(extent={{-30,40},{-10,60}}, rotation=0)));
    ObsoletePetriNets.PetriNets.Transition T2 annotation (Placement(
          transformation(
          origin={-20,-14},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    ObsoletePetriNets.PetriNets.Place12 delay annotation (Placement(
          transformation(extent={{0,40},{20,60}}, rotation=0)));
    ObsoletePetriNets.PetriNets.Transition T3 annotation (Placement(
          transformation(
          origin={-20,20},
          extent={{-10,-10},{10,10}},
          rotation=180)));
    ObsoletePetriNets.PetriNets.Place21 wait(initialState=true) annotation (Placement(
          transformation(extent={{-60,40},{-40,60}}, rotation=0)));
  equation
    connect(delay.inTransition, T1.outTransition) annotation (Line(points={{-2,
            50},{-15,50}}));
    connect(T3.inTransition, delay.outTransition1) annotation (Line(points={{
            -13.95,20.05},{30,20},{30,44},{21,44}}));
    connect(delay.outTransition2, T2.inTransition) annotation (Line(points={{
            21.1,56},{46,56},{46,-14},{-13.95,-13.95}}));
    connect(T1.inTransition, wait.outTransition) annotation (Line(points={{
            -26.05,49.95},{-39,50}}));
    connect(T2.outTransition, wait.inTransition2) annotation (Line(points={{-25,
            -14},{-72,-14},{-72,56},{-62,56}}));
    connect(T3.outTransition, wait.inTransition1) annotation (Line(points={{-24,
            20},{-68,20},{-68,44},{-62,44}}));
    T1.condition = (u < Threshold) and (y < ShedAmount/10);
    T2.condition = (u > Threshold);
    T3.condition = time > timerstart + DelayTime;

    when delay.state then
      timerstart = time;
    end when;

    when T3.condition and delay.state then
      y = ShedAmount;
    end when;
  initial equation
    wait.state = true;
    delay.state = true;
    y = 0;
    annotation (             Window(
        x=0.1,
        y=0.01,
        width=0.66,
        height=0.93));
  end ShedRelay;

  model UVLSLoad
    extends ObjectStab.Loads.Partials.Load;
    parameter Real as=1 "Steady-state active power voltage dependency";

    parameter Real at=2 "Transient active power voltage dependency";
    parameter Real bs=1 "Steady-state reactive power voltage dependency";
    parameter Real bt=2 "Transient reactive power voltage dependency";
    parameter Base.Time Tp=60 "Active power recovery time constant";
    parameter Base.Time Tq=60 "Reactive power recovery time constant";

    Real xp "Internal Load State";
    Real xq "Internal Load State";

    Real k;

    ShedRelay Relay1(
      Threshold=0.8,
      DelayTime=1.5,
      ShedAmount=0.05)
                      annotation (Placement(transformation(extent={{-85,15},{
              -15,85}}, rotation=0)));
    ShedRelay Relay2(
      Threshold=0.82,
      DelayTime=3,
      ShedAmount=0.05)
                      annotation (Placement(transformation(extent={{15,15},{85,
              85}}, rotation=0)));
    ShedRelay Relay3(
      DelayTime=6,
      ShedAmount=0.05,
      Threshold=0.92)
                     annotation (Placement(transformation(extent={{-85,-85},{
              -15,-15}}, rotation=0)));
  equation
    Pl = (1 - k)*(xp/Tp + P0*(V/V0)^at);
    Ql = (1 - k)*(xq/Tq + Q0*(V/V0)^bt);
    der(xp) = P0*((V/V0)^(as) - (V/V0)^at) - xp/Tp;
    der(xq) = Q0*((V/V0)^(bs) - (V/V0)^bt) - xq/Tq;

    Relay1.u = V;
    Relay2.u = V;
    Relay3.u = V;
    k = Relay1.y + Relay2.y + Relay3.y;

  initial equation
    der(xp) = 0;
    der(xq) = 0;
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
          Line(points={{-40,-40},{-20,-40},{-20,-60},{-6,-50},{6,-46},{24,-44},
                {40,-44}}),
          Text(extent={{-100,60},{100,20}}, textString=
                                                "%P0 + j %Q0"),
          Text(extent={{-100,100},{100,60}}, textString=
                                                 "UVLS")}),
      Window(
        x=0.08,
        y=0.02,
        width=0.58,
        height=0.98),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics));
  end UVLSLoad;

  model UFLSLoad

    extends ObjectStab.Loads.Partials.Load;

    parameter Real a=1;
    parameter Real b=1;
    parameter Real c=1;
    parameter Real d=1;

    Real k;
    outer Real wref;

    ShedRelay Relay1(
      DelayTime=0.1,
      ShedAmount=0.1,
      Threshold=0.96)
                     annotation (Placement(transformation(extent={{-56.6667,10},
              {-10,56.6667}}, rotation=0)));
    ShedRelay Relay2(
      DelayTime=0.1,
      ShedAmount=0.1,
      Threshold=0.956)
                      annotation (Placement(transformation(extent={{10,10},{
              56.6667,56.6667}}, rotation=0)));
    ShedRelay Relay3(
      DelayTime=0.1,
      ShedAmount=0.1,
      Threshold=0.952)
                      annotation (Placement(transformation(extent={{-56.6667,
              -56.6667},{-10,-10}}, rotation=0)));
  equation
    Pl = (1 - k)*P0*(1 + (V - V0)*a + c*(wref - 1));
    Ql = (1 - k)*Q0*(1 + (V - V0)*b + d*(wref - 1));

    Relay1.u = wref;
    Relay2.u = wref;
    Relay3.u = wref;
    k = Relay1.y + Relay2.y + Relay3.y;
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={Text(extent={{-100,100},{100,60}}, textString=
                                                    "UFLS")}),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end UFLSLoad;

  model DetGen0 "Detailed Static Generator Model"
    extends ObjectStab.Generators.Partials.Generator;

    parameter Base.ApparentPower Sbase=100 "Generator rated power";
    parameter ObjectStab.Base.Resistance ra=0 "Armature Resistance";
    parameter ObjectStab.Base.Reactance xd=0.8948
      "Direct Axis Synchronous Reactance";
    parameter ObjectStab.Base.Reactance xq=0.84
      "Quadrature Axis Synchronous Reactance";
    parameter Real K=50 "Voltage Regulator Steady-State Gain";
    parameter ObjectStab.Base.Voltage Efmax=3.5 "Maximum Field Voltage";
    parameter ObjectStab.Base.Voltage Efmin=-3.5 "Minimum Field Voltage";
    parameter ObjectStab.Base.Current Iarmmax=1.05 "Armature Current Limit";
    parameter Base.Resistance rt=0 "Step-up Transformer Resistance";
    parameter Base.Reactance xt=0.0 "Step-up Transformer Reactance";
    parameter Base.Time Tdelay=20;

    Boolean up_limit(start=false);
    Boolean arm_limit(start=false);
    Real vta(start=1);
    Real vtb(start=1);
    Real Pgt(start=1);
    Real Qgt(start=1);
    Real Efd(start=1);
    Real Vt(start=1);
    Real Iarm(start=1);
    discrete Real Vref(start=1);
    discrete Real Pm0(start=1);
  equation
    //
    0 = if time > TripTime then Qgt else if arm_limit then Qgt - sqrt((Vt*
      Iarmmax)^2 - Pgt^2) else if up_limit then (Efd - Efmax) else (Vt - (Vref
       - Efd/K));
    Pgt = if time > TripTime then 0 else (Pm0 - ra*Iarm^2);

    Vt = sqrt((1 + vta)^2 + vtb^2);
    Pgt = -((1 + vta)*T.ia + vtb*T.ib)/Sbase*Base.Sbase;
    Qgt = -(vtb*T.ia - (1 + vta)*T.ib)/Sbase*Base.Sbase;
    Efd = (Vt^4 + Vt^2*Qgt*xq + Qgt*xd*Vt^2 + Qgt^2*xd*xq + Pgt^2*xq*xd)/(sqrt(
      Pgt^2*xq^2 + Vt^4 + 2*Vt^2*Qgt*xq + Qgt^2*xq^2)*Vt);
    [1 + T.va; T.vb] = [rt, -xt; xt, rt]*[T.ia; T.ib]/Sbase*Base.Sbase + [1 +
      vta; vtb];

    // limiter logic
    up_limit = (pre(up_limit) and Vt < (Vref)) or not pre(up_limit) and (delay(
      Efd, Tdelay) > Efmax);
    arm_limit = (pre(arm_limit) and V < (Vref)) or not pre(arm_limit) and (
      delay(Iarm, Tdelay) > Iarmmax);
    Iarm = sqrt(T.ia^2 + T.ib^2)/Sbase*Base.Sbase;
    Vref = pre(Vref);
    Pm0 = pre(Pm0);

    // contribute to angle reference calculation
    wrl.wr.Hwsum = if time < TripTime then Modelica.Constants.inf else 0;
    wrl.wr.Hsum = if time < TripTime then Modelica.Constants.inf else 0;

  initial equation
    V = V0;
    if isSlack then
      theta = theta0;
    else
      Pg = Pg0;
    end if;

    annotation (             Window(
        x=0.08,
        y=0.26,
        width=0.6,
        height=0.6));
  end DetGen0;

  model GovExcKundurGen
    "6th Order Detailed Generator according to Kundur sec 13.3"
    extends ObjectStab.Generators.Partials.DetGen;

  public
    constant Real Ksd=1;
    // generator saturation (not implemented keep at 1);
    constant Real Ksq=1;

    parameter ObjectStab.Base.Resistance ra=0 "Armature Resistance";
    parameter ObjectStab.Base.Reactance xl=0.15 "Leakage Reactance";
    parameter ObjectStab.Base.Reactance xd=0.8948
      "Direct Axis Synchronous Reactance";
    parameter ObjectStab.Base.Reactance xq=0.84
      "Quadrature Axis Synchronous Reactance";
    parameter ObjectStab.Base.Reactance xdp=0.30
      "Direct Axis Transient Reactance";
    parameter ObjectStab.Base.Reactance xqp=0.10
      "Quadrature Axis Transient Reactance";
    parameter ObjectStab.Base.Reactance xdpp=0.20
      "Direct Axis Subtransient Reactance";
    parameter ObjectStab.Base.Reactance xqpp=0.10
      "Quadrature Axis Subtransient Reactance";

    parameter ObjectStab.Base.Time Td0p=7
      "Open-circuit Direct Axis Transient Time Constant";
    parameter ObjectStab.Base.Time Tq0p=0.44
      "Open-circuit Quadrature Axis Transient Time Constant";
    parameter ObjectStab.Base.Time Td0pp=0.02
      "Open-circuit Direct Axis Subtransient Time Constant";
    parameter ObjectStab.Base.Time Tq0pp=0.03
      "Open-circuit Quadrature Axis Subtransient Time Constant";

  protected
    parameter Real Ladu=xd - xl;
    parameter Real Laqu=xq - xl;
    parameter Real Lfd=-Ladu*(xdp - xl)/(xdp - xl - Ladu);
    parameter Real L1q=-Laqu*(-xqp + xl)/(-xqp + xl + Laqu);
    parameter Real L1d=-Ladu*Lfd*(-xdpp + xl)/(-xdpp*Ladu - xdpp*Lfd + xl*Ladu
         + xl*Lfd + Ladu*Lfd);
    parameter Real L2q=-Laqu*L1q*(-xqpp + xl)/(-xqpp*Laqu - xqpp*L1q + xl*Laqu
         + xl*L1q + Laqu*L1q);
    parameter Real Rfd=(Ladu + Lfd)/(Td0p*ObjectStab.Base.ws);
    parameter Real R1d=(L1d + (Ladu*Lfd)/(Ladu + Lfd))/(Td0pp*ObjectStab.Base.
        ws);
    parameter Real R1q=(Laqu + L1q)/(Tq0p*ObjectStab.Base.ws);
    parameter Real R2q=(L2q + (Laqu*L1q)/(Laqu + L1q))/(Tq0pp*ObjectStab.Base.
        ws);

    parameter Real Ladspp=1/(1/(Ksd*Ladu) + 1/Lfd + 1/L1d);
    parameter Real Laqspp=1/(1/(Ksq*Laqu) + 1/L1q + 1/L2q);
    parameter Real Ldpp=xl + Ladspp;
    parameter Real Lqpp=xl + Laqspp;
  public
    Real lamfd(start=1);
    Real lam1d;
    Real lam1q;
    Real lam2q;
    Real lamad;
    Real lamaq;
    Real Ifd(start=1);
    Real efd=Efd*Rfd/Ladu;

    replaceable ObjectStab.Generators.Controllers.ConstPm Gov annotation (Placement(
          transformation(extent={{12,-96},{32,-76}}, rotation=0)));
    replaceable ObjectStab.Generators.Controllers.ConstEfd Exc annotation (Placement(
          transformation(extent={{14,70},{34,90}}, rotation=0)));
  equation
    der(lamfd) = ObjectStab.Base.ws*((Efd*Rfd/Ladu) + (lamad - lamfd)*Rfd/Lfd);
    der(lam1d) = ObjectStab.Base.ws*(lamad - lam1d)/L1d*R1d;
    der(lam1q) = ObjectStab.Base.ws*(lamaq - lam1q)/L1q*R1q;
    der(lam2q) = ObjectStab.Base.ws*(lamaq - lam2q)/L2q*R2q;
    lamad = Ladspp*(-iq + lamfd/Lfd + lam1d/L1d);
    lamaq = Laqspp*(-id + lam1q/L1q + lam2q/L2q);

    // stator eqs
    //vq = -ra*iq + w*Lqpp*id + (-w*Laqspp*(lam1q/L1q + lam2q/L2q));
    //vd = -ra*id - w*Ldpp*iq + (w*Ladspp*(lamfd/Lfd + lam1d/L1d));
    if online then
      iq = -(w*Lqpp*L1q*L2q*vd*Lfd*L1d - w^2*Lqpp*L1q*L2q*Ladspp*lamfd*L1d - w^
        2*Lqpp*L1q*L2q*Ladspp*lam1d*Lfd + vq*L1q*L2q*ra*Lfd*L1d + w*Laqspp*
        lam1q*L2q*ra*Lfd*L1d + w*Laqspp*lam2q*L1q*ra*Lfd*L1d)/L1q/L2q/Lfd/L1d/(
        w^2*Lqpp*Ldpp + ra^2);
      id = (-vd*Lfd*L1d*L1q*L2q*ra + w*Ldpp*vq*L1q*L2q*Lfd*L1d + w^2*Ldpp*
        Laqspp*lam1q*L2q*Lfd*L1d + w^2*Ldpp*Laqspp*lam2q*L1q*Lfd*L1d + w*Ladspp
        *lamfd*L1d*L1q*L2q*ra + w*Ladspp*lam1d*Lfd*L1q*L2q*ra)/L1q/L2q/(w^2*
        Lqpp*Ldpp + ra^2)/Lfd/L1d;
    else
      iq = 0;
      id = 0;
    end if;

    Pe = w*(lamad*id - lamaq*iq);
    Ifd = Ladu*(lamfd - lamad)/Lfd;

    // connection of governor and exciter
    Gov.u = w;
    Pm = Gov.y;
    Exc.u = sqrt(vd^2 + vq^2);
    Efd = Exc.y;

  initial equation
    der(lamfd) = 0;
    der(lam1d) = 0;
    der(lam1q) = 0;
    der(lam2q) = 0;
    annotation (
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6),
      Icon(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics),
      Diagram(coordinateSystem(
          preserveAspectRatio=false,
          extent={{-100,-100},{100,100}},
          grid={2,2}), graphics={
          Line(
            points={{-100,0},{-20,0}},
            color={0,0,0},
            pattern=LinePattern.Solid,
            thickness=0.25,
            arrow={Arrow.None,Arrow.None}),
          Ellipse(
            extent={{-20,40},{60,-40}},
            lineColor={0,0,0},
            pattern=LinePattern.Solid,
            lineThickness=0.25),
          Text(
            extent={{44,68},{64,48}},
            lineColor={0,0,0},
            textString=
                 "Efd"),
          Text(
            extent={{58,-56},{78,-76}},
            lineColor={0,0,0},
            textString=
                 "Pm"),
          Line(points={{80,40},{80,80},{34,80}}, color={0,0,0}),
          Line(
            points={{80,40},{54,20}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Line(points={{-6,30},{-46,30},{-46,86},{12,86},{4,86}}, color={0,0,0}),

          Line(points={{2,36},{-20,36},{-20,74},{12,74}}, color={0,0,0}),
          Text(
            extent={{-68,66},{-48,46}},
            lineColor={0,0,0},
            textString=
                 "Vt"),
          Text(
            extent={{-12,68},{8,48}},
            lineColor={0,0,0},
            textString=
                 "dw"),
          Line(
            points={{32,-86},{80,-86},{80,-40},{54,-22}},
            color={0,0,0},
            arrow={Arrow.None,Arrow.Filled}),
          Line(points={{-18,-14},{-44,-14},{-44,-86},{12,-86}}, color={0,0,0}),

          Text(
            extent={{-66,-54},{-46,-74}},
            lineColor={0,0,0},
            textString=
                 "w")}));
  end GovExcKundurGen;

  model ExtSlack
    extends Generators.Partials.Generator(isSlack=true);

  public
    Modelica.Blocks.Interfaces.RealInput InPort
      annotation (Placement(transformation(
          origin={20,-70},
          extent={{-10,-10},{10,10}},
          rotation=90)));
  equation
    if online then
      if not isSlack then
        V = V0;
        Pg = Pg0;
      else
        1 + T.va = V0*cos(theta0);
        T.vb = V0*sin(theta0);
      end if;
    else
      T.ia = 0;
      T.ib = 0;
    end if;
    // contribute to angle reference calculation
    wrl.wr.Hwsum = if online then Modelica.Constants.inf else 0;
    wrl.wr.Hsum = if online then Modelica.Constants.inf else 0;
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
          Text(extent={{-60,100},{100,60}}, textString=
                                                "%name"),
          Text(extent={{-40,-20},{80,20}}, textString=
                                               "Slack")}),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6));
  end ExtSlack;
  annotation (             Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6,
      library=1,
      autolayout=1));
end Extras;
