within ObjectStab.Examples.Nordic32.lf028.case0;
model dynsim
  extends dyn28(redeclare ObjectStab.Network.FaultedBus N4045(
      FaultR=0.01,
      FaultX=0,
      FaultTime=10,
      FaultDuration=0.07));
end dynsim;
