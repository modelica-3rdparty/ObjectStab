within ObjectStab.Examples.Kundur126;
model Linefault
  extends System(redeclare ObjectStab.Network.FaultedPilink L78_1(
      FaultTime=2,
      alpha=0.5,
      FaultR=0.01,
      FaultX=0,
      ClearTime=0.07,
      RecloseTime=3.5));
  output Real V=Bus8.V;
end Linefault;
