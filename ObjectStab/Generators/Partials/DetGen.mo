within ObjectStab.Generators.Partials;
partial model DetGen "Common Definitions for Detailed Generator"
  extends Partials.Generator;

  parameter Real Sbase=100 "Generator rated power [MVA]";
  parameter Base.InertiaConstant H=6 "Inertia Constant";
  parameter Base.DampingCoefficient D=0 "Damping Coefficient";
  parameter Base.Resistance rt=0 "Step-up Transformer Resistance";
  parameter Base.Reactance xt=0.0 "Step-up Transformer Reactance";

  inner Base.AngularVelocity w(start=1, stateSelect=StateSelect.prefer)
    "Angular Speed";
  inner Base.VoltageAngle delta(start=0, stateSelect=StateSelect.prefer)
    "Rotor Angle";
  inner Base.MechanicalPower Pm(start=1) "Mechanical Power";
  inner Base.Voltage Efd(start=2) "Field Voltage";
  inner Base.Current Iarm=sqrt(id^2 + iq^2) "Armature Current";
  inner Base.ActivePower Pe(start=1) "Electrical Power";

  Base.Current iq "dq Armature Current";
  Base.Current id;
  Base.Voltage vq "dq Armature Voltage";
  Base.Voltage vd;
  outer Base.AngularVelocity wref;

initial equation
  w = 1;
  Pm = Pe;
  V = V0;
  if isSlack then
    theta = theta0;
  else
    Pg = Pg0;
  end if;

equation
  //   swing equations
  der(w) = 1/(2*H)*(Pm - Pe - D*(w - wref));
  der(delta) = Base.ws*(w - wref);

  // Kron's transformation, see fig 3.30 in Machovski

    // to interface between generators own dq-frame and  system dq-frame
  [T.ia; T.ib] = -[-sin(delta), cos(delta); cos(delta), sin(delta)]*[id; iq]
     *Sbase/Base.Sbase;

  [1 + T.va; T.vb] = [-sin(delta), cos(delta); cos(delta), sin(delta)]*([vd;
      vq] + [rt, -xt; xt, rt]*[id; iq]);

  // contribute to angle reference calculation
  wrl.wr.Hwsum = if online then H*w*(Sbase/Base.Sbase) else 0;
  wrl.wr.Hsum = if online then H*(Sbase/Base.Sbase) else 0;

  annotation (
    Documentation(info="Common definitions for detailed generator models, including the generator step-up
transformer.

At least one slack node or detailed generator with its attribute 'isSlack'
set to true must be included in each network model. For this generator the
attribute Pg0 is not used. For generators with 'isSlack' set to false, the
attribute theta0 is not used. Tripping of the generator can be simulated
by setting the tripping time in the attribute 'TripTime'.

Each generator has it's own dq coordinate system, and its stator equations
must therefore be related to the network (global) coordinate system using the
so called Kron's transformations [1, pp. 90].


---
[1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and
Stability, Number ISBN 0-471-97174. Wiley, 1993.
"));
end DetGen;
