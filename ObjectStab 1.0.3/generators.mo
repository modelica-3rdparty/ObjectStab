package Generators "Generator subpackage" 
  extends Modelica.Icons.Library;
  
  package Partials "Contains uninstatiable classes related to generators" 
    extends Modelica.Icons.Library;
    
    partial model Generator 
      extends Base.OnePin;
      parameter Boolean isSlack=false 
        "Acts as slack node during initialization ? (true=yes)";
      parameter Base.Voltage V0=1 "Initial Terminal Voltage";
      parameter Base.VoltageAngle theta0=0 
        "Initial Voltage Angle (only used if isSlack=true)";
      parameter Base.ActivePower Pg0=1 
        "Initial Generated Active Power (on system base, only used if isSlack=false)"
        ;
      parameter Base.Time TripTime=Modelica.Constants.inf 
        "Time of Tripping of Generator";
      
      Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb);
      Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va));
      Base.ActivePower Pg=-((1 + T.va)*T.ia + T.vb*T.ib) 
        "Generated Active Power";
      Base.ReactivePower Qg=-(T.vb*T.ia - (1 + T.va)*T.ib) 
        "Generated Reactive Power";
      inner Boolean online=if time < TripTime then true else false;
      
      annotation (
        Icon(
          Ellipse(extent=[-40, 60; 80, -60], style(
              color=0, 
              pattern=1, 
              thickness=1, 
              arrow=0)), 
          Line(points=[-100, 0; -40, 0], style(
              color=0, 
              pattern=1, 
              thickness=1, 
              arrow=0)), 
          Text(extent=[-60, -60; 100, -100], string="%name")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.4, 
          y=0.4, 
          width=0.6, 
          height=0.6), 
        Diagram);
    protected 
      ObjectStab.Base.wRefContainer wrl annotation (extent=[-100, 90; -90, 100]
          , rotation=180);
      outer ObjectStab.Base.wRefContainer wrcon annotation (extent=[-90, 90; -
            80, 100]);
    equation 
      connect(wrcon.wr, wrl.wr) annotation (points=[-85, 95; -95, 95]);
    end Generator;
    
    model InfiniteBus "Infinite Bus Model" 
      extends Generator;
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
        Documentation(info="The variables Pg and Qg corresponds to the actual active and reactive power
delivered to the network referred at the system base.
"));
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
    end InfiniteBus;
    
    partial model DetGen "Common Definitions for Detailed Generator" 
      extends Partials.Generator;
      
      parameter Real Sbase=100 "Generator rated power [MVA]";
      parameter Base.InertiaConstant H=6 "Inertia Constant";
      parameter Base.DampingCoefficient D=0 "Damping Coefficient";
      parameter Base.Resistance rt=0 "Step-up Transformer Resistance";
      parameter Base.Reactance xt=0.0 "Step-up Transformer Reactance";
      
      inner Base.AngularVelocity w(start=1, stateSelect=StateSelect.prefer) 
        "Angular Speed";
      inner Base.VoltageAngle delta(start=0, stateSelect=StateSelect.prefer) 
        "Rotor Angle";
      inner Base.MechanicalPower Pm(start=1) "Mechanical Power";
      inner Base.Voltage Efd(start=2) "Field Voltage";
      inner Base.Current Iarm=sqrt(id^2 + iq^2) "Armature Current";
      inner Base.ActivePower Pe(start=1) "Electrical Power";
      
      Base.Current iq "dq Armature Current";
      Base.Current id;
      Base.Voltage vq "dq Armature Voltage";
      Base.Voltage vd;
      outer Base.AngularVelocity wref;
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
        Diagram, 
        Documentation(info="Common definitions for detailed generator models, including the generator step-up
transformer.  

At least one slack node or detailed generator with its attribute 'isSlack' 
set to true must be included in each network model. For this generator the 
attribute Pg0 is not used. For generators with 'isSlack' set to false, the 
attribute theta0 is not used. Tripping of the generator can be simulated 
by setting the tripping time in the attribute 'TripTime'. 

Each generator has it's own dq coordinate system, and its stator equations
must therefore be related to the network (global) coordinate system using the
so called Kron's transformations [1, pp. 90].


---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"), 
        Icon);
    equation 
      //   swing equations
      der(w) = 1/(2*H)*(Pm - Pe - D*(w - wref));
      der(delta) = Base.ws*(w - wref);
      
      // Kron's transformation, see fig 3.30 in Machovski               
      
      
        // to interface between generators own dq-frame and  system dq-frame          
      [T.ia; T.ib] = -[-sin(delta), cos(delta); cos(delta), sin(delta)]*[id; iq
        ]*Sbase/Base.Sbase;
      
      [1 + T.va; T.vb] = [-sin(delta), cos(delta); cos(delta), sin(delta)]*([vd
        ; vq] + [rt, -xt; xt, rt]*[id; iq]);
      
      // contribute to angle reference calculation 
      wrl.wr.Hwsum = if online then H*w*(Sbase/Base.Sbase) else 0;
      wrl.wr.Hsum = if online then H*(Sbase/Base.Sbase) else 0;
      
    initial equation 
      w = 1;
      Pm = Pe;
      V = V0;
      if isSlack then
        theta = theta0;
      else
        Pg = Pg0;
      end if;
    end DetGen;
    
    model DetGen3 "3rd Order Detailed Generator" 
      extends DetGen;
      
      parameter Base.Resistance ra=0 "Armature Resistance";
      parameter Base.Reactance xd=0.8948 "Direct Axis Synchronous Reactance";
      parameter Base.Reactance xq=0.84 "Quadrature Axis Synchronous Reactance";
      parameter Base.Reactance xdp=0.30 "Direct Axis Transient Reactance";
      parameter Base.Time Td0p=7 
        "Open-circuit Direct Axis Transient Time Constant";
      
      Base.Voltage Eqp(start=1, stateSelect=StateSelect.prefer);
      annotation (
        Diagram, 
        Icon(Text(extent=[-20, -40; 60, 0], string="Order"), Text(extent=[-20, 
                0; 60, 40], string="3rd")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.11, 
          y=0.01, 
          width=0.58, 
          height=0.99), 
        Documentation(info="The 3rd order detailed generator model corresponds to Model 3 in [1, pp 348],
and extends the DetGen class. It adds a single transient EMF source in
the quatradure axis and the field voltage input. This model neglects the effect
of damper windings and the damping produced by rotor eddy-currents.
The effect of this damping is usually included in the damping coefficient D.


---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
    equation 
      // Transient EMF equation
      Td0p*der(Eqp) = Efd - Eqp + id*(xd - xdp);
      
      // stator equations
      //vd = -ra*id - xq*iq;
      //vq = Eqp + xdp*id - ra*iq;
      iq = if online then -(vq*ra - Eqp*ra + xdp*vd)/(xdp*xq + ra^2) else 0;
      id = if online then -(vd*ra - xq*vq + xq*Eqp)/(xdp*xq + ra^2) else 0;
      
      // electrical power
      Pe = Eqp*iq + (xdp - xq)*id*iq;
      
    initial equation 
      der(Eqp) = 0;
    end DetGen3;
    
    model DetGen6 "6th Order Detailed Generator" 
      extends DetGen;
      
      parameter Base.Resistance ra=0 "Armature Resistance";
      parameter Base.Reactance xd=0.8948 "Direct Axis Synchronous Reactance";
      parameter Base.Reactance xq=0.84 "Quadrature Axis Synchronous Reactance";
      parameter Base.Reactance xdp=0.30 "Direct Axis Transient Reactance";
      parameter Base.Reactance xqp=0.10 "Quadrature Axis Transient Reactance";
      parameter Base.Reactance xdpp=0.20 "Direct Axis Subtransient Reactance";
      parameter Base.Reactance xqpp=0.10 
        "Quadrature Axis Subtransient Reactance";
      
      parameter Base.Time Td0p=7 
        "Open-circuit Direct Axis Transient Time Constant";
      parameter Base.Time Tq0p=0.44 
        "Open-circuit Quadrature Axis Transient Time Constant";
      parameter Base.Time Td0pp=0.02 
        "Open-circuit Direct Axis Subtransient Time Constant";
      parameter Base.Time Tq0pp=0.03 
        "Open-circuit Quadrature Axis Subtransient Time Constant";
      
      Base.Voltage Eqp(start=0, stateSelect=StateSelect.prefer);
      Base.Voltage Edp(start=0, stateSelect=StateSelect.prefer);
      Base.Voltage Eqpp(start=0, stateSelect=StateSelect.prefer);
      Base.Voltage Edpp(start=0, stateSelect=StateSelect.prefer);
      annotation (
        Icon(Text(extent=[-20, 0; 60, 40], string="6th"), Text(extent=[-20, -40
                ; 60, 0], string="Order")), 
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.4, 
          y=0.42, 
          width=0.6, 
          height=0.6), 
        Diagram, 
        Documentation(info="The 6th order detailed generator model extends the DetGen class and
corresponds to Model 6 in [1, pp 347], and adds subtransient EMF voltage sources
in both the direct quatradure axes and the field voltage input.

This model includes the damping introduced by damper winding and eddy-currents in
the rotor, and the damping coefficient D should only model the damping
due to friction.

---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
    equation 
      // transient and subtransient equations
      Td0pp*der(Eqpp) = Eqp - Eqpp + id*(xdp - xdpp);
      Tq0pp*der(Edpp) = Edp - Edpp - iq*(xqp - xqpp);
      Td0p*der(Eqp) = Efd - Eqp + id*(xd - xdp);
      Tq0p*der(Edp) = -Edp - iq*(xq - xqp);
      
      // stator equations
      //  vd = Edpp - ra*id - xqpp*iq;
      //  vq = Eqpp + xdpp*id - ra*iq;
      iq = if online then -(vq*ra - Eqpp*ra + xdpp*vd - xdpp*Edpp)/(xdpp*xqpp
         + ra^2) else 0;
      id = if online then -(vd*ra - Edpp*ra - xqpp*vq + xqpp*Eqpp)/(xdpp*xqpp
         + ra^2) else 0;
      
      // electrical power
      Pe = (Edpp*id + Eqpp*iq) + (xdpp - xqpp)*id*iq;
      
    initial equation 
      delta = Modelica.Math.atan2(T.vb - 1/Sbase*Base.Sbase*rt*T.ib - 1/Sbase*
        Base.Sbase*xt*T.ia - 1/Sbase*Base.Sbase*ra*T.ib - 1/Sbase*Base.Sbase*xq
        *T.ia, 1.0 + T.va - 1/Sbase*Base.Sbase*rt*T.ia + 1/Sbase*Base.Sbase*xt*
        T.ib - 1/Sbase*Base.Sbase*ra*T.ia + 1/Sbase*Base.Sbase*xq*T.ib);
      der(Eqp) = 0;
      der(Edp) = 0;
      der(Eqpp) = 0;
      //  der(Edpp) = 0;      
    end DetGen6;
    annotation (Coordsys(
        extent=[0, 0; 442, 394], 
        grid=[1, 1], 
        component=[20, 20]), Window(
        x=0.45, 
        y=0.01, 
        width=0.39, 
        height=0.58, 
        library=1, 
        autolayout=1));
  end Partials;
  
  model Slack "Slack Node" 
    extends Partials.InfiniteBus(isSlack=true);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.13, 
        y=0.08, 
        width=0.6, 
        height=0.6), 
      Icon(Text(extent=[-40, -20; 80, 20], string="Slack"), Text(extent=[-60, 
              100; 100, 60], string="V=%V0,th=%theta0%")), 
      Documentation(info="The slack node model acts as slack bus in initialization or load-flow 
calculations and as an infinite bus during dynamic simulation. 


At least one slack node or detailed generator with its attribute 'isSlack' set to true must be included
in each network model.
"), 
      Diagram);
  end Slack;
  
  model PVNode "PV Node" 
    extends Partials.InfiniteBus(isSlack=false);
    annotation (
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.06, 
        y=0.08, 
        width=0.6, 
        height=0.6), 
      Icon(
        Text(extent=[-40, -20; 80, 20], string="PV"), 
        Text(extent=[-60, 100; 100, 60], string="V=%V0, Pg=%Pg0"), 
        Text(extent=[-60, -60; 100, -100], string="%name")), 
      Documentation(info="The PV node models a load-flow PV node with unlimited reactive
power generation resources.

"), 
      Diagram);
  end PVNode;
  
  model GovExc3rdGen 
    "3rd order generator model with constant mechanical power and field voltage"
     
    
    extends Partials.DetGen3;
    replaceable ObjectStab.Generators.Controllers.ConstPm Gov annotation (
        extent=[12, -96; 32, -76], rotation=0);
    replaceable ObjectStab.Generators.Controllers.ConstEfd Exc annotation (
        extent=[12, 70; 32, 90], rotation=0);
    annotation (
      Diagram(
        Line(points=[-100, 0; -20, 0], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Ellipse(extent=[-20, 40; 60, -40], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Line(points=[80, 40; 80, 80; 34, 80], style(color=0)), 
        Line(points=[-8, 28; -48, 28; -48, 80; 8, 80], style(color=0)), 
        Text(
          extent=[-68, 66; -48, 46], 
          string="Vt", 
          style(color=0)), 
        Text(
          extent=[44, 68; 64, 48], 
          string="Efd", 
          style(color=0)), 
        Line(points=[32, -86; 80, -86; 80, -40; 54, -22], style(color=0, arrow=
                1)), 
        Text(
          extent=[58, -56; 78, -76], 
          string="Pm", 
          style(color=0)), 
        Text(
          extent=[-66, -54; -46, -74], 
          string="w", 
          style(color=0)), 
        Line(points=[-18, -14; -44, -14; -44, -86; 12, -86], style(color=0)), 
        Line(points=[80, 40; 54, 20], style(color=0, arrow=1))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.2, 
        y=0.27, 
        width=0.6, 
        height=0.6), 
      Documentation(info="The 3rd order Generator model extended with governor and exciter

The governor and exciter models can be redeclared with models
from the controller library or used-defined models.

"), 
      Icon);
  equation 
    // connection equations for governor and exciter
    Gov.u = w;
    Pm = Gov.y;
    Exc.u = sqrt(vd^2 + vq^2);
    Efd = Exc.y;
  end GovExc3rdGen;
  
  model GovExc6thGen 
    "6th order generator model with  constant mechanical power and field voltage"
     
    
    extends Partials.DetGen6;
    
    replaceable ObjectStab.Generators.Controllers.ConstPm Gov annotation (
        extent=[12, -96; 32, -76]);
    replaceable ObjectStab.Generators.Controllers.ConstEfd Exc annotation (
        extent=[12, 70; 32, 90]);
    annotation (
      Diagram(
        Line(points=[-100, 0; -20, 0], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Ellipse(extent=[-20, 40; 60, -40], style(
            color=0, 
            pattern=1, 
            thickness=1, 
            arrow=0)), 
        Text(
          extent=[44, 68; 64, 48], 
          string="Efd", 
          style(color=0)), 
        Text(
          extent=[58, -56; 78, -76], 
          string="Pm", 
          style(color=0)), 
        Line(points=[80, 40; 80, 80; 34, 80], style(color=0)), 
        Line(points=[80, 40; 54, 20], style(color=0, arrow=1)), 
        Line(points=[-8, 28; -48, 28; -48, 80; 8, 80], style(color=0)), 
        Text(
          extent=[-68, 66; -48, 46], 
          string="Vt", 
          style(color=0)), 
        Line(points=[32, -86; 80, -86; 80, -40; 54, -22], style(color=0, arrow=
                1)), 
        Line(points=[-18, -14; -44, -14; -44, -86; 12, -86], style(color=0)), 
        Text(
          extent=[-64, -54; -44, -74], 
          string="w", 
          style(color=0))), 
      Coordsys(
        extent=[-100, -100; 100, 100], 
        grid=[2, 2], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6), 
      Documentation(info="The 6th order Generator model extended with governor and exciter

The governor and exciter models can be redeclared with models
from the controller library or used-defined models.

"), 
      Icon);
  equation 
    // connection equations for governor and exciter
    Gov.u = w;
    Pm = Gov.y;
    Exc.u = sqrt(vd^2 + vq^2);
    Efd = Exc.y;
  end GovExc6thGen;
  
  package Controllers "Library for Governor and Excitation system models" 
    extends Modelica.Icons.Library;
    
    package Partials 
      extends Modelica.Icons.Library;
      partial model Exciter 
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Real K=100 "Steady-State Gain";
        parameter Base.Voltage Efmax=Modelica.Constants.inf 
          "Maximum Field Voltage";
        parameter Base.Voltage Efmin=0 "Minimum Field Voltage";
        
        discrete Base.Voltage Vref(start=1);
        discrete Base.Voltage Ef0(start=1);
        Modelica.Blocks.Nonlinear.Limiter Limiter(uMax={Efmax}, uMin={Efmin}) 
          annotation (extent=[74, -10; 94, 10]);
        Modelica.Blocks.Math.Add Verror(k1=-1, k2=1) annotation (extent=[-80, -
              10; -60, 10]);
      equation 
        connect(Limiter.outPort, outPort) annotation (points=[95, 0; 110, 0]);
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100], 
            grid=[2, 2], 
            component=[20, 20]), 
          Window(
            x=0.32, 
            y=0.09, 
            width=0.6, 
            height=0.6), 
          Diagram(Line(points=[-84, -6; -90, -18]), Text(extent=[-100, -20; -80
                  , -28], string="Vref")), 
          Icon(Text(extent=[-80, -20; 80, -60], string="System"), Text(extent=[
                  -80, 60; 80, 20], string="Excitation")));
        connect(inPort, Verror.inPort1) annotation (points=[-124, 0; -92, 0; -
              92, 6; -82, 6], style(color=3));
        Verror.u2 = {Vref};
        Vref = pre(Vref);
      end Exciter;
      
      partial model Governor 
        extends Modelica.Blocks.Interfaces.SISO;
        
        parameter Base.AngularVelocity wref=1;
        parameter Base.MechanicalPower Pmmax=1.05 "Maximum Mechanical Power";
        parameter Base.MechanicalPower Pmmin=0 "Minimum Mechanical Power";
        
      protected 
        discrete Base.MechanicalPower Pm0(start=1, fixed=false) 
          "Initial Mechanical Power (automatically initialized)";
      public 
        Modelica.Blocks.Nonlinear.Limiter Limiter(uMax={Pmmax}, uMin={Pmmin}) 
          annotation (extent=[76, -10; 96, 10]);
        Modelica.Blocks.Math.Add werror(k1=-1, k2=+1) annotation (extent=[-80, 
              -10; -60, 10]);
      equation 
        connect(Limiter.outPort, outPort) annotation (points=[97, 0; 110, 0]);
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
          Diagram(
            Text(extent=[-134, 32; -106, 24], string="w"), 
            Text(extent=[96, 18; 124, 10], string="Pm"), 
            Text(extent=[-100, -20; -80, -28], string="wref"), 
            Line(points=[-84, -6; -90, -18])), 
          Icon(Text(extent=[-80, -20; 80, -60], string="System"), Text(extent=[
                  -80, 60; 80, 20], string="Governing")));
        connect(werror.inPort1, inPort) annotation (points=[-82, 6; -90, 6; -90
              , 0; -128, 0], style(color=3));
        werror.u2 = {wref};
        Pm0 = pre(Pm0);
      end Governor;
      
      model ExcLimiter "Limiter Logic For Excitation System" 
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Real DelayTime=10;
        parameter Real Limit=2.1;
        
        discrete Real countstart(start=1e6, fixed=true);
        //  Integer status1;
        //  Integer status2;
        annotation (Coordsys(
            extent=[-100, -100; 100, 100], 
            grid=[2, 2], 
            component=[20, 20]), Window(
            x=0.13, 
            y=0.07, 
            width=0.6, 
            height=0.6));
        ModelicaAdditions.PetriNets.Transition LimitExc annotation (extent=[-30
              , 20; -10, 40]);
        ModelicaAdditions.PetriNets.Transition LimitOK annotation (extent=[-30
              , -20; -10, 0], rotation=180);
        ModelicaAdditions.PetriNets.Transition TimerExp annotation (extent=[30
              , 20; 50, 40]);
        ModelicaAdditions.PetriNets.Place11 activated annotation (extent=[60, 
              20; 80, 40]);
        ModelicaAdditions.PetriNets.Transition UnActivate annotation (extent=[
              40, -40; 60, -20], rotation=180);
        ModelicaAdditions.PetriNets.Place21 wait(initialState=true) annotation 
          (extent=[-60, 20; -40, 40]);
        ModelicaAdditions.PetriNets.Place12 count annotation (extent=[-2, 20; 
              18, 40]);
      equation 
        connect(LimitExc.inTransition, wait.outTransition) annotation (points=[
              -26, 30; -38, 30], style(color=41));
        connect(LimitExc.outTransition, count.inTransition) annotation (points=
              [-14, 30; -6, 30], style(color=41));
        connect(TimerExp.outTransition, activated.inTransition) annotation (
            points=[44, 30; 58, 30], style(color=41));
        connect(count.outTransition1, LimitOK.inTransition) annotation (points=
              [18, 24; 28, 24; 28, -10; -12, -10], style(color=41));
        connect(activated.outTransition, UnActivate.inTransition) annotation (
            points=[81, 30; 86, 30; 86, -30; 58, -30], style(color=41));
        connect(UnActivate.outTransition, wait.inTransition2) annotation (
            points=[45, -30; -76, -30; -76, 36; -62, 36], style(color=41));
        connect(LimitOK.outTransition, wait.inTransition1) annotation (points=[
              -24, -10; -67, -10; -67, 24; -62, 24], style(color=41));
        connect(count.outTransition2, TimerExp.inTransition) annotation (points
            =[20, 36; 26, 36; 26, 30; 32, 30], style(color=41));
        LimitExc.condition = y > Limit;
        LimitOK.condition = y < (Limit - 1e-5);
        UnActivate.condition = y < (Limit - 1e-5);
        TimerExp.condition = ((time - countstart) > DelayTime) and (y > Limit);
        
        when count.state then
          countstart = time;
          //   status1 = LogVariable(count.state);
        end when;
        when activated.state then
          //  status2 = LogVariable(activated.state);
        end when;
        
        y = if activated.state then min(u, Limit) else u;
      initial equation 
        count.state = false;
        wait.state = true;
        activated.state = false;
      end ExcLimiter;
      annotation (Coordsys(
          extent=[0, 0; 442, 394], 
          grid=[2, 2], 
          component=[20, 20]), Window(
          x=0.45, 
          y=0.01, 
          width=0.39, 
          height=0.58, 
          library=1, 
          autolayout=1));
    end Partials;
    
    model FirstOrderExciter 
      extends Partials.Exciter;
      
      parameter Real T=0.05 "Voltage Regulator Time Constant";
      
      Modelica.Blocks.Continuous.TransferFunction AVR(b={K}, a={T,1}) 
        annotation (extent=[20, -10; 40, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.38, 
          y=0.11, 
          width=0.68, 
          height=0.68), 
        Diagram, 
        Icon);
    equation 
      connect(AVR.outPort, Limiter.inPort) annotation (points=[41, 0; 72, 0], 
          style(color=3));
      connect(Verror.outPort, AVR.inPort) annotation (points=[-59, 0; 16, 0], 
          style(color=3));
      Ef0 = 0;
      
    initial equation 
      der(AVR.x) = {0};
    end FirstOrderExciter;
    
    model FirstOrderGovernor 
      extends Partials.Governor;
      
      parameter Real K=10 "Governor Gain";
      parameter Real T=5;
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.39, 
          y=0.3, 
          width=0.6, 
          height=0.6), 
        Icon, 
        Diagram(Text(extent=[18, -24; 34, -32], string="Pm0"), Line(points=[42
                , -6; 26, -6; 26, -20])));
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.4, 
          y=0.35, 
          width=0.6, 
          height=0.6), 
        Diagram);
      Modelica.Blocks.Continuous.TransferFunction TF(
        b={K}, 
        a={T,1}, 
        x(start={0})) annotation (extent=[-34, -10; -14, 10]);
      Modelica.Blocks.Math.Add PmAdd annotation (extent=[42, -10; 62, 10]);
    equation 
      connect(PmAdd.outPort, Limiter.inPort) annotation (points=[64, 0; 76, 0]
          , style(color=3));
      connect(TF.outPort, PmAdd.inPort1) annotation (points=[-13, 0; -2, 0; -2
            , 6; 40, 6], style(color=3));
      connect(werror.outPort, TF.inPort) annotation (points=[-59, 0; -36, 0], 
          style(color=3));
      PmAdd.u2 = {Pm0};
      
    initial equation 
      der(TF.y) = 0;
    end FirstOrderGovernor;
    
    model ExcST1A 
      extends Partials.Exciter(
        K=200, 
        Efmin=0, 
        Efmax=7);
      
      parameter Real Tr=1.5 "AVR Time Constant";
      parameter Real Kstab=20 "Power System Stabilizer (PSS) Gain";
      parameter Real Tw=10 "Signal Washout Filter Time Constant";
      parameter Real T1=0.05 "PSS Phase Compensation Time Constant 1";
      parameter Real T2=0.02 "PSS Phase Compensation Time Constant 2";
      parameter Real T3=3 "PSS Phase Compensation Time Constant 3";
      parameter Real T4=5.4 "PSS Phase Compensation Time Constant 4";
      
      parameter Real vsmax=0.2 "PSS Maximum Output Limit";
      parameter Real vsmin=-0.2 "PSS Maximum Output Limit";
      
      outer Real w;
      Modelica.Blocks.Continuous.TransferFunction AVR(b={1}, a={Tr,1}) 
        annotation (extent=[-48, -10; -28, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.43, 
          y=0.29, 
          width=0.6, 
          height=0.6), 
        Diagram(
          Rectangle(extent=[-88, -30; 94, -90], style(color=9, pattern=3)), 
          Text(
            extent=[92, -96; 66, -76], 
            string="PSS", 
            style(color=10)), 
          Text(extent=[-112, -56; -92, -64], string="w-1"), 
          Line(points=[-96, -60; -80, -60])), 
        Icon);
      Modelica.Blocks.Math.Add Sum(k1=+K, k2=+K) annotation (extent=[-4, -10; 
            16, 10]);
      Modelica.Blocks.Math.Gain PSSGain(k={Kstab}) annotation (extent=[-80, -70
            ; -60, -50]);
      Modelica.Blocks.Continuous.TransferFunction WashOut(b={Tw,0}, a={Tw,1}) 
        annotation (extent=[-40, -70; -20, -50]);
      Modelica.Blocks.Continuous.TransferFunction Phase_Compensation1(b={T1,1}
          , a={T2,1}) annotation (extent=[0, -70; 20, -50]);
      Modelica.Blocks.Nonlinear.Limiter PSSLimiter(uMax={vsmax}, uMin={vsmin}) 
        annotation (extent=[64, -70; 84, -50]);
      Modelica.Blocks.Continuous.TransferFunction Phase_Compensation2(b={T3,1}
          , a={T4,1}) annotation (extent=[34, -70; 54, -50]);
    equation 
      connect(AVR.outPort, Sum.inPort1) annotation (points=[-27, 0; -18, 0; -18
            , 6; -6, 6]);
      connect(Phase_Compensation1.inPort, WashOut.outPort) annotation (points=[
            -2, -60; -19, -60]);
      connect(PSSLimiter.outPort, Sum.inPort2) annotation (points=[85, -60; 90
            , -60; 90, -34; -18, -34; -18, -6; -6, -6]);
      connect(Phase_Compensation2.inPort, Phase_Compensation1.outPort) 
        annotation (points=[32, -60; 21, -60]);
      connect(Phase_Compensation2.outPort, PSSLimiter.inPort) annotation (
          points=[55, -60; 62, -60]);
      connect(Sum.outPort, Limiter.inPort) annotation (points=[17, 0; 72, 0], 
          style(color=3));
      connect(PSSGain.outPort, WashOut.inPort) annotation (points=[-58, -60; -
            44, -60], style(color=3));
      connect(Verror.outPort, AVR.inPort) annotation (points=[-58, 0; -48, 0], 
          style(color=3));
      PSSGain.u = {w};
      Ef0 = 0;
      
    initial equation 
      der(AVR.y) = 0;
      WashOut.y = 0;
      Phase_Compensation2.y = 0;
      Phase_Compensation1.y = 0;
    end ExcST1A;
    
    model ConstEfd 
      extends Partials.Exciter;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.08, 
          y=0.34, 
          width=0.6, 
          height=0.6), 
        Diagram(Text(
            extent=[-130, 36; -110, 16], 
            string="V", 
            style(color=0)), Text(
            extent=[100, 32; 120, 12], 
            string="Efd", 
            style(color=0))), 
        Icon);
    equation 
      Ef0 = pre(Ef0);
      Limiter.u = {Ef0};
    initial equation 
      Vref = Modelica.Constants.inf;
    end ConstEfd;
    
    model ConstPm 
      extends Partials.Governor;
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.46, 
          y=0.1, 
          width=0.6, 
          height=0.6), 
        Diagram(Text(extent=[48, -20; 64, -28], string="Pm0"), Line(points=[72
                , 0; 56, 0; 56, -14])), 
        Icon);
    equation 
      Limiter.u = {Pm0};
    end ConstPm;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394], 
        grid=[1, 1], 
        component=[20, 20]), 
      Window(
        x=0.4, 
        y=0.4, 
        width=0.6, 
        height=0.6, 
        library=1, 
        autolayout=1), 
      Documentation(info="This library contains sample governor and excitation 
system models

By default generators are declared with constant power
governor and constant field voltage. 

An extended generator model can for example by inheriting from
the basic generator models and augment it with first order
exitation system and governor using the clauses as follows:
 
model NewGen 
  extends ObjectStab.Generators.GovExc6thGen(
    redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc, 
    redeclare ObjectStab.Generators.Controllers.FirstOrderGovernor Gov);
end NewGen;
"));
    model Gover2 
      extends ObjectStab.Generators.Controllers.Partials.Governor(Pmmax=100, 
          Pmmin=-100);
      parameter Base.AngularVelocity wref=1 "Reference Angular Velocity";
      parameter Real Kgov=1 "Governor Gain";
      parameter Real TRH=10;
      parameter Real PROPH=0.3;
      Modelica.Blocks.Continuous.TransferFunction TF(
        b={Kgov*PROPH*TRH,Kgov}, 
        a={TRH,1}, 
        x(start={0})) annotation (extent=[-20, -10; 0, 10]);
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
        Diagram(Line(points=[42, -6; 26, -6; 26, -20]), Text(extent=[18, -24; 
                34, -32], string="Pm0")));
      Modelica.Blocks.Math.Add PmAdd annotation (extent=[42, -10; 62, 10]);
    equation 
      connect(TF.outPort, PmAdd.inPort1) annotation (points=[1, 0; 20.5, 0; 
            20.5, 6; 40, 6], style(color=3));
      connect(Limiter.inPort, PmAdd.outPort) annotation (points=[74, 0; 62, 0]
          , style(color=3));
      connect(werror.outPort, TF.inPort) annotation (points=[-60, 0; -20, 0], 
          style(color=3));
      PmAdd.u2 = {Pm0};
    initial equation 
      der(TF.y) = 0;
    end Gover2;
    
    class IsoGover "Governor Control With Frequency Regulation" 
      extends Partials.Governor;
      
      parameter Base.AngularVelocity wref=1 "Reference Angular Velocity";
      parameter Real Kgov=1 "Governor Gain";
      parameter Real TRH=10;
      parameter Real PROPH=0.3;
      
      parameter Real Tfreq=15;
      
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0, 
          y=0, 
          width=0.6, 
          height=0.6), 
        Diagram);
      Modelica.Blocks.Continuous.TransferFunction Gov(
        b={Kgov*PROPH*TRH,Kgov}, 
        a={TRH,1}, 
        x(start={0})) annotation (extent=[-20, 20; 0, 40]);
      Modelica.Blocks.Continuous.TransferFunction IsoFreq(b={Kgov/Tfreq}, a={1,
            0}) annotation (extent=[-20, -40; 0, -20]);
      Modelica.Blocks.Math.Add3 Add3 annotation (extent=[40, -10; 60, 10]);
    equation 
      connect(werror.outPort, Gov.inPort) annotation (points=[-59, 0; -40, 0; -
            40, 30; -22, 30], style(color=3));
      connect(Add3.outPort, Limiter.inPort) annotation (points=[61, 0; 74, 0], 
          style(color=3));
      connect(Add3.inPort1, Gov.outPort) annotation (points=[36, 8; 16, 8; 16, 
            30; 2, 30], style(color=3));
      connect(werror.outPort, IsoFreq.inPort) annotation (points=[-60, 0; -40, 
            0; -40, -30; -22, -30], style(color=3));
      connect(IsoFreq.outPort, Add3.inPort2) annotation (points=[0, -30; 12, -
            30; 12, 2; 36, 2], style(color=3));
      Add3.inPort3.signal[1] = Pm0;
    initial equation 
      Add3.inPort1.signal[1] = 0;
      Add3.inPort2.signal[1] = 0;
    end IsoGover;
    
    model ExcST1ALim 
      extends Partials.Exciter(
        K=200, 
        Efmin=0, 
        Efmax=7);
      
      parameter Real Tr=1.5 "AVR Time Constant";
      parameter Real Kstab=20 "Power System Stabilizer (PSS) Gain";
      parameter Real Tw=10 "Signal Washout Filter Time Constant";
      parameter Real T1=0.05 "PSS Phase Compensation Time Constant 1";
      parameter Real T2=0.02 "PSS Phase Compensation Time Constant 2";
      parameter Real T3=3 "PSS Phase Compensation Time Constant 3";
      parameter Real T4=5.4 "PSS Phase Compensation Time Constant 4";
      
      parameter Real vsmax=0.2 "PSS Maximum Output Limit";
      parameter Real vsmin=-0.2 "PSS Maximum Output Limit";
      
      outer Real w;
      Modelica.Blocks.Continuous.TransferFunction AVR(b={1}, a={Tr,1}) 
        annotation (extent=[-48, -10; -28, 10]);
      annotation (
        Coordsys(
          extent=[-100, -100; 100, 100], 
          grid=[2, 2], 
          component=[20, 20]), 
        Window(
          x=0.03, 
          y=0.08, 
          width=0.6, 
          height=0.6), 
        Diagram(
          Rectangle(extent=[-88, -30; 94, -90], style(color=9, pattern=3)), 
          Text(
            extent=[92, -96; 66, -76], 
            string="PSS", 
            style(color=10)), 
          Text(extent=[-112, -56; -92, -64], string="w-1"), 
          Line(points=[-96, -60; -80, -60])), 
        Icon);
      Modelica.Blocks.Math.Add Sum(k1=+K, k2=+K) annotation (extent=[-4, -10; 
            16, 10]);
      Modelica.Blocks.Math.Gain PSSGain(k={Kstab}) annotation (extent=[-80, -70
            ; -60, -50]);
      Modelica.Blocks.Continuous.TransferFunction WashOut(b={Tw,0}, a={Tw,1}) 
        annotation (extent=[-40, -70; -20, -50]);
      Modelica.Blocks.Continuous.TransferFunction Phase_Compensation1(b={T1,1}
          , a={T2,1}) annotation (extent=[0, -70; 20, -50]);
      Modelica.Blocks.Nonlinear.Limiter PSSLimiter(uMax={vsmax}, uMin={vsmin}) 
        annotation (extent=[64, -70; 84, -50]);
      Modelica.Blocks.Continuous.TransferFunction Phase_Compensation2(b={T3,1}
          , a={T4,1}) annotation (extent=[34, -70; 54, -50]);
      Partials.ExcLimiter ExcLimit annotation (extent=[36, -10; 56, 10]);
    equation 
      connect(AVR.outPort, Sum.inPort1) annotation (points=[-27, 0; -18, 0; -18
            , 6; -6, 6]);
      connect(WashOut.inPort, PSSGain.outPort) annotation (points=[-42, -60; -
            59, -60]);
      connect(Phase_Compensation1.inPort, WashOut.outPort) annotation (points=[
            -2, -60; -19, -60]);
      connect(PSSLimiter.outPort, Sum.inPort2) annotation (points=[85, -60; 90
            , -60; 90, -34; -18, -34; -18, -6; -6, -6]);
      connect(Phase_Compensation2.inPort, Phase_Compensation1.outPort) 
        annotation (points=[32, -60; 21, -60]);
      connect(Phase_Compensation2.outPort, PSSLimiter.inPort) annotation (
          points=[55, -60; 62, -60]);
      connect(Sum.outPort, ExcLimit.inPort) annotation (points=[16, 0; 36, 0], 
          style(color=3));
      connect(ExcLimit.outPort, Limiter.inPort) annotation (points=[56, 0; 72, 
            0], style(color=3));
      connect(Verror.outPort, AVR.inPort) annotation (points=[-58, 0; -50, 0], 
          style(color=3));
      PSSGain.u = {w};
      Ef0 = 0;
      
    initial equation 
      der(AVR.y) = 0;
      WashOut.y = 0;
      Phase_Compensation2.y = 0;
      Phase_Compensation1.y = 0;
    end ExcST1ALim;
  end Controllers;
  annotation (Coordsys(
      extent=[0, 0; 386, 296], 
      grid=[1, 1], 
      component=[20, 20]), Window(
      x=0.4, 
      y=0.4, 
      width=0.6, 
      height=0.6, 
      library=1, 
      autolayout=1));
end Generators;
