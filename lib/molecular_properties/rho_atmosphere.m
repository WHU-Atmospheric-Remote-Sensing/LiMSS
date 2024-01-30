function [rho] = rho_atmosphere(wavelength, C, P_e, p_t)
% RHO_ATMOSPHERE Calculate the depolarization factor of the atmosphere.
%
% USAGE:
%    [rho] = rho_atmosphere(wavelength, C, P_e, p_t)
%
% INPUTS:
%    wavelength: numeric
%        wavelength in nm.
%    C: numeric
%        CO2 concentration in ppmv.
%    p_e: numeric
%        water-vapor pressure in hPa.
%    p_t: numeric
%        total air pressure in hPa.
%
% OUTPUTS:
%    rho: numeric
%        depolarization factor.
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

F_k = kings_factor_atmosphere(wavelength, C, P_e, p_t);

rho = (6 * F_k - 6) ./ (7 * F_k + 3);

end