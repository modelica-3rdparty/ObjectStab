within ObjectStab.Examples.KundurHJW;
model Linefault
  extends System(redeclare ObjectStab.Network.FaultedPilink L78_1(
      FaultTime=2,
      alpha=0.5,
      FaultR=0.01,
      FaultX=0,
      ClearTime=0.07,
      RecloseTime=3.5));
  output Real V=bus8.V;
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics),
    experiment(StopTime=6),
    __Dymola_experimentSetupOutput);
end Linefault;
