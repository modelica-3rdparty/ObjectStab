within ObjectStab.Examples.BPA;
model taplock
  extends linefault(T6(Controller(
        method=3,
        Vref=0.922,
        maxtap=15,
        mintap=-15,
        stepsize=0.01,
        DB=0.02,
        Vblock=0.82)));
end taplock;
