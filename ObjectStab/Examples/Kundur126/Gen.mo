within ObjectStab.Examples.Kundur126;
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

end Gen;
