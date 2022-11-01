function [n_wv] = n_water_vapor(wavelength)
% N_WATER_VAPOR The refractive index of water vapor.
%
% USAGE:
%    [n_wv] = n_water_vapor(wavelength)
%
% INPUTS:
%    wavelength: numeric
%        wavelength. (nm)
%
% OUTPUTS:
%    n_wv: numeric
%        Refractive index of water vapor.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

wl_micrometers = wavelength / 1000.0;   % Convert nm to um

s = 1 / wl_micrometers;   % the reciprocal of wavelength

c1 = 1.022;
c2 = 295.235;
c3 = 2.6422;
c4 = 0.032380;   % Defined positive
c5 = 0.004028;

n_wv = 1 + c1 .* (c2 + c3 * s.^2 - c4 * s.^4 + c5 * s.^6) * 1e-8;

end