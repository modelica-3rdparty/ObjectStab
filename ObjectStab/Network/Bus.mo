within ObjectStab.Network;
model Bus "Busbar model"
  extends ObjectStab.Base.OnePinCenter;
  Base.Voltage V=sqrt((1 + T.va)*(1 + T.va) + T.vb*T.vb) "Voltage Amplitude";
  Base.VoltageAngle theta=Modelica.Math.atan2(T.vb, (1 + T.va)) "Voltage Angle";
  Real thetadeg=theta*180/Modelica.Constants.pi;
equation
  T.ia = 0;
  T.ib = 0;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={2,2}), graphics={Rectangle(
          extent={{-12,80},{10,-80}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid), Text(extent={{98,-102},{-98,-80}},
            textString=                                             "%name")}));
end Bus;
