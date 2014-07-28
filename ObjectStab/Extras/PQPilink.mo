within ObjectStab.Extras;
model PQPilink
  extends Network.Pilink;
  Real P1=T1.ib*T1.vb + T1.ia + T1.ia*T1.va;
  Real Q1=T1.ia*T1.vb - T1.ib - T1.ib*T1.va;
  Real P2=T2.ib*T2.vb + T2.ia + T2.ia*T2.va;
  Real Q2=T2.ia*T2.vb - T2.ib - T2.ib*T2.va;

  Real Ploss=noEvent(abs(P1 + P2));
  Real Qloss=noEvent(abs(Q1 + Q2));
  Real I1=sqrt(T1.ia^2 + T1.ib^2);
  Real I2=sqrt(T2.ia^2 + T2.ib^2);
end PQPilink;
