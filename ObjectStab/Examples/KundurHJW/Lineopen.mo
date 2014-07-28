within ObjectStab.Examples.KundurHJW;
model Lineopen
  extends System(redeclare ObjectStab.Network.OpenedPilink L78_1(OpenTime=2,
          CloseTime=5));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-100},{200,100}}), graphics),
    experiment(StopTime=6));
end Lineopen;
