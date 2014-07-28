within ObjectStab.Network;
model Pilink "Pilink Line Model"
  extends Partials.PilinkBase;

equation
  [T1.ia; T1.ib] = [G, -B; B, G]/2*[1 + T1.va; T1.vb] + [R, X; -X, R]/(R^2 +
    X^2)*[T1.va - T2.va; T1.vb - T2.vb];
  [T2.ia; T2.ib] = [G, -B; B, G]/2*[1 + T2.va; T2.vb] - [R, X; -X, R]/(R^2 +
    X^2)*[T1.va - T2.va; T1.vb - T2.vb];

end Pilink;
