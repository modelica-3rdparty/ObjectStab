within ObjectStab.Network;
model Breaker "Ideal Breaker model"
  parameter ObjectStab.Base.Time OpenTime=1 "Opening time";
  parameter ObjectStab.Base.Time CloseTime=1e10 "Closing time";
  extends Partials.BreakerBase(closed(start=OpenTime < CloseTime));

equation
  if (OpenTime > CloseTime) then
    closed = (time > CloseTime and time < OpenTime);
  else
    closed = (time < OpenTime or time > CloseTime);
  end if;
  annotation (
    Documentation(info="The ideal breaker model is governed by the following models:
if breaker is closed then
  V1 = V2
  I1 + I2 = 0
else
  I1 = 0
  I2 = 0
"));
end Breaker;
