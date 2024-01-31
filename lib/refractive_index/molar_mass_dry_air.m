function [Ma] = molar_mass_dry_air(C)
% MOLAR_MASS_DRY_AIR Molar mass of dry air, as a function of CO2 concentration.
%
% USAGE:
%    [Ma] = molar_mass_dry_air(C)
%
% INPUTS:
%    C: numeric
%        CO2 concentration. (ppmv)
%
% OUTPUTS:
%    Ma： numeric
%        Molar mass of dry air. (kg/mol)
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

C1 = 400;

Ma = 1e-3 * (28.9635 + 12.011e-6 * (C - C1));

end