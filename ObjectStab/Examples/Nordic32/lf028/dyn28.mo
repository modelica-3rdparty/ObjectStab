within ObjectStab.Examples.Nordic32.lf028;
model dyn28
  extends lf32_028(
    redeclare Nordic32.Models.GenB6 Gen1012(Sbase=800.000000),
    redeclare Nordic32.Models.GenB6 Gen1013(Sbase=600.000000),
    redeclare Nordic32.Models.GenB6 Gen1014(Sbase=700.000000),
    redeclare Nordic32.Models.GenB6 Gen1021(Sbase=600.000000),
    redeclare Nordic32.Models.GenB6 Gen1022(Sbase=250.000000),
    redeclare Nordic32.Models.GenA6 Gen1042(Sbase=400.000000),
    redeclare Nordic32.Models.GenA6 Gen1043(Sbase=200.000000),
    redeclare Nordic32.Models.GenB6 Gen2032(Sbase=850.000000),
    redeclare Nordic32.Models.GenB6 Gen4012(Sbase=800.000000),
    redeclare Nordic32.Models.GenB6 Gen4021(Sbase=300.000000),
    redeclare Nordic32.Models.GenB6 Gen4031(Sbase=350.000000),
    redeclare Nordic32.Models.GenC6 Gen4041(Sbase=300.000000),
    redeclare Nordic32.Models.GenA6 Gen4042(Sbase=700.000000),
    redeclare Nordic32.Models.GenA6 Gen4047(Sbase=1200.00000),
    redeclare Nordic32.Models.GenA6 Gen4051(Sbase=1400.00000),
    redeclare Nordic32.Models.GenA6 Gen4062(Sbase=600.000000),
    redeclare Nordic32.Models.GenA6 Gen4063(Sbase=1200.00000),
    redeclare Nordic32.Models.GenB6 Gen4071(Sbase=500.000000, redeclare
        Nordic32.Models.SweGov Gov(Rstat=0.08, Rdyn=1.6)),
    redeclare Nordic32.Models.GenB6 Gen4072(Sbase=4500.00000, redeclare
        Nordic32.Models.SweGov Gov(Rstat=0.08, Rdyn=1.6)),
    redeclare Nordic32.Models.GenB6 Gen4011(
      Pg0=6.69614219665527,
      Sbase=1000.000000,
      isSlack=true),
    redeclare ObjectStab.Network.TCULDis Tr40441044(
      R=0.000000,
      X=0.005000,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        Td0=40,
        Tm0=7)),
    redeclare ObjectStab.Network.TCULDis Tr40451045(
      R=0.000000,
      X=0.005000,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        Td0=40,
        Tm0=8)),
    redeclare ObjectStab.Network.TCULDis Tr404141(
      R=0.000000,
      X=0.009674,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=6)),
    redeclare ObjectStab.Network.TCULDis Tr404242(
      R=0.000000,
      X=0.012576,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=7.9)),
    redeclare ObjectStab.Network.TCULDis Tr404343(
      R=0.000000,
      X=0.006555,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=6.5)),
    redeclare ObjectStab.Network.TCULDis Tr404646(
      R=0.000000,
      X=0.009364,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=7.5)),
    redeclare ObjectStab.Network.TCULDis Tr404747(
      R=0.000000,
      X=0.040000,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=6.1)),
    redeclare ObjectStab.Network.TCULDis Tr405151(
      R=0.000000,
      X=0.007000,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=7.4)),
    redeclare ObjectStab.Network.TCULDis Tr406161(
      R=0.000000,
      X=0.012173,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=6.6)),
    redeclare ObjectStab.Network.TCULDis Tr406262(
      R=0.000000,
      X=0.019348,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=7.1)),
    redeclare ObjectStab.Network.TCULDis Tr406363(
      R=0.000000,
      X=0.009364,
      Controller(
        method=1,
        stepsize=0.01,
        maxtap=12,
        mintap=-12,
        DB=0.03,
        Td0=40,
        Tm0=6.2)));
end dyn28;
