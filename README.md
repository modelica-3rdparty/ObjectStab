# ObjectStab Library

A Modelica Library for Power System Stability Studies

## Library description

The ObjectStab package is a Modelica Library for Power Systems Voltage and Transient stability simulations and presently contains the following component models:

 * Generators with constant frequency and voltage as slack or PV nodes, or using 3rd or 6th order dq-models with excitation and prime mover control systems.
 * Transmission lines in pi-link or series impedance representation.
 * Reactive power compensation devices; shunt reactors, shunt capacitances and series capacitances according to [1].
 * Fixed ratio transformers.
 * On-load tap changing transformers (OLTC) modeled as detailed discrete models or using their corresponding continuous approximations according to [2].
 * Static and dynamic loads, including induction motor according to [1] and generic exponential recovery loads according to [3].
 * Buses.
 * Faulted lines and buses including fault impedance.

Standard assumptions for multi-machine transient stability
simulations are made, i.e., generator stator and network time constants are neglected and voltages and currents are assumed to be sinusoidal and symmetrical. Except where other references are given, the components are modeled according to the guidelines given in [1].

## References
 - [1] J. Machowski, J.W. Bialek, and J.R. Bumby, Power System Dynamics and Stability, Number ISBN 0-471-97174. Wiley, 1993.
 - [2] P.W. Sauer and M.A. Pai, "A comparison of discrete vs. continuous dynamic models of tap-changing-under-load transformers", in Proceedings of NSF/ECC Workshop on Bulk power System Voltage Phenomena - III: Voltage Stability, Security and Control,  Davos, Switzerland, 1994.
 - [3] D. Karlsson and D.J. Hill, "Modelling and identification of nonlinear dynamic loads in power systems", IEEE Transactions on Power Systems, vol. 9, no. 1, pp. 157-163, February 1994.
 - [4] J. Deuse and M. Stubbe, "Dynamic simulation of voltage collapses", IEEE Transactions on Power Systems, vol. 8, no. 3, pp. 894-904, August 1993.

## Current release

Download [Latest development version](../../archive/master.zip)

#### Release notes

* [Version v1.0.3 (2002-09-25)](../../archive/v1.0.3.zip)
  * Fixed compatibility issues with Dymola 4.3/5.0.

## License
Copyright &copy; 1999-2002, Mats Larsson

This Modelica package is free software and the use is completely at your own risk;
it can be redistributed and/or modified under the terms of the [Modelica License 1.1](https://modelica.org/licenses/ModelicaLicense1.1).

## Development and contribution
You may report any issues with using the [Issues](../../issues) button.

Contributions in shape of [Pull Requests](../../pulls) are always welcome.
