within ObjectStab.Network;
model OpenedPilink2 "Pilink model with breakers"
  extends Partials.PilinkBase;
  parameter ObjectStab.Base.Time OpenTime=10 "Time of branch opening";
  parameter ObjectStab.Base.Duration CloseTime=1e10
    "Duration of the branch opening";

equation
  [T1.ia; T1.ib] = if time < OpenTime then [G, -B; B, G]/2*[1 + T1.va; T1.vb]
     + [R, X; -X, R]/(R^2 + X^2)*[T1.va - T2.va; T1.vb - T2.vb] else [0; 0];
  [T2.ia; T2.ib] = if time < OpenTime then [G, -B; B, G]/2*[1 + T2.va; T2.vb]
     - [R, X; -X, R]/(R^2 + X^2)*[T1.va - T2.va; T1.vb - T2.vb] else [0; 0];
  annotation (Documentation(info="<html>
</html>"));
end OpenedPilink2;
