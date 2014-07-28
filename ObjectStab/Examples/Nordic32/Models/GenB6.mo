within ObjectStab.Examples.Nordic32.Models;
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

equation
  Exc.u3 = Iarm;
  Exc.u4 = Qg;
  Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
end GenB6;
