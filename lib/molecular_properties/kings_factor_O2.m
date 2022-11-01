function [Fk] = kings_factor_O2(wavenumber)
% KINGS_FACTOR_O2 Approximates the King's correction factor for a specific wavelength.
%
% USAGE:
%    [Fk] = kings_factor_O2(wavenumber)
%
% INPUTS:
%    wavenumber: numeric
%        wavenumber in cm-1.
%
% OUTPUTS:
%    Fk: numeric
%        King's factor for O2.
%
% REFERENCES:
%    [1] Tomasi, C., Vitale, V., Petkov, B., Lupi, A. & Cacciari, A. Improved
%        algorithm for calculations of Rayleigh-scattering optical depth in standard
%        atmospheres. Applied Optics 44, 3320 (2005).
%
% HISTORY:
%    2022-10-30: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

lambda_cm = 1 / wavenumber;
lambda_um = lambda_cm * 1e4;

Fk = 1.096 + 1.385e-3 * lambda_um.^(-2) + 1.448e-4 * lambda_um.^(-4);

end