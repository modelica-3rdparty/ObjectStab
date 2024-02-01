within ObjectStab.Generators;
package Controllers "Library for Governor and Excitation system models"





  extends Modelica.Icons.Package;






  annotation (
    Documentation(info="This library contains sample governor and excitation
system models

By default generators are declared with constant power
governor and constant field voltage.

An extended generator model can for example by inheriting from
the basic generator models and augment it with first order
exitation system and governor using the clauses as follows:

model NewGen
  extends ObjectStab.Generators.GovExc6thGen(
    redeclare ObjectStab.Generators.Controllers.FirstOrderExciter Exc,
    redeclare ObjectStab.Generators.Controllers.FirstOrderGovernor Gov);
end NewGen;
"));
end Controllers;
