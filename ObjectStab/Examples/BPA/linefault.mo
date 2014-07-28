within ObjectStab.Examples.BPA;
model linefault
  extends system(redeclare ObjectStab.Extras.FaultedPQPilink L67_5(
      FaultTime=10,
      FaultR=0,
      FaultX=0,
      ClearTime=0.07,
      RecloseTime=30000));
end linefault;
