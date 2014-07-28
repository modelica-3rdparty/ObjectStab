within ObjectStab.Examples.BPA;
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
end BPAGen;
