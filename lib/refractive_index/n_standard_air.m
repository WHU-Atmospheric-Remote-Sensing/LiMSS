function [ns] = n_standard_air(wavelength)
% N_STANDARD_AIR The refractive index of air at a specific wavelength with CO2 concentration 450 ppmv.
%
% USAGE:
%    [ns] = n_standard_air(wavelength)
%
% INPUTS:
%    wavelength: numeric
%        wavelength. (nm)
%
% OUTPUTS:
%    ns: numeric
%        Refractivity of standard air with C = 450 ppmv.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

wl_um = wavelength / 1000;

s = 1 ./ wl_um;
c1 = 5792105.;
c2 = 238.0185;
c3 = 167917.;
c4 = 57.362;
ns = 1 + (c1 ./ (c2 - s.^2) + c3 ./ (c4 - s.^2)) * 1e-8;

end