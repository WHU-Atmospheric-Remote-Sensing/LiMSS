function [n_axs] = n_standard_air_with_CO2(wavelength, C)
% N_STANDARD_AIR_WITH_CO2 The refractive index of air at a specific wavelength including CO2.
%
% USAGE:
%    [n_axs] = n_standard_air_with_CO2(wavelength, C)
%
% INPUTS:
%    wavelength: numeric
%        wavelength. (nm)
%    C: numeric
%        CO2 concentration. (ppmv)
%
% OUTPUTS:
%    n_axs: numeric
%        Refractive index of air for the specified CO2 concentration.
%
% EXAMPLE:
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

C2 = 450;

n_as = n_standard_air(wavelength);

n_axs = 1 + (n_as - 1) .* (1 + 0.534e-6 .* (C - C2));

end