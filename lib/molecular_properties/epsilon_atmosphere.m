function [e] = epsilon_atmosphere(wavelength, varargin)
% EPSILON_ATMOSPHERE Return Calculate the combined epsilon for the atmosphere.
%
% USAGE:
%    [e] = epsilon_atmosphere(wavelength)
%
% INPUTS:
%    wavelength: numeric
%        wavelength. (nm)
%
% KEYWORDS:
%    C: numeric
%        CO2 concentration in ppmv.
%    p_e: numeric
%        water-vapor pressure in hPa.
%    p_t: numeric
%        total air pressure in hPa.
%
% OUTPUTS:
%    e: numeric
%
% REFERENCES:
%    [1] She, C.-Y. Spectral structure of laser light scattering revisited: 
%        bandwidths of nonresonant scattering lidars. 
%        Appl. Opt. 40, 4875-4884 (2001)
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

Fk = kings_factor_atmosphere(wavelength, varargin{:});

e = (Fk - 1) * 9 / 2;

end