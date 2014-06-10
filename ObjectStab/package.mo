within ;
package ObjectStab "ObjectStab - A Modelica Library for Power System Stability Studies"
extends Modelica.Icons.Library;


annotation (
  Documentation(info="
<HTML>
<p>The ObjectStab package is a Modelica Library for Power Systems Voltage and
Transient stability simulations and presently contains the following component models :</p>
<ul>
  <li> Generators with constant frequency and voltage as slack or PV nodes, or using 3rd or 6th<br>
 order dq-models with excitation and prime mover control systems.</li>
  <li>Transmission lines in pi-link or series impedance representation.</li>
  <li>Reactive power compensation devices; shunt reactors, shunt capacitances and series capacitances according to
    [1].</li>
  <li>Fixed ratio transformers.</li>
  <li>On-load tap changing transformers (OLTC) modeled as detailed discrete<br>
 models or using  their corresponding continuous approximations according<br>
 to [2].</li>
  <li>Static and dynamic loads, including  induction motor according to [1] and generic exponential recovery loads
    according to [3].</li>
  <li>Buses.</li>
  <li>Faulted lines and buses including fault impedance.</li>
</ul>
<p>Standard assumptions for multi-machine transient stability<br>
simulations are made, i.e.,  generator stator and network time constants are neglected and voltages and currents are assumed to
be sinusoidal and symmetrical.  Except where other references are given, the components are modeled according to the guidelines
given in [1].&nbsp;<br>
<br>
 The component library has been validated using comparative simulations with <b>EUROSTAG</b>
[4]. The library has been developed and tested using <b>DYMOLA</b>
version 5.0, 2002-09-19, however it should work with any versions higher than 4.2a.</p>
<p><b>REFERENCES</b></p>
<p>[1] J. Machowski, J.W. Bialek, and J.R. Bumby, <i>Power System Dynamics and
Stability</i>, Number ISBN 0-471-97174. Wiley, 1993.</p>
<p>[2] P.W. Sauer and M.A. Pai, &quot;A comparison of discrete vs. continuous dynamic models of
tap-changing-under-load transformers&quot;, in <i>Proceedings of NSF/ECC Workshop on Bulk power System Voltage<br>
  Phenomena - III : Voltage Stability, Security and Control</i>,&nbsp; Davos, Switzerland, 1994.</p>
<p>[3] D. Karlsson and D.J. Hill, &quot;Modelling and identification of nonlinear dynamic loads in power
systems'',<i> IEEE Transactions on Power Systems</i>, vol. 9, no. 1, pp.
157-163, February 1994.</p>
<p>[4] J. Deuse and M. Stubbe, &quot;Dynamic simulation of voltage collapses&quot;,
<i>IEEE Transactions on Power Systems</i>, vol. 8, no. 3, pp. 894-904, August 1993.</p>
<p><b>Main Author:</b></p>
<dl>
  <dd><b> Mats Larsson.</b></dd>
 <dd><b> The ObjectStab logotype was designed by Thomas Stendahl.</b></dd>
  <dt>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</dt>
</dl>

<BR>
If you are a user of the ObjectStab library, please join the ObjectStab mailing list
at Yahoo groups to receive information about updates and common usage problems. If you do
not yet have an Yahoo groups ID you will first have to register.
<center>
<a href=\"http://groups.yahoo.com/group/objectstab/join\">
<img src=\"http://groups.yahoo.com/img/ui/join.gif\" border=0><br>
Click to subscribe to objectstab</a>
</center>

<BR>


<p><b>Release Notes:</b></p>
<ul>
  <LI><I>Version 1.0c (September 25, 2002) -</I> Fixed compatibility issues with Dymola 4.3/5.0.</LI>
  <LI><I>Version 1.0b (May 13, 2002) -</I> Fixed minor bugs before inclusion in Dymola distribution.</LI>
  <LI><I>Version 1.0 (February 28, 2002) -</I> Major update, initialization greatly enhanced
using new features in Modelica V2.0. Now uses petri net library from ModelicaAdditions library.</LI>
  <LI><I>Version 0.4 (November 6, 2000) -</I> Changed ninebus test system to avoid
'model too complex for demo version'-error during compilation</LI>
  <LI><I>Version 0.3 (November 1, 2000) -</I> Major update, method of initialization changed
  and support for variable frequency reference using COI added</LI>
  <LI><I>Version 0.2 (November 15, 1999) -</I> Fixed bug in Impedance and
   Admittance Load models</LI>
  <li><i>Version 0.1 (November 7, 1999)</i><br>
    The first version of the ObjectStab library is based on the following
    subpackages:
    <ul>
      <li>ObjectStab.Base
      <li>ObjectStab.Network
      <li>ObjectStab.Loads
      <li>ObjectStab.Generators</li>
      <li>ObjectStab.Examples</li>
      <li>ObjectStab.petrii1 (the Dymola Petri net library&nbsp; translated from
        the Dymola source.)</li>
    </ul>
  </li>
</ul>



The ObjectStab package is <b>free</b> software;
it can be redistributed and/or modified
under the terms of the
<a href=\"http://www.modelica.org/library/ModelicaLicense.html\"><b>Modelica license</b></a>
and the accompanying <b>disclaimer</b>.
</i></p>

<b>Copyright (C) 1999-2002, Mats Larsson.</b>

</html>
"),
uses(Modelica(version="2.2.2")));
end ObjectStab;
