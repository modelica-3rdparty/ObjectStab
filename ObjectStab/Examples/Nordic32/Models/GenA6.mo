within ObjectStab.Examples.Nordic32.Models;
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
equation
  Exc.u3 = Iarm;
  Exc.u4 = Qg;
  Exc.u5 = Pg - Gov.Pm0*Sbase/ObjectStab.Base.Sbase;
end GenA6;
