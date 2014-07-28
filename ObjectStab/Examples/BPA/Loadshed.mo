within ObjectStab.Examples.BPA;
model Loadshed
  extends Linefault(redeclare Extras.UVLSLoad L8(
      Relay1(
        ShedAmount=0.05,
        Threshold=0.82,
        DelayTime=4.5),
      Relay2(
        ShedAmount=0.05,
        Threshold=0.80,
        DelayTime=3),
      Relay3(
        ShedAmount=0.05,
        Threshold=0.78,
        DelayTime=1.5)));
end Loadshed;
