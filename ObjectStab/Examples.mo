within ObjectStab;
package Examples 
  extends Modelica.Icons.Library;
  
  class ninebus "Nine bus test system, using 3rd order generator models" 
    extends ObjectStab.Base.System;
    annotation (
      Coordsys(
        extent=[-110, -80; 112, 80],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
      Diagram(
        Text(extent=[-108, -18; -32, -54], string="ObjectStab"),
        Text(extent=[-108, -34; -32, -70], string=
              "MODELICA library for power systems"),
        Line(points=[38, 10; 38, 10]),
        Line(points=[-42, 10; -42, 10]),
        Line(points=[-2, -50; -2, -50]),
        Line(points=[-2, -50; -2, -50]),
        Line(points=[-2, -50; -2, -50]),
        Line(points=[-2, 50; -2, 58]),
        Line(points=[38, 10; 38, 10]),
        Line(points=[-42, 10; -42, 10]),
        Line(points=[-82, 50; -82, 50]),
        Line(points=[78, 50; 78, 50])),
      Icon,
      Documentation(info="System from [1]

Nine bus test system, using 3rd order generator models
---
[1]
P.M. Anderson and A.A. Fouad, Power System Control and Stability,
ISBN 0-7803-1029-2. IEEE Press, second edition, 1994.
"));
    ObjectStab.Network.Bus Bus1 annotation (extent=[-12, -60; 8, -40], rotation=
         90);
    ObjectStab.Network.Bus Bus2 annotation (extent=[-92, 40; -72, 60]);
    ObjectStab.Network.Bus Bus3 annotation (extent=[68, 40; 88, 60]);
    ObjectStab.Network.FaultedBus Bus4(
      FaultTime=5,
      FaultDuration=1,
      FaultR=1) annotation (extent=[-12, -20; 8, 0], rotation=90);
    ObjectStab.Network.Bus Bus5 annotation (extent=[-52, 0; -32, 20], rotation=
          180);
    ObjectStab.Network.Bus Bus6 annotation (extent=[28, 0; 48, 20], rotation=
          180);
    ObjectStab.Network.Bus Bus7 annotation (extent=[-52, 40; -32, 60]);
    ObjectStab.Network.Bus Bus8 annotation (extent=[-12, 40; 8, 60]);
    ObjectStab.Network.Bus Bus9 annotation (extent=[28, 40; 48, 60]);
    ObjectStab.Network.Pilink L57(
      R=0.032,
      X=0.161,
      B=0.153*2,
      G=0) annotation (extent=[-42, 20; -22, 40], rotation=90);
    ObjectStab.Network.Pilink L69(
      R=0.039,
      X=0.170,
      G=0,
      B=0.179*2) annotation (extent=[18, 20; 38, 40], rotation=90);
    ObjectStab.Network.Pilink L78(
      R=0.0085,
      X=0.072,
      G=0,
      B=0.0745*2) annotation (extent=[-32, 40; -12, 60]);
    ObjectStab.Network.Pilink L89(
      R=0.0119,
      X=0.1008,
      G=0,
      B=0.1045*2) annotation (extent=[8, 40; 28, 60]);
    ObjectStab.Network.FixTransformer T27(R=0, X=0.0625) annotation (extent=[-
          72, 40; -52, 60], rotation=180);
    ObjectStab.Network.FixTransformer T39(R=0, X=0.0586) annotation (extent=[48,
            40; 68, 60]);
    ObjectStab.Network.FixTransformer T14(R=0, X=0.0576) annotation (extent=[-
          12, -40; 8, -20], rotation=270);
    ObjectStab.Network.Pilink L45(
      R=0.01,
      X=0.085,
      B=0.088*2,
      G=0) annotation (extent=[-32, 0; -12, 20]);
    ObjectStab.Network.Pilink L46(
      R=0.017,
      X=0.092,
      B=0.079*2,
      G=0) annotation (extent=[8, 0; 28, 20]);
    ObjectStab.Generators.GovExc3rdGen G2(
      V0=1.025,
      Pg0=1.63,
      Sbase=200,
      H=6.40,
      xd=0.8958,
      xq=0.8645,
      xdp=0.1198,
      Td0p=6,
      redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc) 
      annotation (extent=[-102, 60; -82, 40], rotation=180);
    ObjectStab.Generators.GovExc3rdGen G3(
      isSlack=false,
      V0=1.025,
      Pg0=0.85,
      H=3.01,
      xd=1.3125,
      xq=1.2578,
      xdp=0.1813,
      Td0p=5.89,
      redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc) 
      annotation (extent=[98, 60; 78, 40], rotation=180);
    annotation (extent=[100, 20; 120, 40]);
    ObjectStab.Loads.DynLoad LoadA(P0=1.25, Q0=0.5) annotation (extent=[-42, 0;
            -62, 20]);
    ObjectStab.Loads.DynLoad LoadC(P0=1, Q0=0.35) annotation (extent=[-12, 58;
          8, 78], rotation=90);
    ObjectStab.Loads.DynLoad LoadB(P0=0.9, Q0=0.3) annotation (extent=[38, 0;
          58, 20]);
    ObjectStab.Generators.Slack G1(V0=1.04) annotation (extent=[-12, -70; 8, -
          50], rotation=270);
  equation 
    connect(T14.T2, Bus1.T) annotation (points=[-2, -40; -2, -50]);
    connect(Bus5.T, L45.T1) annotation (points=[-42, 10; -32, 10]);
    connect(Bus6.T, L46.T2) annotation (points=[38, 10; 28, 10]);
    connect(Bus5.T, L57.T1) annotation (points=[-42, 10; -32, 20]);
    connect(L57.T2, Bus7.T) annotation (points=[-32, 40; -42, 50]);
    connect(L69.T2, Bus9.T) annotation (points=[28, 40; 38, 50]);
    connect(L69.T1, Bus6.T) annotation (points=[28, 20; 38, 10]);
    connect(L78.T2, Bus8.T) annotation (points=[-12, 50; -2, 50]);
    connect(L78.T1, Bus7.T) annotation (points=[-32, 50; -42, 50]);
    connect(L89.T1, Bus8.T) annotation (points=[8, 50; -2, 50]);
    connect(L89.T2, Bus9.T) annotation (points=[28, 50; 38, 50]);
    connect(T27.T1, Bus7.T) annotation (points=[-52, 50; -42, 50]);
    connect(Bus2.T, T27.T2) annotation (points=[-82, 50; -72, 50]);
    connect(T39.T1, Bus9.T) annotation (points=[48, 50; 38, 50]);
    connect(T39.T2, Bus3.T) annotation (points=[68, 50; 78, 50]);
    connect(G2.T, Bus2.T) annotation (points=[-82, 50; -82, 50]);
    connect(G3.T, Bus3.T) annotation (points=[78, 50; 78, 50]);
    connect(Bus4.T, L46.T1) annotation (points=[-2, -10; 8, 10]);
    connect(Bus4.T, L45.T2) annotation (points=[-2, -10; -12, 10]);
    connect(Bus4.T, T14.T1) annotation (points=[-2, -10; -2, -18; -2, -20]);
    connect(LoadB.T, Bus6.T) annotation (points=[38, 10; 38, 10]);
    connect(LoadA.T, Bus5.T) annotation (points=[-42, 10; -42, 10]);
    connect(Bus8.T, LoadC.T) annotation (points=[-2, 50; -2, 58]);
    connect(G1.T, Bus1.T) annotation (points=[-2, -50; -2, -50]);
  end ninebus;
  annotation (Coordsys(
      extent=[0, 0; 382, 300],
      grid=[1, 1],
      component=[20, 20]), Window(
      x=0.4,
      y=0.4,
      width=0.6,
      height=0.6,
      library=1,
      autolayout=1));
  class TCULExamp 
    extends ObjectStab.Base.System;
    
    annotation (
      Icon,
      Coordsys(
        extent=[-100, -100; 100, 100],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.45,
        y=0.01,
        width=0.44,
        height=0.65),
      Diagram);
    ObjectStab.Network.Bus Bus1 annotation (extent=[-70, 60; -50, 80], rotation=
         180);
    ObjectStab.Network.Bus Bus2 annotation (extent=[-30, 60; -10, 80], rotation=
         180);
    ObjectStab.Network.Bus Bus3 annotation (extent=[-40, 20; 40, 40], rotation=
          270);
    ObjectStab.Network.Bus Bus4 annotation (extent=[10, 60; 30, 80], rotation=
          180);
    ObjectStab.Network.Bus Bus5 annotation (extent=[-10, -20; 10, 0], rotation=
          270);
    ObjectStab.Network.Bus Bus6 annotation (extent=[20, -20; 40, 0], rotation=
          270);
    ObjectStab.Generators.Slack Slack1 annotation (extent=[20, 60; 40, 80]);
    ObjectStab.Generators.GovExc6thGen Gen(
      V0=1.05,
      Pg0=1,
      Sbase=200,
      redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc,
      redeclare ObjectStab.Generators.Controllers.IsoGover Gov) annotation (
        extent=[-80, 60; -60, 80], rotation=180);
    ObjectStab.Loads.ImpedanceLoad ImpedanceLoad1 annotation (extent=[-10, -30;
            10, -10], rotation=270);
    ObjectStab.Loads.ImpedanceLoad ImpedanceLoad2 annotation (extent=[20, -30;
          40, -10], rotation=270);
    ObjectStab.Network.ShuntCapacitor ShuntCapacitor1(B=0.6) annotation (extent=
         [-36, 10; -16, 30], rotation=270);
    ObjectStab.Network.OpenedPilink OpenedPilink1 annotation (extent=[-10, 60;
          10, 80]);
    ObjectStab.Network.Pilink Line1(X=0.2) annotation (extent=[-50, 60; -30, 80]);
    ObjectStab.Network.Pilink Line4(X=0.02, B=0.05) annotation (extent=[-20, 40;
            0, 60], rotation=90);
    ObjectStab.Network.TCULDis T1(Controller(InitByVoltage=true)) annotation (
        extent=[-10, 0; 10, 20], rotation=270);
    ObjectStab.Network.TCULCon T2(n=1, Controller(InitByVoltage=true)) 
      annotation (extent=[20, 0; 40, 20], rotation=270);
  equation 
    connect(Bus4.T, Slack1.T) annotation (points=[20, 70; 20, 70]);
    connect(T1.T2, Bus5.T) annotation (points=[-1.77636e-015, 0; 0, -10]);
    connect(ImpedanceLoad1.T, Bus5.T) annotation (points=[1.77636e-015, -10; 0,
            -10]);
    connect(ImpedanceLoad2.T, Bus6.T) annotation (points=[30, -10; 30, -10]);
    connect(T2.T2, Bus6.T) annotation (points=[30, 0; 30, -10]);
    connect(Line4.T1, Bus3.T) annotation (points=[-10, 40; -10, 30; 0, 30]);
    connect(T2.T1, Bus3.T) annotation (points=[30, 20; 30, 30; 0, 30]);
    connect(Bus3.T, ShuntCapacitor1.T) annotation (points=[0, 30; -26, 30]);
    connect(T1.T1, Bus3.T) annotation (points=[1.77636e-015, 20; 0, 30]);
    connect(Bus4.T, OpenedPilink1.T2) annotation (points=[20, 70; 10, 70]);
    connect(Line4.T2, Bus2.T) annotation (points=[-10, 60; -20, 70]);
    connect(OpenedPilink1.T1, Bus2.T) annotation (points=[-10, 70; -20, 70]);
    connect(Line1.T2, Bus2.T) annotation (points=[-30, 70; -20, 70]);
    connect(Bus1.T, Line1.T1) annotation (points=[-60, 70; -50, 70]);
    connect(Gen.T, Bus1.T) annotation (points=[-60, 70; -60, 70]);
  end TCULExamp;
  
  package BPA 
    extends Modelica.Icons.Example;
    
    model BPAGen 
      extends ObjectStab.Generators.GovExc6thGen(
        ra=0,
        D=0,
        xd=2.07,
        xq=1.99,
        xdp=0.28,
        xqp=0.49,
        xdpp=0.215,
        xqpp=0.215,
        Td0p=4.10,
        Tq0p=0.56,
        Td0pp=0.033,
        Tq0pp=0.062,
        redeclare ObjectStab.Generators.Controllers.FirstOrderGovernor Gov,
        redeclare ObjectStab.Generators.Controllers.ExcST1ALim Exc(
          K=200,
          Kstab=1,
          ExcLimit(Limit=2.9)));
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    end BPAGen;
    
    class system 
      extends ObjectStab.Base.System;
      Real Ploss;
      Real Qloss;
      Real Pload;
      Real Qload;
      
      BPAGen G2(
        V0=0.9646,
        Pg0=17.36,
        Sbase=2200,
        H=2.33,
        D=0.2) annotation (extent=[-100, -20; -80, 0], rotation=180);
      BPAGen G3(
        V0=0.9553,
        Pg0=11.55,
        Sbase=1600,
        H=2.09,
        D=0.2) annotation (extent=[60, 60; 80, 80]);
      annotation (
        Coordsys(
          extent=[-140, -60; 160, 120],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6),
        Diagram);
      replaceable ObjectStab.Loads.DynLoad L8(
        P0=33.7,
        Q0=10.5,
        as=0,
        at=2,
        bs=0,
        bt=2,
        Tp=1,
        Tq=1) annotation (extent=[60, 20; 80, 40]);
      replaceable ObjectStab.Loads.ImpedanceLoad L11(P0=34.9, Q0=0) annotation (
         extent=[130, -40; 152, -20]);
      ObjectStab.Network.Bus Bus1 annotation (extent=[-120, 60; -100, 80]);
      ObjectStab.Network.Bus Bus2 annotation (extent=[-80, -20; -60, 0]);
      ObjectStab.Network.Bus Bus3 annotation (extent=[40, 60; 60, 80]);
      ObjectStab.Network.Bus Bus5 annotation (extent=[-80, 60; -60, 80]);
      ObjectStab.Network.Bus Bus6 annotation (extent=[-40, -60; -20, 100],
          rotation=180);
      ObjectStab.Network.Bus Bus7 annotation (extent=[0, -60; 20, 100],
          rotation=180);
      ObjectStab.Network.Bus Bus8 annotation (extent=[40, 20; 60, 40]);
      ObjectStab.Network.Bus Bus9 annotation (extent=[40, -40; 60, -20]);
      ObjectStab.Network.Bus Bus10 annotation (extent=[80, -40; 100, -20]);
      ObjectStab.Network.Bus Bus11 annotation (extent=[120, -40; 140, -20]);
      ObjectStab.Network.ShuntCapacitor C7(B=9.63) annotation (extent=[-10, -54;
              10, -34], rotation=270);
      ObjectStab.Network.ShuntCapacitor C8(B=7) annotation (extent=[30, 0; 50,
            20], rotation=270);
      ObjectStab.Network.ShuntCapacitor C9(B=4) annotation (extent=[30, -54; 50,
              -34], rotation=270);
      ObjectStab.Network.ShuntCapacitor C11(B=1) annotation (extent=[110, -54;
            130, -34], rotation=270);
      ObjectStab.Network.FixTransformer T1(X=0.0020, n=0.8857) annotation (
          extent=[-100, 60; -80, 80], rotation=180);
      ObjectStab.Network.FixTransformer T2(X=0.0045, n=0.8857) annotation (
          extent=[-60, -20; -40, 0], rotation=180);
      ObjectStab.Network.FixTransformer T3(X=0.0125/2, n=0.9024) annotation (
          extent=[20, 60; 40, 80]);
      ObjectStab.Network.FixTransformer T5(X=0.0026, n=1.08) annotation (extent=
           [20, -40; 40, -20], rotation=180);
      replaceable ObjectStab.Network.TCULDis T6(
        X=0.0010,
        n=1/0.96,
        Controller(
          method=3,
          Vref=0.922,
          maxtap=15,
          mintap=-15,
          stepsize=0.01,
          DB=0.02,
          Vblock=0.01)) annotation (extent=[102, -40; 122, -20]);
      ObjectStab.Network.Pilink L56(
        R=0,
        X=0.0040,
        B=2) annotation (extent=[-60, 60; -40, 80]);
      replaceable ObjectStab.Extras.PQPilink L67_1(
        R=0.0015,
        X=0.0288,
        B=1.1730) annotation (extent=[-20, 60; 0, 80]);
      replaceable ObjectStab.Extras.PQPilink L67_2(
        R=0.0015,
        X=0.0288,
        B=1.1730) annotation (extent=[-20, 40; 0, 60]);
      replaceable ObjectStab.Extras.PQPilink L67_3(
        R=0.0015,
        X=0.0288,
        B=1.1730) annotation (extent=[-20, 20; 0, 40]);
      replaceable ObjectStab.Extras.PQPilink L67_4(
        R=0.0015,
        X=0.0288,
        B=1.1730) annotation (extent=[-20, 0; 0, 20]);
      replaceable ObjectStab.Extras.PQPilink L67_5(
        R=0.0015,
        X=0.0288,
        B=1.1730) annotation (extent=[-20, -20; 0, 0]);
      ObjectStab.Network.Impedance L910(R=0.0010, X=0.0030) annotation (extent=
            [60, -40; 80, -20]);
      ObjectStab.Network.FixTransformer T4(X=0.0030, n=1.0664) annotation (
          extent=[20, 20; 40, 40], rotation=180);
      ObjectStab.Generators.Slack G1(V0=0.98) annotation (extent=[-140, 60; -
            120, 80], rotation=180);
    equation 
      connect(L910.T1, Bus9.T) annotation (points=[60, -30; 54, -30; 50, -30]);
      connect(L910.T2, Bus10.T) annotation (points=[80, -30; 90, -30]);
      connect(L11.T, Bus11.T) annotation (points=[130, -30; 130, -30]);
      connect(G3.T, Bus3.T) annotation (points=[60, 70; 50, 70]);
      connect(L67_1.T1, Bus6.T) annotation (points=[-20, 70; -30, 70; -30, 20]);
      connect(L67_2.T1, Bus6.T) annotation (points=[-20, 50; -30, 50; -30, 20]);
      connect(C7.T, Bus7.T) annotation (points=[1.77636e-015, -34; 0, -30; 10,
            -30; 10, 20]);
      connect(L67_1.T2, Bus7.T) annotation (points=[0, 70; 10, 70; 10, 20]);
      connect(L67_2.T2, Bus7.T) annotation (points=[0, 50; 10, 50; 10, 20]);
      connect(L8.T, Bus8.T) annotation (points=[60, 30; 50, 30]);
      connect(L8.T, Bus8.T) annotation (points=[60, 30; 50, 30]);
      connect(L67_4.T1, Bus6.T) annotation (points=[-20, 10; -30, 10; -30, 20]);
      connect(L67_4.T2, Bus7.T) annotation (points=[0, 10; 10, 10; 10, 20]);
      connect(L67_5.T1, Bus6.T) annotation (points=[-20, -10; -30, -10; -30, 10;
              -30, 20]);
      connect(L67_5.T2, Bus7.T) annotation (points=[0, -10; 10, -10; 10, 20]);
      connect(L56.T1, Bus5.T) annotation (points=[-60, 70; -70, 70]);
      connect(L56.T2, Bus6.T) annotation (points=[-40, 70; -30, 70; -30, 20]);
      connect(L67_3.T1, Bus6.T) annotation (points=[-20, 30; -30, 30; -30, 20]);
      connect(T1.T2, Bus1.T) annotation (points=[-100, 70; -110, 70]);
      connect(T1.T1, Bus5.T) annotation (points=[-80, 70; -72, 70; -70, 70]);
      connect(T3.T1, Bus7.T) annotation (points=[20, 70; 10, 70; 10, 20]);
      connect(L67_3.T2, Bus7.T) annotation (points=[0, 30; 10, 30; 10, 10; 10,
            20]);
      connect(T3.T2, Bus3.T) annotation (points=[40, 70; 50, 70]);
      connect(G2.T, Bus2.T) annotation (points=[-80, -10; -70, -10]);
      connect(Bus2.T, T2.T2) annotation (points=[-70, -10; -60, -10]);
      connect(T2.T1, Bus6.T) annotation (points=[-40, -10; -30, -10; -30, 20]);
      connect(C8.T, Bus8.T) annotation (points=[40, 20; 40, 26; 50, 26; 50, 30]);
      connect(C11.T, Bus11.T) annotation (points=[120, -34; 130, -34; 130, -30]);
      connect(C9.T, Bus9.T) annotation (points=[40, -34; 50, -34; 50, -34; 50,
            -30]);
      connect(T6.T1, Bus10.T) annotation (points=[102, -30; 90, -30]);
      connect(T6.T2, Bus11.T) annotation (points=[122, -30; 130, -30]);
      connect(T5.T2, Bus7.T) annotation (points=[20, -30; 10, -30; 10, 20]);
      connect(T5.T1, Bus9.T) annotation (points=[40, -30; 50, -30]);
      connect(T4.T2, Bus7.T) annotation (points=[20, 30; 10, 30; 10, 20]);
      connect(T4.T1, Bus8.T) annotation (points=[40, 30; 50, 30]);
      connect(G1.T, Bus1.T) annotation (points=[-120, 70; -110, 70]);
      Ploss = L67_1.Ploss + L67_2.Ploss + L67_3.Ploss + L67_4.Ploss + L67_5.
        Ploss;
      Qloss = L67_1.Qloss + L67_2.Qloss + L67_3.Qloss + L67_4.Qloss + L67_5.
        Qloss;
      Pload = L8.Pl + L11.Pl;
      Qload = L8.Ql + L11.Ql;
    end system;
    
    model linefault 
      extends system(redeclare ObjectStab.Extras.FaultedPQPilink L67_5(
          FaultTime=10,
          FaultR=0,
          FaultX=0,
          ClearTime=0.07,
          RecloseTime=30000));
      annotation (Coordsys(
          extent=[-140, -60; 160, 120],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65));
    end linefault;
    
    model loadshed 
      extends linefault(redeclare Extras.UVLSLoad L8(
          Relay1(
            ShedAmount=0.05,
            Threshold=0.82,
            DelayTime=4.5),
          Relay2(
            ShedAmount=0.05,
            Threshold=0.80,
            DelayTime=3),
          Relay3(
            ShedAmount=0.05,
            Threshold=0.78,
            DelayTime=1.5)));
      annotation (Coordsys(
          extent=[-140, -60; 160, 120],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65));
    end loadshed;
    
    model taplock 
      extends linefault(T6(Controller(
            method=3,
            Vref=0.922,
            maxtap=15,
            mintap=-15,
            stepsize=0.01,
            DB=0.02,
            Vblock=0.82)));
      annotation (Coordsys(
          extent=[-140, -60; 160, 120],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    end taplock;
    annotation (Coordsys(
        extent=[0, 0; 442, 394],
        grid=[1, 1],
        component=[20, 20]), Window(
        x=0,
        y=0.6,
        width=0.4,
        height=0.4,
        library=1,
        autolayout=1));
  end BPA;
  
  package Kundur126 "Example 12.6 from Kundur's book" 
    extends Modelica.Icons.Library;
    
    model Gen 
      //  extends ObjectStab.Generators.GovExc6thGen(
      extends ObjectStab.Extras.GovExcKundurGen(
        D=0,
        rt=0,
        xt=0,
        ra=0.0025,
        xd=1.8,
        xq=1.7,
        xdp=0.3,
        xqp=0.55,
        xdpp=0.25,
        xqpp=0.25,
        Td0p=8,
        Tq0p=0.4,
        Td0pp=0.03,
        Tq0pp=0.05,
        redeclare ObjectStab.Generators.Controllers.ExcST1A Exc(
          Kstab=20,
          Tw=10,
          T1=0.05,
          T2=0.02,
          Tr=0.01,
          vsmax=0.2,
          vsmin=-0.2,
          K=200,
          Efmin=-6.4,
          Efmax=7,
          T3=3,
          T4=5.4),
        redeclare ObjectStab.Generators.Controllers.FirstOrderGovernor Gov);
      
      annotation (Coordsys(
          extent=[-100, -100; 100, 100],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6));
    end Gen;
    
    class system 
      extends ObjectStab.Base.System;
      annotation (
        Coordsys(
          extent=[-200, -200; 200, 200],
          grid=[2, 2],
          component=[20, 20]),
        Window(
          x=0,
          y=0.37,
          width=0.6,
          height=0.6),
        Diagram(Line(points=[164, 168; 164, 168]), Line(points=[94, 128; 94,
                128])));
      Gen G1(
        V0=1.03,
        Pg0=7,
        Sbase=900,
        H=6.5) annotation (extent=[-196, 148; -156, 188], rotation=180);
      Gen G2(
        V0=1.01,
        Pg0=7,
        Sbase=900,
        H=6.5) annotation (extent=[-106, 88; -66, 128], rotation=270);
      Gen G3(
        V0=1.03,
        theta0=-6.8*Modelica.Constants.pi/180,
        Pg0=7,
        Sbase=900,
        H=6.175,
        isSlack=true) annotation (extent=[162, 148; 204, 188]);
      Gen G4(
        V0=1.01,
        Pg0=7,
        Sbase=900,
        H=6.175) annotation (extent=[74, 92; 114, 132], rotation=270);
      ObjectStab.Network.FixTransformer T15(X=0.15/9) annotation (extent=[-146,
              158; -126, 178]);
      ObjectStab.Network.Bus Bus1 annotation (extent=[-166, 158; -146, 178]);
      ObjectStab.Network.Bus Bus2 annotation (extent=[-96, 118; -76, 138],
          rotation=90);
      ObjectStab.Network.FixTransformer T26(X=0.15
                                                 /9) annotation (extent=[-96,
            138; -76, 158], rotation=90);
      ObjectStab.Network.Bus Bus5 annotation (extent=[-126, 158; -106, 178]);
      ObjectStab.Network.Bus Bus6 annotation (extent=[-86, 158; -66, 178]);
      ObjectStab.Network.Pilink L56(
        R=0.0001*25,
        X=0.001*25,
        B=0.00175*25) annotation (extent=[-106, 158; -86, 178]);
      ObjectStab.Network.Pilink L67(
        R=0.0001*10,
        X=0.001*10,
        B=0.00175*10) annotation (extent=[-66, 158; -46, 178]);
      ObjectStab.Loads.ZIPLoad L7(
        P0=9.67,
        Q0=1,
        pZ=0,
        pI=1,
        qZ=1,
        qI=0) annotation (extent=[-56, 138; -36, 158], rotation=270);
      replaceable ObjectStab.Network.Pilink L78_1(
        R=0.0001*110,
        X=0.001*110,
        B=0.00175*110) annotation (extent=[-26, 168; -6, 188]);
      ObjectStab.Network.Bus Bus8 annotation (extent=[-6, 148; 14, 188],
          rotation=180);
      ObjectStab.Network.Pilink L78_2(
        R=0.0001*110,
        X=0.001*110,
        B=0.00175*110) annotation (extent=[-26, 148; -6, 168]);
      ObjectStab.Network.Bus Bus7 annotation (extent=[-46, 148; -26, 188],
          rotation=180);
      ObjectStab.Network.Bus Bus9 annotation (extent=[34, 148; 54, 188],
          rotation=180);
      ObjectStab.Network.Pilink L89_1(
        R=0.0001*110,
        X=0.001*110,
        B=0.00175*110) annotation (extent=[14, 168; 34, 188]);
      ObjectStab.Network.Pilink L89_2(
        R=0.0001*110,
        X=0.001*110,
        B=0.00175*110) annotation (extent=[14, 148; 34, 168]);
      ObjectStab.Network.Pilink L910(
        R=0.0001*10,
        X=0.001*10,
        B=0.00175*10) annotation (extent=[54, 158; 74, 178]);
      ObjectStab.Network.Bus Bus10 annotation (extent=[74, 158; 94, 178]);
      ObjectStab.Network.FixTransformer T410(X=0.15
                                                  /9) annotation (extent=[84,
            138; 104, 158], rotation=90);
      ObjectStab.Network.Bus Bus4 annotation (extent=[84, 118; 104, 138],
          rotation=90);
      ObjectStab.Network.Pilink L1011(
        R=0.0001*25,
        X=0.001*25,
        B=0.00175*25) annotation (extent=[94, 158; 114, 178]);
      ObjectStab.Network.FixTransformer T311(X=0.15/9) annotation (extent=[134,
              158; 154, 178]);
      ObjectStab.Network.Bus Bus3 annotation (extent=[154, 158; 174, 178]);
      ObjectStab.Loads.ZIPLoad L9(
        P0=17.67,
        Q0=1,
        pZ=0,
        pI=1,
        qZ=1,
        qI=0) annotation (extent=[44, 138; 64, 158], rotation=270);
      ObjectStab.Network.ShuntCapacitor C7(B=2) annotation (extent=[-36, 130; -
            16, 150], rotation=270);
      ObjectStab.Network.ShuntCapacitor C9(B=3.5) annotation (extent=[26, 132;
            46, 152], rotation=270);
      ObjectStab.Network.Bus Bus11 annotation (extent=[114, 158; 134, 178]);
    equation 
      connect(T15.T1, Bus1.T) annotation (points=[-146, 168; -156, 168]);
      connect(Bus1.T, G1.T) annotation (points=[-156, 168; -156, 168]);
      connect(G2.T, Bus2.T) annotation (points=[-86, 128; -86, 128]);
      connect(T26.T1, Bus2.T) annotation (points=[-86, 138; -86, 128]);
      connect(Bus5.T, T15.T2) annotation (points=[-116, 168; -126, 168]);
      connect(Bus5.T, L56.T1) annotation (points=[-116, 168; -106, 168]);
      connect(L56.T2, Bus6.T) annotation (points=[-86, 168; -76, 168]);
      connect(T26.T2, Bus6.T) annotation (points=[-86, 158; -86, 162; -76, 162;
              -76, 168]);
      connect(Bus6.T, L67.T1) annotation (points=[-76, 168; -64, 168; -66, 168]);
      connect(L78_1.T2, Bus8.T) annotation (points=[-6, 178; 4, 178; 4, 168]);
      connect(L78_2.T2, Bus8.T) annotation (points=[-6, 158; 4, 158; 4, 168]);
      connect(L67.T2, Bus7.T) annotation (points=[-46, 168; -36, 168]);
      connect(Bus7.T, L78_1.T1) annotation (points=[-36, 168; -36, 178; -26,
            178]);
      connect(L78_2.T1, Bus7.T) annotation (points=[-26, 158; -36, 158; -36,
            168]);
      connect(L89_2.T1, Bus8.T) annotation (points=[14, 158; 4, 158; 4, 168]);
      connect(L89_1.T1, Bus8.T) annotation (points=[14, 178; 4, 178; 4, 168]);
      connect(L89_1.T2, Bus9.T) annotation (points=[34, 178; 44, 178; 44, 168]);
      connect(L89_2.T2, Bus9.T) annotation (points=[34, 158; 44, 158; 44, 168]);
      connect(L910.T1, Bus9.T) annotation (points=[54, 168; 44, 168]);
      connect(Bus10.T, L910.T2) annotation (points=[84, 168; 74, 168]);
      connect(L7.T, Bus7.T) annotation (points=[-46, 158; -36, 158; -36, 168]);
      connect(Bus4.T, T410.T1) annotation (points=[94, 128; 94, 138]);
      connect(T410.T2, Bus10.T) annotation (points=[94, 158; 94, 162; 84, 162;
            84, 168]);
      connect(L1011.T1, Bus10.T) annotation (points=[94, 168; 84, 168]);
      connect(Bus3.T, T311.T2) annotation (points=[164, 168; 154, 168]);
      connect(L9.T, Bus9.T) annotation (points=[54, 158; 44, 168]);
      connect(G4.T, Bus4.T) annotation (points=[94, 132; 94, 128]);
      connect(G3.T, Bus3.T) annotation (points=[162, 168; 164, 168]);
      connect(C7.T, Bus7.T) annotation (points=[-26, 150; -36, 158; -36, 168]);
      connect(C9.T, Bus9.T) annotation (points=[36, 152; 44, 158; 44, 168]);
      connect(Bus11.T, L1011.T2) annotation (points=[124, 168; 114, 168]);
      connect(Bus11.T, T311.T1) annotation (points=[124, 168; 134, 168]);
    end system;
    
    model linefault 
      extends system(redeclare ObjectStab.Network.FaultedPilink L78_1(
          FaultTime=2,
          alpha=0.5,
          FaultR=0.01,
          FaultX=0,
          ClearTime=0.07,
          RecloseTime=3.5));
      output Real V=Bus8.V;
      annotation (Coordsys(
          extent=[-196, -100; 204, 188],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65));
    end linefault;
    
    model lineopen 
      extends system(redeclare ObjectStab.Network.OpenedPilink L78_1(OpenTime=2,
              CloseTime=5));
      annotation (Coordsys(
          extent=[-196, -100; 204, 188],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.45,
          y=0.01,
          width=0.44,
          height=0.65));
    end lineopen;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[1, 1],
        component=[20, 20]),
      Window(
        x=0.45,
        y=0.01,
        width=0.39,
        height=0.58,
        library=1,
        autolayout=1),
      Documentation(info=" 
"));
  end Kundur126;
  
  package Nordic32 "Nordic 32 test system" 
    extends Modelica.Icons.Library;
    package Models 
      extends Modelica.Icons.Library;
      
      model SI4SO 
        extends Modelica.Blocks.Interfaces.BlockIcon;
        
      public 
        Modelica.Blocks.Interfaces.RealInput inPort1
          annotation (extent=[-140,60; -100,100]);
        Modelica.Blocks.Interfaces.RealInput inPort2
          annotation (extent=[-140,10; -100,50]);
        Modelica.Blocks.Interfaces.RealInput inPort3
          annotation (extent=[-140,-50; -100,-10]);
        Modelica.Blocks.Interfaces.RealInput inPort4
          annotation (extent=[-140,-100; -100,-60]);
        Modelica.Blocks.Interfaces.RealOutput outPort
          annotation (extent=[100,-10; 120,10]);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      protected 
        Real u1=inPort1 "Input signal 1";
        Real u2=inPort2 "Input signal 2";
        Real u3=inPort3 "Input signal 3";
        Real u4=inPort4 "Input signal 4";
        Real y=outPort "Output signal";
      end SI4SO;
      
      model Limiter 
        extends SI4SO;
        
        parameter Real Limitf=3.74;
        parameter Real Tdf=20;
        parameter Real Taf=120e6;
        parameter Real Kf=20;
        parameter Real Limits=1.05;
        parameter Real Tds=20;
        parameter Real Tas=120e6;
        parameter Real Ks=2;
        
        ObjectStab.Base.Time counterf(start=1e6, fixed=true);
        ObjectStab.Base.Time counters(start=1e6, fixed=true);
      protected 
        Real fcorr(start=1e3);
        Real scorr(start=1e3);
        
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
          Diagram(Text(extent=[-84, 94; -18, 76], string="Field Limiter Logic"),
                Text(extent=[18, 96; 84, 78], string="Stator Limiter Logic")));
      public 
        ObsoletePetriNets.PetriNets.Transition Tr1f annotation (extent=[-60, 12;
                -40, 32], rotation=270);
        ObsoletePetriNets.PetriNets.Place12 countf annotation (extent=[-60, -20;
                -40, 0], rotation=270);
        ObsoletePetriNets.PetriNets.Transition Tr2f annotation (extent=[-80, -
              50; -60, -30], rotation=270);
        ObsoletePetriNets.PetriNets.Place21 waitf(initialState=true) 
          annotation (extent=[-60, 40; -40, 60], rotation=270);
        ObsoletePetriNets.PetriNets.Place11 activatef annotation (extent=[-80,
              -80; -60, -60], rotation=270);
        ObsoletePetriNets.PetriNets.Transition Tr3f annotation (extent=[-100, -
              20; -80, 0], rotation=90);
        ObsoletePetriNets.PetriNets.Transition Tr4f annotation (extent=[-20, -
              20; 0, 0], rotation=90);
        ObsoletePetriNets.PetriNets.Transition Tr1s annotation (extent=[44, 12;
                64, 32], rotation=270);
        ObsoletePetriNets.PetriNets.Place12 counts annotation (extent=[44, -20;
                64, 0], rotation=270);
        ObsoletePetriNets.PetriNets.Transition Tr2s annotation (extent=[24, -50;
                44, -30], rotation=270);
        ObsoletePetriNets.PetriNets.Place21 waits(initialState=true) 
          annotation (extent=[44, 40; 64, 60], rotation=270);
        ObsoletePetriNets.PetriNets.Place11 activates annotation (extent=[24, -
              80; 44, -60], rotation=270);
        ObsoletePetriNets.PetriNets.Transition Tr3s annotation (extent=[4, -20;
                24, 0], rotation=90);
        ObsoletePetriNets.PetriNets.Transition Tr4s annotation (extent=[84, -20;
                104, 0], rotation=90);
      equation 
        connect(countf.inTransition, Tr1f.outTransition) annotation (points=[-
              50, 2; -50, 17]);
        connect(Tr1f.inTransition, waitf.outTransition) annotation (points=[-
              50.05, 28.05; -50, 39]);
        connect(Tr2f.inTransition, countf.outTransition1) annotation (points=[-
              70.05, -33.95; -70, -26; -56, -26; -56, -21]);
        connect(activatef.inTransition, Tr2f.outTransition) annotation (points=
              [-70, -58; -70, -45]);
        connect(activatef.outTransition, Tr3f.inTransition) annotation (points=
              [-70, -81; -70, -92; -90, -92; -89.95, -16.05]);
        connect(Tr3f.outTransition, waitf.inTransition1) annotation (points=[-
              90, -5; -90, 72; -56, 72; -56, 62]);
        connect(Tr4f.inTransition, countf.outTransition2) annotation (points=[-
              9.95, -16.05; -10, -30; -44, -30; -44, -21.1]);
        connect(Tr4f.outTransition, waitf.inTransition2) annotation (points=[-
              10, -5; -10, 72; -44, 72; -44, 62]);
        connect(counts.inTransition, Tr1s.outTransition) annotation (points=[54,
                2; 54, 17]);
        connect(Tr1s.inTransition, waits.outTransition) annotation (points=[
              53.95, 28.05; 54, 39]);
        connect(Tr2s.inTransition, counts.outTransition1) annotation (points=[
              33.95, -33.95; 34, -26; 48, -26; 48, -21]);
        connect(activates.inTransition, Tr2s.outTransition) annotation (points=
              [34, -58; 34, -45]);
        connect(activates.outTransition, Tr3s.inTransition) annotation (points=
              [34, -81; 34, -92; 14, -92; 14.05, -16.05]);
        connect(Tr3s.outTransition, waits.inTransition1) annotation (points=[14,
                -5; 14, 72; 48, 72; 48, 62]);
        connect(Tr4s.inTransition, counts.outTransition2) annotation (points=[
              94.05, -16.05; 94, -30; 60, -30; 60, -21.1]);
        connect(Tr4s.outTransition, waits.inTransition2) annotation (points=[94,
                -5; 94, 72; 60, 72; 60, 62]);
        // field current limiter
        Tr1f.condition = u1 > Limitf;
        Tr2f.condition = (time - counterf) > Tdf;
        Tr3f.condition = (time - counterf) > Taf and (u1 < Limitf);
        Tr4f.condition = (u1 < Limitf);
        
        when countf.state then
          counterf = time; 
        end when;
        
        fcorr = if (u4 > 0) and (activatef.state) then Kf*(Limitf - u1) else 
          1e3;
        
        // stator current limiter
        Tr1s.condition = u2 > Limits;
        Tr2s.condition = (time - counters) > Tds;
        Tr3s.condition = (time - counters) > Tas and (u2 < Limits);
        Tr4s.condition = (u2 < Limits);
        
        when counts.state then
          counters = time; 
        end when;
        
        scorr = if (u4 > 0) and (activates.state) then Ks*(Limits - u2) else 
          1e3;
        
        // output equation
        y = noEvent(min(scorr, min(fcorr, u3)));
        
      initial equation 
        waitf.state = true;
        countf.state = false;
        activatef.state = false;
        waits.state = true;
        counts.state = false;
        activates.state = false;
      end Limiter;
      
      model WaterWays 
        extends Modelica.Blocks.Interfaces.SISO;
        parameter Real Tw=1;
        
        Real x(start=0);
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation 
        Tw*der(x) = (1 - (x/(u + 1e-8))^2);
        y = (x/(u + 1e-8))^2*x;
        
      initial equation 
        der(x) = 0;
      end WaterWays;
      
      model SweGov 
        extends ObjectStab.Generators.Controllers.Partials.Governor;
        
        parameter Real Rdyn=0.8;
        parameter Real Rstat=0.04;
        parameter Real Tr=5;
        parameter Real Tw=1;
        parameter Real GateMax=0.95;
        parameter Real GateMin=0.0;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.04,
            y=0.25,
            width=0.75,
            height=0.6),
          Icon(Text(extent=[-72, 30; 82, -34], string="BsweGov")),
          Diagram(Text(extent=[-56, -18; -36, -26], string="Pm0"), Line(points=
                  [-38, -6; -44, -18])));
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
        Modelica.Blocks.Continuous.TransferFunction Filter(b={1}, a={0.05,1}) 
          annotation (extent=[-20, 60; 0, 80]);
        Modelica.Blocks.Math.Feedback Feedback1 annotation (extent=[-50, 60; -
              30, 80]);
        Modelica.Blocks.Math.Gain Gain2(k=Rstat)
          annotation (extent=[-50,30; -30,50], rotation=90);
        Modelica.Blocks.Continuous.Integrator Int(k=1/Tr)
          annotation (extent=[20,60; 40,80]);
        Modelica.Blocks.Math.Add Add3(k1=+1/Rdyn, k2=+1/Rdyn) annotation (
            extent=[60, 60; 80, 80]);
        Modelica.Blocks.Nonlinear.Limiter Limiter1(uMax=GateMax, uMin=GateMin)
          annotation (extent=[-6,-10; 14,10]);
        Modelica.Blocks.Continuous.TransferFunction Servo(
          b={1},
          a={0.2,1},
          x(start={1})) annotation (extent=[22, -10; 42, 10]);
        Nordic32.Models.WaterWays Water annotation (extent=[50, 10; 70, -10]);
        Modelica.Blocks.Math.Add AddPm0 annotation (extent=[-34, -10; -14, 10]);
      equation 
        connect(Int.u, Filter.y) annotation (points=[18,70; 1,70]);
        connect(Int.y, Add3.u2) annotation (points=[41,70; 58,64]);
        connect(Feedback1.u2, Gain2.y)
          annotation (points=[-40,62; -40,52; -40,51]);
        connect(Add3.u1, Filter.y)
          annotation (points=[58,76; 50,76; 50,92; 8,92; 8,70; 1,70]);
        connect(Gain2.u, Add3.y)
          annotation (points=[-40,28; -40,22; 90,22; 90,70; 84,70; 81,70]);
        connect(Water.u, Servo.y) annotation (points=[48,0; 43,0]);
        connect(Servo.u, Limiter1.y) annotation (points=[18,0; 15,0]);
        connect(Feedback1.y, Filter.u) annotation (points=[-31,70; -24,70]);
        connect(AddPm0.y, Limiter1.u)
          annotation (points=[-13,0; -8,0], style(color=3));
        connect(werror.y, Feedback1.u1)
          annotation (points=[-58,0; -54,0; -54,70; -50,70], style(color=3));
        connect(Water.y, Limiter.u)
          annotation (points=[71,0; 72,0], style(color=3));
        connect(AddPm0.u1, Gain2.u)
          annotation (points=[-36,6; -40,6; -40,26], style(color=3));
        
        AddPm0.u2 = {Pm0};
        
      initial equation 
        Filter.y = 0;
        der(Servo.x) = {0};
        Int.y = {0};
        
      end SweGov;
      
      model SweExc 
        extends ObjectStab.Generators.Controllers.Partials.Exciter(Efmax=5,
            Efmin=0);
        parameter Real Sbase=100;
        parameter Real Ta=5;
        parameter Real Tb=50;
        parameter Real Tc=0.1;
        parameter Real Limits=100;
        parameter Real Kpss=1;
        parameter Real Limitf=3.74;
        
        parameter ObjectStab.Base.Time StepTime=1.0 
          "Time for voltage reference step";
        Real u5=inPort5;
        Modelica.Blocks.Continuous.TransferFunction PSStf(b={0.6,1.3}, a={2,1}) 
           annotation (extent=[-60, -70; -40, -50]);
        Modelica.Blocks.Continuous.TransferFunction AVRtf(b={K*Ta,K}, a={Tb*Tc,
              (Tc + Tb),1}) annotation (extent=[26, -10; 46, 10]);
        Modelica.Blocks.Continuous.TransferFunction PSStf1(b={-91.125,0,0,0}, a=
             {91.125,60.75,13.5,1}) annotation (extent=[-90, -70; -70, -50]);
        annotation (
          Diagram,
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.13,
            y=0.03,
            width=0.6,
            height=0.6),
          Icon(Text(extent=[-82, 30; 84, -32], string="SweExc")));
        Modelica.Blocks.Nonlinear.Limiter PSSLim(uMax=0.05, uMin=-0.05)
          annotation (extent=[10,-70; 30,-50]);
        Modelica.Blocks.Math.Add PSSAdd(k1=+1, k2=+1) annotation (extent=[-20,
              -10; 0, 10]);
        Modelica.Blocks.Interfaces.RealInput inPort5
          annotation (extent=[-138,-80; -98,-40]);
        Modelica.Blocks.Math.Gain G(k=Kpss*ObjectStab.Base.Sbase/Sbase)
          annotation (extent=[-26,-70; -6,-50]);
      equation 
        connect(PSStf1.y, PSStf.u) annotation (points=[-69,-60; -62,-60]);
        connect(PSSAdd.y, AVRtf.u) annotation (points=[1,0; 24,0]);
        connect(G.u, PSStf.y)
          annotation (points=[-28,-60; -40,-60], style(color=3));
        connect(AVRtf.y, Limiter.u)
          annotation (points=[47,0; 72,0], style(color=3));
        connect(PSSAdd.u2, PSSLim.y) annotation (points=[-24,-6; -38,-6; -38,-32; 
              42,-32; 42,-60; 31,-60], style(color=3));
        connect(G.y, PSSLim.u)
          annotation (points=[-4,-60; 8,-60], style(color=3));
        connect(Verror.y, PSSAdd.u1)
          annotation (points=[-60,0; -41,0; -41,6; -22,6], style(color=3));
        connect(inPort5, PSStf1.u)
          annotation (points=[-128,-60; -92,-60], style(color=3));
        
        Ef0 = 0;
        
      initial equation 
        
        der(AVRtf.x) = {0,0};
        PSStf.x = {0};
        PSStf1.x = {0,0,0};
      end SweExc;
      
      model SweExcLim 
        extends ObjectStab.Generators.Controllers.Partials.Exciter(
          K=120,
          Efmax=5,
          Efmin=0);
        parameter Real Sbase=100;
        parameter Real Ta=5;
        parameter Real Tb=50;
        parameter Real Tc=0.1;
        parameter Real Limits=100;
        parameter Real Kpss=1;
        parameter Real Limitf=3.74;
        
        parameter ObjectStab.Base.Time StepTime=1.0 
          "Time for voltage reference step";
        
        Real u3;
        Real u4;
        Real u5;
        annotation (
          Diagram,
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0,
            y=0.36,
            width=0.6,
            height=0.6),
          Icon(Text(extent=[-82, 30; 84, -32], string="SweExcLim")));
        Modelica.Blocks.Math.Add PSSAdd annotation (extent=[-44, -16; -24, 4]);
        Nordic32.Models.Limiter ExcLimit(
          Limitf=Limitf,
          Taf=120,
          Limits=Limits,
          Tas=120) annotation (extent=[0, -10; 20, 10]);
        Modelica.Blocks.Interfaces.RealInput inPort3
          annotation (extent=[-122,78; -100,100]);
        Modelica.Blocks.Interfaces.RealInput inPort4
          annotation (extent=[-120,20; -100,40]);
        Modelica.Blocks.Interfaces.RealInput inPort5
          annotation (extent=[-120,-70; -100,-50]);
        Modelica.Blocks.Continuous.TransferFunction AVRtf(b={K*Ta,K}, a={Tb*Tc,
              (Tc + Tb),1}) annotation (extent=[30, -10; 50, 10]);
        Modelica.Blocks.Continuous.TransferFunction PSStf1(b={-91.125,0,0,0}, a=
             {91.125,60.75,13.5,1}) annotation (extent=[-70, -70; -50, -50]);
        Modelica.Blocks.Continuous.TransferFunction PSStf(b={0.6,1.3}, a={2,1}) 
           annotation (extent=[-34, -70; -14, -50]);
        Modelica.Blocks.Nonlinear.Limiter PSSLim(uMax=0.05, uMin=-0.05)
          annotation (extent=[34,-70; 54,-50]);
        Modelica.Blocks.Math.Gain G(k=Kpss*ObjectStab.Base.Sbase/Sbase)
          annotation (extent=[0,-70; 20,-50]);
      equation 
        connect(PSStf1.y, PSStf.u) annotation (points=[-49,-60; -38,-60]);
        connect(G.u, PSStf.y) annotation (points=[-2,-60; -13,-60]);
        connect(G.y, PSSLim.u) annotation (points=[21,-60; 32,-60]);
        connect(PSSAdd.u2, PSSLim.y) annotation (points=[-46,-12; -52,-12; -52,
              -40; 66,-40; 66,-60; 56,-60], style(color=3));
        connect(ExcLimit.inPort3, PSSAdd.y)
          annotation (points=[-4,-3; -12,-3; -12,-6; -22,-6], style(color=3));
        connect(ExcLimit.inPort2, inPort3) annotation (points=[-4, 3; -12, 3; -
              12, 90; -111, 90], style(color=3));
        connect(ExcLimit.outPort, AVRtf.u)
          annotation (points=[21,0; 26,0], style(color=3));
        connect(AVRtf.y, Limiter.u)
          annotation (points=[51,0; 70,0], style(color=3));
        connect(Limiter.y, ExcLimit.inPort1) annotation (points=[95,0; 100,0; 
              100,72; -9,72; -9,8; -4,8], style(color=3));
        connect(PSStf1.u, inPort5)
          annotation (points=[-72,-60; -110,-60], style(color=3));
        connect(ExcLimit.inPort4, inPort4) annotation (points=[-2, -8; -18, -8;
                -18, 30; -100, 30], style(color=3));
        connect(Verror.y, PSSAdd.u1)
          annotation (points=[-58,0; -48,0], style(color=3));
        
        u3 =inPort3;
        u4 =inPort4;
        u5 =inPort5;
        Ef0 = 0;
      initial equation 
        
        der(AVRtf.x) = {0,0};
        der(PSStf.x) = {0};
        der(PSStf1.x) = {0,0,0};
      end SweExcLim;
      
      model SweLoad "Nordic32 Static Load Model\t" 
        extends ObjectStab.Loads.Partials.Load;
        
        outer Base.AngularVelocity wref;
        parameter Real a=0.75;
        annotation (
          Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0.46,
            y=0.05,
            width=0.57,
            height=0.89),
          Icon,
          Documentation(info=" 
Static load model used in the CIGRE report.
Active power has constant current and Reactive power has 
constant impedance characteristic.
"));
      equation 
        Pl = P0*(V/V0)*wref^a;
        Ql = Q0*(V/V0)^2*wref^a;
      end SweLoad;
      
      model GenA6 
        extends ObjectStab.Generators.GovExc6thGen(
          rt=0,
          xt=0.1,
          D=2.50,
          H=6,
          ra=0,
          xd=2.2,
          xq=2,
          xdp=0.30,
          xqp=0.4,
          xqpp=0.20,
          xdpp=0.2,
          Td0p=7,
          Tq0p=1.5,
          Td0pp=0.05,
          Tq0pp=0.05,
          redeclare SweExcLim Exc(
            Efmax=5,
            Efmin=0,
            K=120,
            Ta=5,
            Tb=50,
            Tc=0.1,
            Limits=1.05,
            Limitf=3.74,
            Sbase=Sbase,
            Kpss=1));
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.08,
            y=0.03,
            width=0.6,
            height=0.6));
      equation 
        Exc.u3 = Iarm;
        Exc.u4 = Qg;
        Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
      end GenA6;
      
      model GenB6 
        extends ObjectStab.Generators.GovExc6thGen(
          rt=0,
          xt=0.15,
          xd=1.1,
          xq=0.7,
          xdp=0.25,
          xqp=0.2,
          xdpp=0.2,
          xqpp=0.20,
          Td0p=5,
          Tq0p=1,
          Td0pp=0.05,
          Tq0pp=0.1,
          D=2.50,
          H=3,
          redeclare SweExcLim Exc(
            Efmax=4,
            Efmin=0,
            K=50,
            Ta=4,
            Tb=20,
            Tc=0.1,
            Limitf=2.68,
            Limits=100,
            Sbase=Sbase,
            Kpss=1),
          redeclare SweGov Gov);
        
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.45,
            y=0.01,
            width=0.55,
            height=0.82));
      equation 
        Exc.u3 = Iarm;
        Exc.u4 = Qg;
        Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
      end GenB6;
      
      model GenC6 
        extends ObjectStab.Generators.GovExc6thGen(
          rt=0,
          xt=0.1,
          xd=1.55,
          xq=1,
          xdp=0.3,
          xqp=0.2,
          xdpp=0.2,
          xqpp=0.20,
          Td0p=7,
          Tq0p=1,
          Td0pp=0.05,
          Tq0pp=0.1,
          D=2.5,
          H=2,
          redeclare SweExcLim Exc(
            Efmax=4,
            Efmin=0,
            K=50,
            Ta=4,
            Tb=20,
            Tc=0.1,
            Limitf=3.26,
            Limits=100,
            Sbase=Sbase,
            Kpss=0));
        //   D=2, 
        annotation (Coordsys(
            extent=[-100, -100; 100, 100],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      equation 
        Exc.u3 = Iarm;
        Exc.u4 = Qg;
        Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
      end GenC6;
      
      model GenA0 
        extends ObjectStab.Extras.DetGen0(
          rt=0,
          xt=0.1,
          ra=0,
          xd=2.2,
          xq=2,
          K=120,
          Iarmmax=1.05,
          Efmax=3.74);
        
      end GenA0;
      
      model GenB0 
        extends ObjectStab.Extras.DetGen0(
          rt=0,
          xt=0.15,
          xd=1.1,
          xq=0.7,
          K=50,
          Efmax=2.68,
          Iarmmax=100);
      end GenB0;
      
      model GenC0 
        extends ObjectStab.Extras.DetGen0(
          rt=0,
          xt=0.1,
          xd=1.55,
          xq=1,
          K=50,
          Efmax=3.26,
          Iarmmax=100);
      end GenC0;
      annotation (Coordsys(
          extent=[0, 0; 442, 394],
          grid=[2, 2],
          component=[20, 20]), Window(
          x=0.4,
          y=0.4,
          width=0.6,
          height=0.6,
          library=1,
          autolayout=1));
    end Models;
    
    package lf028 
      extends Modelica.Icons.Library;
      
      class lf32_028 
        extends ObjectStab.Base.System;
        output Real V1011;
        output Real V1012;
        output Real V1013;
        output Real V1014;
        output Real V1021;
        output Real V1022;
        output Real V1041;
        output Real V1042;
        output Real V1043;
        output Real V1044;
        output Real V1045;
        output Real V2031;
        output Real V2032;
        output Real V4011;
        output Real V4012;
        output Real V4021;
        output Real V4022;
        output Real V4031;
        output Real V4032;
        output Real V4041;
        output Real V4042;
        output Real V4043;
        output Real V4044;
        output Real V4045;
        output Real V4046;
        output Real V4047;
        output Real V4051;
        output Real V4061;
        output Real V4062;
        output Real V4063;
        output Real V4071;
        output Real V4072;
        output Real V41;
        output Real V42;
        output Real V43;
        output Real V46;
        output Real V47;
        output Real V51;
        output Real V61;
        output Real V62;
        output Real V63;
        replaceable ObjectStab.Network.Bus N1011 annotation (extent=[260, 660;
              300, 680], rotation=270);
        replaceable ObjectStab.Network.Bus N1012 annotation (extent=[260, 600;
              300, 620], rotation=270);
        replaceable ObjectStab.Network.Bus N1013 annotation (extent=[340, 660;
              380, 680], rotation=270);
        replaceable ObjectStab.Network.Bus N1014 annotation (extent=[340, 600;
              380, 620], rotation=270);
        replaceable ObjectStab.Network.Bus N1021 annotation (extent=[60, 520;
              100, 540], rotation=270);
        replaceable ObjectStab.Network.Bus N1022 annotation (extent=[120, 520;
              160, 540], rotation=270);
        replaceable ObjectStab.Network.Bus N1041 annotation (extent=[100, 180;
              140, 200], rotation=270);
        replaceable ObjectStab.Network.Bus N1042 annotation (extent=[160, 220;
              220, 240], rotation=270);
        replaceable ObjectStab.Network.Bus N1043 annotation (extent=[100, 260;
              140, 280], rotation=270);
        replaceable ObjectStab.Network.Bus N1044 annotation (extent=[220, 260;
              180, 280], rotation=90);
        replaceable ObjectStab.Network.Bus N1045 annotation (extent=[180, 180;
              220, 200], rotation=270);
        replaceable ObjectStab.Network.Bus N2031 annotation (extent=[100, 458;
              140, 478], rotation=270);
        replaceable ObjectStab.Network.Bus N2032 annotation (extent=[40, 458;
              80, 478], rotation=270);
        replaceable ObjectStab.Network.Bus N4011 annotation (extent=[100, 660;
              160, 680], rotation=270);
        replaceable ObjectStab.Network.Bus N4012 annotation (extent=[140, 600;
              100, 620], rotation=270);
        replaceable ObjectStab.Network.Bus N4021 annotation (extent=[280, 520;
              320, 540], rotation=270);
        replaceable ObjectStab.Network.Bus N4022 annotation (extent=[192, 520;
              232, 540], rotation=270);
        replaceable ObjectStab.Network.Bus N4031 annotation (extent=[160, 458;
              200, 478], rotation=270);
        replaceable ObjectStab.Network.Bus N4032 annotation (extent=[260, 458;
              220, 478], rotation=270);
        replaceable ObjectStab.Network.Bus N4041 annotation (extent=[70, 340;
              150, 360], rotation=270);
        replaceable ObjectStab.Network.Bus N4042 annotation (extent=[380, 438;
              340, 458], rotation=270);
        replaceable ObjectStab.Network.Bus N4043 annotation (extent=[240, 340;
              280, 360], rotation=270);
        replaceable ObjectStab.Network.Bus N4044 annotation (extent=[180, 340;
              220, 360], rotation=270);
        replaceable ObjectStab.Network.Bus N4045 annotation (extent=[260, 140;
              220, 160], rotation=270);
        replaceable ObjectStab.Network.Bus N4046 annotation (extent=[360, 340;
              320, 360], rotation=270);
        replaceable ObjectStab.Network.Bus N4047 annotation (extent=[300, 60;
              360, 80], rotation=270);
        replaceable ObjectStab.Network.Bus N4051 annotation (extent=[220, 60;
              260, 80], rotation=270);
        replaceable ObjectStab.Network.Bus N4061 annotation (extent=[30, 260;
              70, 280], rotation=270);
        replaceable ObjectStab.Network.Bus N4062 annotation (extent=[40, 140;
              80, 160], rotation=270);
        replaceable ObjectStab.Network.Bus N4063 annotation (extent=[40, 60; 80,
                80], rotation=270);
        replaceable ObjectStab.Network.Bus N4071 annotation (extent=[40, 660;
              80, 680], rotation=270);
        replaceable ObjectStab.Network.Bus N4072 annotation (extent=[40, 600;
              80, 620], rotation=270);
        replaceable ObjectStab.Network.Bus N41 annotation (extent=[80, 300; 100,
                320], rotation=270);
        replaceable ObjectStab.Network.Bus N42 annotation (extent=[360, 398;
              380, 418], rotation=270);
        replaceable ObjectStab.Network.Bus N43 annotation (extent=[240, 300;
              260, 320], rotation=270);
        replaceable ObjectStab.Network.Bus N46 annotation (extent=[340, 300;
              360, 320], rotation=270);
        replaceable ObjectStab.Network.Bus N47 annotation (extent=[320.154,
              20.5; 340, 40], rotation=270);
        replaceable ObjectStab.Network.Bus N51 annotation (extent=[230, 20; 250,
                40], rotation=270);
        replaceable ObjectStab.Network.Bus N61 annotation (extent=[30, 220; 50,
                240], rotation=270);
        replaceable ObjectStab.Network.Bus N62 annotation (extent=[40, 100; 60,
                120], rotation=270);
        replaceable ObjectStab.Network.Bus N63 annotation (extent=[40, 20; 60,
              40], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1011(P0=2, Q0=0.8) annotation (
            extent=[270, 650; 290, 670], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1012(P0=3, Q0=1) annotation (
            extent=[270, 590; 290, 610], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1013(P0=1, Q0=0.4) annotation (
            extent=[360, 650; 380, 670], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1022(P0=2.8, Q0=0.95) 
          annotation (extent=[130, 510; 150, 530], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1041(P0=6, Q0=2) annotation (
            extent=[100, 170; 120, 190], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1042(P0=3, Q0=0.8) annotation (
            extent=[170, 209.833; 190, 230], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1043(P0=2.3, Q0=1) annotation (
            extent=[100, 250; 120, 270], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1044(P0=8, Q0=3) annotation (
            extent=[200, 250; 220, 270], rotation=270);
        replaceable Nordic32.Models.SweLoad Load1045(P0=7, Q0=2.5) annotation (
            extent=[190, 170; 210, 190], rotation=270);
        replaceable Nordic32.Models.SweLoad Load2031(P0=1, Q0=0.3) annotation (
            extent=[110, 448; 130, 468], rotation=270);
        replaceable Nordic32.Models.SweLoad Load2032(P0=2, Q0=0.5) annotation (
            extent=[40, 448; 60, 468], rotation=270);
        replaceable Nordic32.Models.SweLoad Load4071(P0=3, Q0=1) annotation (
            extent=[40, 650; 60, 670], rotation=270);
        replaceable Nordic32.Models.SweLoad Load4072(P0=20, Q0=5) annotation (
            extent=[40, 590; 60, 610], rotation=270);
        replaceable Nordic32.Models.SweLoad Load41(P0=5.4, Q0=1.283) 
          annotation (extent=[80, 290; 100, 310], rotation=270);
        replaceable Nordic32.Models.SweLoad Load42(P0=4, Q0=1.257) annotation (
            extent=[360, 388; 380, 406], rotation=270);
        replaceable Nordic32.Models.SweLoad Load43(P0=9, Q0=2.388) annotation (
            extent=[240, 290; 260, 310], rotation=270);
        replaceable Nordic32.Models.SweLoad Load46(P0=7, Q0=1.937) annotation (
            extent=[340, 290; 360, 310], rotation=270);
        replaceable Nordic32.Models.SweLoad Load47(P0=1, Q0=0.452) annotation (
            extent=[320, 10; 340, 30], rotation=270);
        replaceable Nordic32.Models.SweLoad Load51(P0=8, Q0=2.532) annotation (
            extent=[230, 14; 250, 32], rotation=270);
        replaceable Nordic32.Models.SweLoad Load61(P0=5, Q0=1.123) annotation (
            extent=[30, 210; 50, 230], rotation=270);
        replaceable Nordic32.Models.SweLoad Load62(P0=3, Q0=0.8) annotation (
            extent=[40, 90; 60, 110], rotation=270);
        replaceable Nordic32.Models.SweLoad Load63(P0=5.9, Q0=2.562) 
          annotation (extent=[40, 10; 60, 30], rotation=270);
        ObjectStab.Network.ShuntCapacitor Cap1022(G=0, B=0.5) annotation (
            extent=[140, 530; 160, 550], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap1041(G=0, B=2) annotation (extent=
              [120, 170; 140, 190], rotation=270);
        ObjectStab.Network.ShuntCapacitor Cap1043(G=0, B=1.5) annotation (
            extent=[120, 270; 140, 290], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap1044(G=0, B=2) annotation (extent=
              [180, 270; 200, 290], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap1045(G=0, B=2) annotation (extent=
              [180, 170; 200, 190], rotation=270);
        ObjectStab.Network.ShuntReactor Reactor4012(G=0, B=-1) annotation (
            extent=[100, 590; 120, 610], rotation=270);
        ObjectStab.Network.ShuntCapacitor Cap4041(G=0, B=2) annotation (extent=
              [80, 350; 100, 370], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap4043(G=0, B=2) annotation (extent=
              [260, 350; 280, 370], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap4046(G=0, B=1) annotation (extent=
              [340, 350; 360, 370], rotation=90);
        ObjectStab.Network.ShuntCapacitor Cap4051(G=0, B=1) annotation (extent=
              [220, 70; 240, 92], rotation=90);
        ObjectStab.Network.ShuntReactor Reactor4071(G=0, B=-4) annotation (
            extent=[60, 670; 80, 690], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1012(V0=1.13, Pg0=6.0) 
          annotation (extent=[270, 610; 290, 630], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1013(V0=1.145, Pg0=3) 
          annotation (extent=[350, 670; 370, 690], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1014(V0=1.16, Pg0=5.5) 
          annotation (extent=[380, 590; 360, 610], rotation=270);
        replaceable ObjectStab.Generators.PVNode Gen1021(V0=1.1, Pg0=4) 
          annotation (extent=[70, 530; 90, 550], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1022(V0=1.0630, Pg0=2) 
          annotation (extent=[120, 530; 140, 550], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1042(V0=1, Pg0=3.6) 
          annotation (extent=[190, 230; 170, 250], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen1043(V0=0.9902, Pg0=1.8) 
          annotation (extent=[100, 270; 120, 288], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen2032(V0=1.1, Pg0=7.5) 
          annotation (extent=[60, 448; 80, 468], rotation=270);
        replaceable ObjectStab.Generators.PVNode Gen4012(V0=1.01, Pg0=6) 
          annotation (extent=[140, 590; 120, 610], rotation=270);
        replaceable ObjectStab.Generators.PVNode Gen4021(V0=1.0083, Pg0=2.5) 
          annotation (extent=[300, 530; 320, 550], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4031(V0=1.01, Pg0=3.1) 
          annotation (extent=[180, 448; 200, 468], rotation=270);
        replaceable ObjectStab.Generators.PVNode Gen4041(V0=1, Pg0=0.000010) 
          annotation (extent=[112, 350; 132, 370], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4042(V0=1, Pg0=6.3) 
          annotation (extent=[360, 448; 380, 468], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4047(V0=1.02, Pg0=10.8) 
          annotation (extent=[334, 70; 354, 90], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4051(V0=1.02, Pg0=6) 
          annotation (extent=[240, 70; 260, 90], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4062(V0=1.0005, Pg0=5.3) 
          annotation (extent=[40, 150; 60, 170], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4063(V0=1, Pg0=10.6) 
          annotation (extent=[40, 70; 60, 90], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4071(V0=1.01, Pg0=3) 
          annotation (extent=[40, 670; 60, 690], rotation=90);
        replaceable ObjectStab.Generators.PVNode Gen4072(V0=1.01, Pg0=20) 
          annotation (extent=[56, 590; 76, 610], rotation=270);
        replaceable ObjectStab.Generators.Slack Gen4011(V0=1.01) annotation (
            extent=[110, 670; 130, 690], rotation=90);
        replaceable ObjectStab.Network.Pilink Line10111013(
          R=0.005,
          X=0.035,
          B=0.028000) annotation (extent=[310, 650; 330, 670]);
        replaceable ObjectStab.Network.Pilink Line10121014(
          R=0.007,
          X=0.045,
          B=0.036000) annotation (extent=[310, 590; 330, 610]);
        replaceable ObjectStab.Network.Pilink Line10131014(
          R=0.003500,
          X=0.025,
          B=0.020000) annotation (extent=[350, 630; 370, 650], rotation=270);
        replaceable ObjectStab.Network.Pilink Line10211022(
          R=0.015,
          X=0.100,
          B=0.060000) annotation (extent=[100, 510; 120, 530]);
        replaceable ObjectStab.Network.Pilink Line10411043(
          R=0.005,
          X=0.030,
          B=0.024000) annotation (extent=[110, 220; 130, 240], rotation=90);
        replaceable ObjectStab.Network.Pilink Line10411045(
          R=0.007500,
          X=0.060,
          B=0.050000) annotation (extent=[150, 190; 170, 210]);
        replaceable ObjectStab.Network.Pilink Line10421044(
          R=0.019,
          X=0.140,
          B=0.240000) annotation (extent=[190, 240; 210, 260], rotation=90);
        replaceable ObjectStab.Network.Pilink Line10421045(
          R=0.050,
          X=0.300,
          B=0.060000) annotation (extent=[190, 200; 210, 220], rotation=270);
        replaceable ObjectStab.Network.Pilink Line10431044(
          R=0.005,
          X=0.040,
          B=0.032000) annotation (extent=[150, 250; 170, 270]);
        replaceable ObjectStab.Network.Pilink Line20312032(
          R=0.006,
          X=0.045,
          B=0.030000) annotation (extent=[100, 468; 80, 488]);
        replaceable ObjectStab.Network.Pilink Line40114012(
          R=0.001,
          X=0.008,
          B=0.200000) annotation (extent=[110, 630; 130, 650], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40114021(
          R=0.006,
          X=0.060,
          B=1.800000) annotation (extent=[220, 580; 240, 600], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40114022(
          R=0.004,
          X=0.040,
          B=1.200000) annotation (extent=[202, 580; 222, 600], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40114071(
          R=0.005,
          X=0.045,
          B=1.400000) annotation (extent=[80, 650; 100, 670]);
        replaceable ObjectStab.Network.Pilink Line40124022(
          R=0.004,
          X=0.035,
          B=1.005000) annotation (extent=[192, 546; 212, 566], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40124071(
          R=0.005,
          X=0.050,
          B=1.500000) annotation (extent=[80, 620; 100, 640], rotation=90);
        replaceable ObjectStab.Network.Pilink Line40214032(
          R=0.004,
          X=0.040,
          B=1.200000) annotation (extent=[280, 490; 300, 510], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40214042(
          R=0.010,
          X=0.060,
          B=3.000000) annotation (extent=[300, 488.5; 320, 510], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40224031(
          R=0.002,
          X=0.020,
          B=2.400000) annotation (extent=[170, 480; 190, 500], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40314032(
          R=0.001,
          X=0.010,
          B=0.300000) annotation (extent=[200, 468; 220, 488]);
        replaceable ObjectStab.Network.Pilink Line40314041(
          R=0.003,
          X=0.020,
          B=4.800000) annotation (extent=[100, 400; 120, 420], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40324042(
          R=0.010,
          X=0.040,
          B=2.000000) annotation (extent=[280, 450; 300, 470]);
        replaceable ObjectStab.Network.Pilink Line40324044(
          R=0.006,
          X=0.050,
          B=2.400000) annotation (extent=[190, 400; 210, 420], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40414044(
          R=0.003,
          X=0.030,
          B=0.900000) annotation (extent=[150, 330; 170, 350]);
        replaceable ObjectStab.Network.Pilink Line40414061(
          R=0.006,
          X=0.045,
          B=1.300000) annotation (extent=[100, 300; 120, 320], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40424043(
          R=0.002,
          X=0.015,
          B=0.500000) annotation (extent=[280, 400; 300, 420], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40424044(
          R=0.002,
          X=0.020,
          B=0.600000) annotation (extent=[240, 400; 260, 420], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40434044(
          R=0.001,
          X=0.010,
          B=0.300000) annotation (extent=[240, 350; 220, 370]);
        replaceable ObjectStab.Network.Pilink Line40434046(
          R=0.001,
          X=0.010,
          B=0.300000) annotation (extent=[290, 340; 310, 360]);
        replaceable ObjectStab.Network.Pilink Line40434047(
          R=0.002,
          X=0.020,
          B=0.600000) annotation (extent=[260, 260; 280, 280], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40444045(
          R=0.001,
          X=0.010,
          B=1.200000) annotation (extent=[230, 240; 250, 260], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40454051(
          R=0.002,
          X=0.020,
          B=2.400000) annotation (extent=[230, 110; 250, 132], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40454062(
          R=0.011,
          X=0.080,
          B=2.400000) annotation (extent=[150, 130; 130, 150]);
        replaceable ObjectStab.Network.Pilink Line40464047(
          R=0.001,
          X=0.015,
          B=0.500000) annotation (extent=[320, 260; 340, 280], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40614062(
          R=0.002,
          X=0.020,
          B=0.600000) annotation (extent=[50, 220; 70, 240], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40624063(
          R=0.001500,
          X=0.015,
          B=1.800000) annotation (extent=[60, 100; 80, 120], rotation=270);
        replaceable ObjectStab.Network.Pilink Line40714072(
          R=0.001500,
          X=0.015,
          B=6.000000) annotation (extent=[50, 630; 70, 650], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr10114011(
          R=0.000,
          X=0.010034,
          n=1.119946) annotation (extent=[232, 650; 252, 670]);
        replaceable ObjectStab.Network.FixTransformer Tr10124012(
          R=0.000,
          X=0.010034,
          n=1.119946) annotation (extent=[232, 610; 252, 630]);
        replaceable ObjectStab.Network.FixTransformer Tr10224022(
          R=0.000,
          X=0.013738,
          n=1.069976) annotation (extent=[172, 510; 192, 530], rotation=180);
        replaceable ObjectStab.Network.FixTransformer Tr20314031(
          R=0.000,
          X=0.013229,
          n=1.049979) annotation (extent=[140, 468; 160, 488], rotation=180);
        replaceable ObjectStab.Network.FixTransformer Tr40441044(
          R=0.000,
          X=0.005000,
          n=1.0) annotation (extent=[190, 292; 210, 310], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr40451045(
          R=0.000,
          X=0.005000,
          n=1.0) annotation (extent=[210, 160; 230, 180], rotation=90);
        replaceable ObjectStab.Network.FixTransformer Tr404141(
          R=0.000,
          X=0.01,
          n=1.01) annotation (extent=[80, 320; 100, 340], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr404242(
          R=0.000,
          X=0.013,
          n=1.02) annotation (extent=[360, 420; 380, 440], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr404343(
          R=0.000,
          X=0.007,
          n=1.03) annotation (extent=[240, 320; 260, 340], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr404646(
          R=0.000,
          X=0.01,
          n=1.03) annotation (extent=[340, 320; 360, 340], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr404747(
          R=0.000,
          X=0.040000,
          n=1.00) annotation (extent=[320, 40; 340, 60], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr405151(
          R=0.000,
          X=0.0070,
          n=1.00) annotation (extent=[230, 40; 250, 60], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr406161(
          R=0.000,
          X=0.013,
          n=1.04) annotation (extent=[30, 240; 50, 260], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr406262(
          R=0.000,
          X=0.02,
          n=1.02) annotation (extent=[40, 120; 60, 140], rotation=270);
        replaceable ObjectStab.Network.FixTransformer Tr406363(
          R=0.000,
          X=0.01,
          n=1.03) annotation (extent=[40, 40; 60, 60], rotation=270);
      equation 
        connect(Load1011.T, N1011.T) annotation (points=[280, 670; 280, 670]);
        connect(Load1012.T, N1012.T) annotation (points=[280, 610; 280, 610]);
        connect(Load1022.T, N1022.T) annotation (points=[140, 530; 140, 530]);
        connect(Load1041.T, N1041.T) annotation (points=[110, 190; 120, 190]);
        connect(Load1042.T, N1042.T) annotation (points=[180, 230; 190, 230]);
        connect(Load1043.T, N1043.T) annotation (points=[110, 270; 120, 270]);
        connect(Load1044.T, N1044.T) annotation (points=[210, 270; 200, 270]);
        connect(Load1045.T, N1045.T) annotation (points=[200, 190; 200, 190]);
        connect(Load2031.T, N2031.T) annotation (points=[120, 468; 120, 468]);
        connect(Load2032.T, N2032.T) annotation (points=[50, 468; 60, 468]);
        connect(Load4071.T, N4071.T) annotation (points=[50, 670; 60, 670]);
        connect(Load4072.T, N4072.T) annotation (points=[50, 610; 60, 610]);
        connect(Load41.T, N41.T) annotation (points=[90, 310; 90, 310]);
        connect(Load42.T, N42.T) annotation (points=[370, 406; 370, 408]);
        connect(Load43.T, N43.T) annotation (points=[250, 310; 250, 310]);
        connect(Load46.T, N46.T) annotation (points=[350, 310; 350, 310]);
        connect(Load47.T, N47.T) annotation (points=[330, 30; 330.077, 30.25]);
        connect(Load51.T, N51.T) annotation (points=[240, 32; 240, 30]);
        connect(Load61.T, N61.T) annotation (points=[40, 230; 40, 230]);
        connect(Load62.T, N62.T) annotation (points=[50, 110; 50, 110]);
        connect(Load63.T, N63.T) annotation (points=[50, 30; 50, 30]);
        connect(Cap1022.T, N1022.T) annotation (points=[150, 530; 140, 530]);
        connect(Cap1041.T, N1041.T) annotation (points=[130, 190; 120, 190]);
        connect(Cap1043.T, N1043.T) annotation (points=[130, 270; 120, 270]);
        connect(Cap1044.T, N1044.T) annotation (points=[190, 270; 200, 270]);
        connect(Cap1045.T, N1045.T) annotation (points=[190, 190; 200, 190]);
        connect(Reactor4012.T, N4012.T) annotation (points=[110, 610; 120, 610]);
        connect(Cap4041.T, N4041.T) annotation (points=[90, 350; 110, 350]);
        connect(Cap4043.T, N4043.T) annotation (points=[270, 350; 260, 350]);
        connect(Cap4046.T, N4046.T) annotation (points=[350, 350; 340, 350]);
        connect(Cap4051.T, N4051.T) annotation (points=[230, 70; 240, 70]);
        connect(Gen1012.T, N1012.T) annotation (points=[280, 610; 280, 610]);
        connect(Gen1013.T, N1013.T) annotation (points=[360, 670; 360, 670]);
        connect(Gen1014.T, N1014.T) annotation (points=[370, 610; 360, 610]);
        connect(Gen1021.T, N1021.T) annotation (points=[80, 530; 80, 530]);
        connect(Gen1022.T, N1022.T) annotation (points=[130, 530; 140, 530]);
        connect(Gen1042.T, N1042.T) annotation (points=[180, 230; 190, 230]);
        connect(Gen1043.T, N1043.T) annotation (points=[110, 270; 120, 270]);
        connect(Gen4012.T, N4012.T) annotation (points=[130, 610; 120, 610]);
        connect(Gen4021.T, N4021.T) annotation (points=[310, 530; 300, 530]);
        connect(Gen4031.T, N4031.T) annotation (points=[190, 468; 180, 468]);
        connect(Gen4041.T, N4041.T) annotation (points=[122, 350; 110, 350]);
        connect(Gen4042.T, N4042.T) annotation (points=[370, 448; 360, 448]);
        connect(Gen4047.T, N4047.T) annotation (points=[344, 70; 330, 70]);
        connect(Gen4051.T, N4051.T) annotation (points=[250, 70; 240, 70]);
        connect(Gen4063.T, N4063.T) annotation (points=[50, 70; 60, 70]);
        connect(Gen4011.T, N4011.T) annotation (points=[120, 670; 130, 670]);
        connect(Line10111013.T1, N1011.T) annotation (points=[310, 660; 289,
              660; 289, 670; 280, 670]);
        connect(Line10111013.T2, N1013.T) annotation (points=[330, 660; 351,
              660; 351, 670; 360, 670]);
        connect(Line10121014.T1, N1012.T) annotation (points=[310, 600; 289,
              600; 289, 610; 280, 610]);
        connect(Line10121014.T2, N1014.T) annotation (points=[330, 600; 351,
              600; 351, 610; 360, 610]);
        connect(Line10131014.T1, N1013.T) annotation (points=[360, 650; 360,
              670]);
        connect(Line10131014.T2, N1014.T) annotation (points=[360, 630; 360,
              610]);
        connect(Line10411043.T1, N1041.T) annotation (points=[120, 220; 120,
              190]);
        connect(Line10411043.T2, N1043.T) annotation (points=[120, 240; 120,
              270]);
        connect(Line10421044.T2, N1044.T) annotation (points=[200, 260; 200,
              270]);
        connect(Line40114012.T2, N4012.T) annotation (points=[120, 630; 120,
              610]);
        connect(Line40114022.T2, N4022.T) annotation (points=[212, 580; 212,
              530]);
        connect(Line40124071.T1, N4012.T) annotation (points=[90, 620; 120, 610]);
        connect(Line40224031.T2, N4031.T) annotation (points=[180, 480; 180,
              468]);
        connect(Line40314041.T2, N4041.T) annotation (points=[110, 400; 110,
              350]);
        connect(Line40324044.T2, N4044.T) annotation (points=[200, 400; 200,
              350]);
        connect(Line40414061.T1, N4041.T) annotation (points=[110, 320; 110,
              350]);
        connect(Line40434046.T1, N4043.T) annotation (points=[290, 350; 260,
              350]);
        connect(Line40434046.T2, N4046.T) annotation (points=[310, 350; 340,
              350]);
        connect(Line40444045.T2, N4045.T) annotation (points=[240, 240; 240,
              150]);
        connect(Line40454051.T1, N4045.T) annotation (points=[240, 132; 240,
              150]);
        connect(Line40454051.T2, N4051.T) annotation (points=[240, 110; 240, 70]);
        connect(Line40614062.T2, N4062.T) annotation (points=[60, 220; 60, 150]);
        connect(Line40714072.T1, N4071.T) annotation (points=[60, 650; 60, 670]);
        connect(Line40714072.T2, N4072.T) annotation (points=[60, 630; 60, 610]);
        connect(Tr10114011.T2, N1011.T) annotation (points=[252, 660; 271, 660;
                271, 670; 280, 670]);
        connect(Tr10124012.T2, N1012.T) annotation (points=[252, 620; 270, 620;
                270, 610; 280, 610]);
        connect(Tr10124012.T1, N4012.T) annotation (points=[232, 620; 130, 620;
                130, 610; 120, 610]);
        connect(Tr10224022.T2, N1022.T) annotation (points=[172, 520; 150, 520;
                150, 530; 140, 530]);
        connect(Tr10224022.T1, N4022.T) annotation (points=[192, 520; 202, 520;
                202, 530; 212, 530]);
        connect(Tr40441044.T1, N4044.T) annotation (points=[200, 310; 200, 350]);
        connect(Tr40441044.T2, N1044.T) annotation (points=[200, 292; 200, 270]);
        connect(Tr404141.T2, N41.T) annotation (points=[90, 320; 90, 310]);
        connect(Tr404242.T2, N42.T) annotation (points=[370, 420; 370, 408]);
        connect(Tr404343.T2, N43.T) annotation (points=[250, 320; 250, 310]);
        connect(Tr404646.T2, N46.T) annotation (points=[350, 320; 350, 310]);
        connect(Tr404747.T1, N4047.T) annotation (points=[330, 60; 330, 70]);
        connect(Tr404747.T2, N47.T) annotation (points=[330, 40; 330.077, 30.25]);
        connect(Tr405151.T1, N4051.T) annotation (points=[240, 60; 240, 70]);
        connect(Tr405151.T2, N51.T) annotation (points=[240, 40; 240, 30]);
        connect(Tr406161.T2, N61.T) annotation (points=[40, 240; 40, 230]);
        connect(Tr406262.T2, N62.T) annotation (points=[50, 120; 50, 110]);
        connect(Tr406363.T2, N63.T) annotation (points=[50, 40; 50, 30]);
        annotation (
          Coordsys(
            extent=[0, 0; 400, 700],
            grid=[2, 2],
            component=[20, 20]),
          Window(
            x=0,
            y=0,
            width=0.42,
            height=0.97),
          Diagram);
        connect(Load1013.T, N1013.T) annotation (points=[370, 670; 370, 670;
              360, 670]);
        connect(Line40114071.T2, N4011.T) annotation (points=[100, 660; 112,
              660; 112, 670; 130, 670]);
        connect(Line40114071.T1, N4071.T) annotation (points=[80, 660; 70, 660;
                70, 670; 60, 670]);
        connect(N4071.T, Gen4071.T) annotation (points=[60, 670; 50, 670]);
        connect(N4071.T, Reactor4071.T) annotation (points=[60, 670; 70, 670]);
        connect(Line40124071.T2, N4071.T) annotation (points=[90, 640; 90, 646;
                66, 656; 66, 656; 66, 670; 58, 670; 60, 670]);
        connect(Gen4072.T, N4072.T) annotation (points=[66, 610; 60, 610]);
        connect(Line10211022.T1, Gen1021.T) annotation (points=[100, 520; 80,
              520; 80, 530; 78, 530; 80, 530]);
        connect(Line10211022.T2, Gen1022.T) annotation (points=[120, 520; 130,
              520; 130, 530]);
        connect(Gen2032.T, N2032.T) annotation (points=[70, 468; 70, 468; 60,
              468]);
        connect(Line20312032.T2, Gen2032.T) annotation (points=[80, 478; 70,
              478; 70, 468]);
        connect(Load2031.T, Line20312032.T1) annotation (points=[120, 468; 112,
                468; 112, 478; 100, 478]);
        connect(Tr20314031.T2, Load2031.T) annotation (points=[140, 478; 128,
              478; 128, 468; 120, 468]);
        connect(Tr20314031.T1, N4031.T) annotation (points=[160, 478; 172, 478;
                172, 468; 180, 468]);
        connect(N4031.T, Line40314032.T1) annotation (points=[180, 468; 188,
              468; 188, 478; 200, 478]);
        connect(N4032.T, Line40314032.T2) annotation (points=[240, 468; 232,
              468; 232, 478; 220, 478]);
        connect(Tr404242.T1, Gen4042.T) annotation (points=[370, 440; 370, 448]);
        connect(Line40224031.T1, N4022.T) annotation (points=[180, 500; 180,
              508; 212, 508; 212, 530]);
        connect(Line40324042.T1, N4032.T) annotation (points=[280, 460; 248,
              460; 248, 468; 240, 468]);
        connect(Line40324042.T2, N4042.T) annotation (points=[300, 460; 352,
              460; 352, 448; 360, 448]);
        connect(N4021.T, Line40114021.T2) annotation (points=[300, 530; 300,
              536; 300, 536; 230, 574; 230, 580]);
        connect(Tr406363.T1, Gen4063.T) annotation (points=[50, 60; 50, 70]);
        connect(Tr406262.T1, Gen4062.T) annotation (points=[50, 140; 50, 150]);
        connect(Gen4062.T, N4062.T) annotation (points=[50, 150; 60, 150]);
        connect(Line40114022.T1, Gen4011.T) annotation (points=[212, 600; 212,
              606; 128, 644; 128, 670; 120, 670]);
        connect(Line40114021.T1, Gen4011.T) annotation (points=[230, 600; 230,
              608; 136, 652; 136, 670; 128, 670; 120, 670]);
        connect(Cap1043.T, Line10431044.T1) annotation (points=[130, 270; 130,
              260; 150, 260]);
        connect(Line10431044.T2, Cap1044.T) annotation (points=[170, 260; 190,
              260; 190, 270]);
        connect(Cap1041.T, Line10411045.T1) annotation (points=[130, 190; 130,
              200; 150, 200]);
        connect(Line10411045.T2, N1045.T) annotation (points=[170, 200; 190,
              200; 190, 190; 200, 190]);
        connect(N1045.T, Line10421045.T2) annotation (points=[200, 190; 200,
              200]);
        connect(Line40464047.T1, N4046.T) annotation (points=[330, 280; 330,
              350; 340, 350]);
        connect(Line40444045.T1, N4044.T) annotation (points=[240, 260; 240,
              280; 210, 336; 210, 350; 200, 350]);
        connect(Tr404343.T1, N4043.T) annotation (points=[250, 340; 250, 350;
              260, 350]);
        connect(N4043.T, Line40424043.T2) annotation (points=[260, 350; 260,
              372; 290, 388; 290, 390; 290, 400]);
        connect(N4043.T, Line40434044.T1) annotation (points=[260, 350; 250,
              350; 250, 360; 240, 360]);
        connect(Line40434044.T2, N4044.T) annotation (points=[220, 360; 210,
              360; 210, 350; 200, 350]);
        connect(N4044.T, Line40424044.T2) annotation (points=[200, 350; 204,
              350; 204, 366; 250, 390; 250, 400]);
        connect(N4045.T, Tr40451045.T1) annotation (points=[240, 150; 234, 150;
                234, 156; 220, 156; 220, 160]);
        connect(Tr40451045.T2, Load1045.T) annotation (points=[220, 180; 220,
              184; 208, 184; 208, 190; 200, 190]);
        connect(Line40454062.T1, N4045.T) annotation (points=[150, 140; 234,
              140; 234, 150; 238, 150; 240, 150]);
        connect(Line40454062.T2, N4062.T) annotation (points=[130, 140; 70, 140;
                70, 150; 60, 150]);
        connect(Line40624063.T1, N4062.T) annotation (points=[70, 120; 70, 128;
                60, 140; 60, 150]);
        connect(N4063.T, Line40624063.T2) annotation (points=[60, 70; 70, 70;
              70, 100]);
        connect(N4047.T, Line40464047.T2) annotation (points=[330, 70; 330, 260]);
        connect(Line40434047.T1, Cap4043.T) annotation (points=[270, 280; 270,
              350]);
        connect(Line40434047.T2, N4047.T) annotation (points=[270, 260; 270,
              106; 320, 80; 320, 70; 330, 70]);
        connect(N1042.T, Line10421044.T1) annotation (points=[190, 230; 200,
              230; 200, 240]);
        connect(Line10421045.T1, N1042.T) annotation (points=[200, 220; 200,
              230; 190, 230]);
        connect(Tr404646.T1, Cap4046.T) annotation (points=[350, 340; 350, 350]);
        connect(Line40614062.T1, N4061.T) annotation (points=[60, 240; 60, 270;
                50, 270]);
        connect(Tr406161.T1, N4061.T) annotation (points=[40, 260; 40, 270; 50,
                270]);
        connect(Line40114012.T1, Gen4011.T) annotation (points=[120, 650; 120,
              670]);
        connect(Gen4011.T, Tr10114011.T1) annotation (points=[120, 670; 146,
              670; 146, 660; 232, 660]);
        connect(N4032.T, Line40214032.T2) annotation (points=[240, 468; 248,
              468; 248, 478; 290, 486; 290, 490]);
        connect(Line40424043.T1, N4042.T) annotation (points=[290, 420; 290,
              424; 360, 436; 360, 448; 360, 448]);
        connect(Line40424044.T1, N4042.T) annotation (points=[250, 420; 250,
              426; 352, 442; 352, 448; 360, 448]);
        connect(Line40124022.T2, N4022.T) annotation (points=[202, 546; 202,
              530; 212, 530]);
        connect(N4012.T, Line40124022.T1) annotation (points=[120, 610; 120,
              576; 202, 576; 202, 566]);
        connect(Line40414044.T2, N4044.T) annotation (points=[170, 340; 194,
              340; 194, 350; 200, 350]);
        connect(Line40414044.T1, Gen4041.T) annotation (points=[150, 340; 122,
              340; 122, 350]);
        connect(Line40414061.T2, N4061.T) annotation (points=[110, 300; 110,
              296; 50, 280; 50, 270]);
        connect(Line40314041.T1, N4031.T) annotation (points=[110, 420; 110,
              428; 172, 460; 172, 468; 180, 468]);
        connect(Tr404141.T1, Cap4041.T) annotation (points=[90, 340; 90, 350]);
        connect(Line40214042.T1, Gen4021.T) annotation (points=[310, 510; 310,
              530]);
        connect(Line40214032.T1, N4021.T) annotation (points=[290, 510; 290,
              530; 300, 530]);
        connect(Line40214042.T2, N4042.T) annotation (points=[310, 488.5; 310,
              486; 360, 478; 360, 448]);
        connect(N4032.T, Line40324044.T1) annotation (points=[240, 468; 232,
              468; 232, 450; 200, 432; 200, 420]);
        N1011.V = V1011;
        N1012.V = V1012;
        N1013.V = V1013;
        N1014.V = V1014;
        N1021.V = V1021;
        N1022.V = V1022;
        N1041.V = V1041;
        N1042.V = V1042;
        N1043.V = V1043;
        N1044.V = V1044;
        N1045.V = V1045;
        N2031.V = V2031;
        N2032.V = V2032;
        N4011.V = V4011;
        N4012.V = V4012;
        N4021.V = V4021;
        N4022.V = V4022;
        N4031.V = V4031;
        N4032.V = V4032;
        N4041.V = V4041;
        N4042.V = V4042;
        N4043.V = V4043;
        N4044.V = V4044;
        N4045.V = V4045;
        N4046.V = V4046;
        N4047.V = V4047;
        N4051.V = V4051;
        N4061.V = V4061;
        N4062.V = V4062;
        N4063.V = V4063;
        N4071.V = V4071;
        N4072.V = V4072;
        N41.V = V41;
        N42.V = V42;
        N43.V = V43;
        N46.V = V46;
        N47.V = V47;
        N51.V = V51;
        N61.V = V61;
        N62.V = V62;
        N63.V = V63;
      end lf32_028;
      
      model stat28 
        extends lf32_028(
          redeclare Nordic32.Models.GenB0 Gen1012(Sbase=800.000000),
          redeclare Nordic32.Models.GenB0 Gen1013(Sbase=600.000000),
          redeclare Nordic32.Models.GenB0 Gen1014(Sbase=700.000000),
          redeclare Nordic32.Models.GenB0 Gen1021(Sbase=600.000000),
          redeclare Nordic32.Models.GenB0 Gen1022(Sbase=250.000000),
          redeclare Nordic32.Models.GenA0 Gen1042(Sbase=400.000000),
          redeclare Nordic32.Models.GenA0 Gen1043(Sbase=200.000000),
          redeclare Nordic32.Models.GenB0 Gen2032(Sbase=850.000000),
          redeclare Nordic32.Models.GenB0 Gen4012(Sbase=800.000000),
          redeclare Nordic32.Models.GenB0 Gen4021(Sbase=300.000000),
          redeclare Nordic32.Models.GenB0 Gen4031(Sbase=350.000000),
          redeclare Nordic32.Models.GenC0 Gen4041(Sbase=300.000000),
          redeclare Nordic32.Models.GenA0 Gen4042(Sbase=700.000000),
          redeclare Nordic32.Models.GenA0 Gen4047(Sbase=1200.00000),
          redeclare Nordic32.Models.GenA0 Gen4051(Sbase=1400.00000),
          redeclare Nordic32.Models.GenA0 Gen4062(Sbase=600.000000),
          redeclare Nordic32.Models.GenA0 Gen4063(Sbase=1200.00000),
          redeclare Nordic32.Models.GenB0 Gen4071(Sbase=400.000000),
          redeclare Nordic32.Models.GenB0 Gen4072(Sbase=4500.00000),
          redeclare ObjectStab.Network.TCULDis Tr40441044(
            R=0.000000,
            X=0.005000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              Td0=40,
              Tm0=7)),
          redeclare ObjectStab.Network.TCULDis Tr40451045(
            R=0.000000,
            X=0.005000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              Td0=40,
              Tm0=8)),
          redeclare ObjectStab.Network.TCULDis Tr404141(
            R=0.000000,
            X=0.009674,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6)),
          redeclare ObjectStab.Network.TCULDis Tr404242(
            R=0.000000,
            X=0.012576,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.9)),
          redeclare ObjectStab.Network.TCULDis Tr404343(
            R=0.000000,
            X=0.006555,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.5)),
          redeclare ObjectStab.Network.TCULDis Tr404646(
            R=0.000000,
            X=0.009364,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.5)),
          redeclare ObjectStab.Network.TCULDis Tr404747(
            R=0.000000,
            X=0.040000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.1)),
          redeclare ObjectStab.Network.TCULDis Tr405151(
            R=0.000000,
            X=0.007000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.4)),
          redeclare ObjectStab.Network.TCULDis Tr406161(
            R=0.000000,
            X=0.012173,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.6)),
          redeclare ObjectStab.Network.TCULDis Tr406262(
            R=0.000000,
            X=0.019348,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.1)),
          redeclare ObjectStab.Network.TCULDis Tr406363(
            R=0.000000,
            X=0.009364,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.2)));
        
        annotation (Coordsys(
            extent=[0, 0; 400, 700],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6));
      end stat28;
      
      model dyn28 
        extends lf32_028(
          redeclare Nordic32.Models.GenB6 Gen1012(Sbase=800.000000),
          redeclare Nordic32.Models.GenB6 Gen1013(Sbase=600.000000),
          redeclare Nordic32.Models.GenB6 Gen1014(Sbase=700.000000),
          redeclare Nordic32.Models.GenB6 Gen1021(Sbase=600.000000),
          redeclare Nordic32.Models.GenB6 Gen1022(Sbase=250.000000),
          redeclare Nordic32.Models.GenA6 Gen1042(Sbase=400.000000),
          redeclare Nordic32.Models.GenA6 Gen1043(Sbase=200.000000),
          redeclare Nordic32.Models.GenB6 Gen2032(Sbase=850.000000),
          redeclare Nordic32.Models.GenB6 Gen4012(Sbase=800.000000),
          redeclare Nordic32.Models.GenB6 Gen4021(Sbase=300.000000),
          redeclare Nordic32.Models.GenB6 Gen4031(Sbase=350.000000),
          redeclare Nordic32.Models.GenC6 Gen4041(Sbase=300.000000),
          redeclare Nordic32.Models.GenA6 Gen4042(Sbase=700.000000),
          redeclare Nordic32.Models.GenA6 Gen4047(Sbase=1200.00000),
          redeclare Nordic32.Models.GenA6 Gen4051(Sbase=1400.00000),
          redeclare Nordic32.Models.GenA6 Gen4062(Sbase=600.000000),
          redeclare Nordic32.Models.GenA6 Gen4063(Sbase=1200.00000),
          redeclare Nordic32.Models.GenB6 Gen4071(Sbase=500.000000, redeclare 
              Nordic32.Models.SweGov Gov(Rstat=0.08, Rdyn=1.6)),
          redeclare Nordic32.Models.GenB6 Gen4072(Sbase=4500.00000, redeclare 
              Nordic32.Models.SweGov Gov(Rstat=0.08, Rdyn=1.6)),
          redeclare Nordic32.Models.GenB6 Gen4011(
            Pg0=6.69614219665527,
            Sbase=1000.000000,
            isSlack=true),
          redeclare ObjectStab.Network.TCULDis Tr40441044(
            R=0.000000,
            X=0.005000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              Td0=40,
              Tm0=7)),
          redeclare ObjectStab.Network.TCULDis Tr40451045(
            R=0.000000,
            X=0.005000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              Td0=40,
              Tm0=8)),
          redeclare ObjectStab.Network.TCULDis Tr404141(
            R=0.000000,
            X=0.009674,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6)),
          redeclare ObjectStab.Network.TCULDis Tr404242(
            R=0.000000,
            X=0.012576,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.9)),
          redeclare ObjectStab.Network.TCULDis Tr404343(
            R=0.000000,
            X=0.006555,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.5)),
          redeclare ObjectStab.Network.TCULDis Tr404646(
            R=0.000000,
            X=0.009364,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.5)),
          redeclare ObjectStab.Network.TCULDis Tr404747(
            R=0.000000,
            X=0.040000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.1)),
          redeclare ObjectStab.Network.TCULDis Tr405151(
            R=0.000000,
            X=0.007000,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.4)),
          redeclare ObjectStab.Network.TCULDis Tr406161(
            R=0.000000,
            X=0.012173,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.6)),
          redeclare ObjectStab.Network.TCULDis Tr406262(
            R=0.000000,
            X=0.019348,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=7.1)),
          redeclare ObjectStab.Network.TCULDis Tr406363(
            R=0.000000,
            X=0.009364,
            Controller(
              method=1,
              stepsize=0.01,
              maxtap=12,
              mintap=-12,
              DB=0.03,
              Td0=40,
              Tm0=6.2)));
        annotation (Coordsys(
            extent=[0, 0; 400, 700],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.46,
            y=0.01,
            width=0.43,
            height=0.65));
      end dyn28;
      
      package case0 
        extends Modelica.Icons.Library;
        model dynsim 
          extends dyn28(redeclare ObjectStab.Network.FaultedBus N4045(
              FaultR=0.01,
              FaultX=0,
              FaultTime=10,
              FaultDuration=0.07));
          annotation (Coordsys(
              extent=[0, 0; 400, 700],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0.01,
              y=0.39,
              width=0.6,
              height=0.6));
        end dynsim;
        annotation (Coordsys(
            extent=[0, 0; 683, 412],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6,
            library=1,
            autolayout=1));
      end case0;
      
      package case4 
        extends Modelica.Icons.Library;
        model dynsim 
          extends dyn28(redeclare Nordic32.Models.GenB6 Gen1012(Sbase=
                  800.000000, TripTime=10.05), redeclare 
              ObjectStab.Network.OpenedPilink Line40114021(
              OpenTime=10,
              R=0.006,
              X=0.060,
              B=1.800000));
          annotation (Coordsys(
              extent=[0, 0; 400, 700],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0,
              y=0.19,
              width=0.46,
              height=0.78));
        end dynsim;
        
        model statsim 
          extends stat28(redeclare Nordic32.Models.GenB0 Gen1012(Sbase=
                  800.000000, TripTime=10.05), redeclare 
              ObjectStab.Network.OpenedPilink Line40114021(
              OpenTime=10,
              R=0.006,
              X=0.060,
              B=1.800000));
          annotation (Coordsys(
              extent=[0, 0; 400, 700],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0.16,
              y=0.1,
              width=0.6,
              height=0.6));
        end statsim;
        annotation (Coordsys(
            extent=[0, 0; 683, 412],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.04,
            y=0.34,
            width=0.6,
            height=0.6,
            library=1,
            autolayout=1));
      end case4;
      
      package case14 
        extends Modelica.Icons.Library;
        model statsim 
          extends stat28(redeclare Nordic32.Models.GenA0 Gen4062(Sbase=
                  600.000000, TripTime=10));
          annotation (Coordsys(
              extent=[0, 0; 400, 700],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0.4,
              y=0.4,
              width=0.6,
              height=0.6));
        end statsim;
        
        model dynsim 
          extends dyn28(redeclare Nordic32.Models.GenA6 Gen4062(Sbase=
                  600.000000, TripTime=10));
          annotation (Coordsys(
              extent=[0, 0; 400, 700],
              grid=[2, 2],
              component=[20, 20]), Window(
              x=0.01,
              y=0.35,
              width=0.6,
              height=0.6));
        end dynsim;
        annotation (Coordsys(
            extent=[0, 0; 683, 412],
            grid=[2, 2],
            component=[20, 20]), Window(
            x=0.4,
            y=0.4,
            width=0.6,
            height=0.6,
            library=1,
            autolayout=1));
      end case14;
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
    end lf028;
    annotation (
      Coordsys(
        extent=[0, 0; 442, 394],
        grid=[2, 2],
        component=[20, 20]),
      Window(
        x=0.4,
        y=0.4,
        width=0.6,
        height=0.6,
        library=1,
        autolayout=1),
      Documentation(info="Nordic 32 test system from [1].

Set the switch 'Evaluate=true' for more efficient
simulation.

--------
[1] Long Term Dynamics Phase II,  CIGRE Task Force 38.02.08
"));
  end Nordic32;
end Examples;
