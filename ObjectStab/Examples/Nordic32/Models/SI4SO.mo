within ObjectStab.Examples.Nordic32.Models;
model SI4SO
  extends Modelica.Blocks.Interfaces.BlockIcon;

public
  Modelica.Blocks.Interfaces.RealInput inPort1
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput inPort2
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput inPort3
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput inPort4
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealOutput outPort
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
protected
  Real u1=inPort1 "Input signal 1";
  Real u2=inPort2 "Input signal 2";
  Real u3=inPort3 "Input signal 3";
  Real u4=inPort4 "Input signal 4";
  Real y=outPort "Output signal";
end SI4SO;
