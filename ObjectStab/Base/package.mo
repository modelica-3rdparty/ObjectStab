within ObjectStab;
package Base "Base package"
  extends Modelica.Icons.Package;

  // Time and Space

  // per.unit. definitions - Electric  voltage and current phasors

  // nominal frequency
  constant Real f0=50;
  constant AngularVelocity ws=2*Modelica.Constants.pi*f0;

  // System Sbase (in MVA)
  constant ApparentPower Sbase=100;

  //











  annotation (
    Documentation(info="The base package contains definitions common to all
subpackages, including the new datatypes for the p.u.
quantities are defined.

The constant f0 sets the rated frequency.
This can be changed into 60 Hz for american users.
"));
end Base;
