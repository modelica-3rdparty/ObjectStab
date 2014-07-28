within ObjectStab.Examples.Nordic32.Models;
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
equation
  Exc.u3 = Iarm;
  Exc.u4 = Qg;
  Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
end GenC6;
