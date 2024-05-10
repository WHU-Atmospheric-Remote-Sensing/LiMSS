function [Z] = compressibility_of_moist_air(pressure, temperature, molar_fraction)
% COMPRESSIBILITY_OF_MOIST_AIR Compressibility of moist air.
%
% USAGE:
%    [Z] = compressibility_of_moist_air(pressure, temperature, molar_fraction)
%
% INPUTS:
%    pressure: numeric
%        Atmospheric pressure. (hPa)
%    temperature: numeric
%        Atmospheric temperature. (K)
%    molar_fraction: numeric
%        Molar fraction.
%
% OUTPUTS:
%    Z: numeric
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

a0 = 1.58123e-6;   % K Pa-1
a1 = -2.9331e-8;   % Pa-1
a2 = 1.1043e-10;   % K Pa-1
b0 = 5.707e-6;   % K Pa-1
b1 = -2.051e-8;   % Pa-1
c0 = 1.9898e-4;   % Pa-1
c1 = -2.376e-6;   % Pa-1
d0 = 1.83e-11;   % K2 Pa-2
d1 = -7.65e-9;   % K2 Pa-2

P = pressure * 100.;   % in Pa
T = temperature;
Tc = temperature - 273.15;   % in C

Xw = molar_fraction;

Z = 1 - (P ./ T) .* (a0 + a1 * Tc + a2 * Tc.^2 + (b0 + b1 * Tc) .* Xw + (c0 + c1 * Tc) .* Xw.^2) + (P ./ T).^2 .* (d0 + d1 * Xw.^2);

end