function [Fk] = kings_factor_N2(wavenumber)
% KINGS_FACTOR_N2 Approximates the King's correction factor for a specific wavenumber.
% According to Bates, the agreement with experimental values is "rather better than 1%".
%
% USAGE:
%    [Fk] = kings_factor_N2(wavenumber)
%
% INPUTS:
%    wavenumber: numeric
%        wavenumber (defined as 1/lambda). (cm-1)
%
% OUTPUTS:
%    Fk: numeric
%        Kings factor for N2.
%
% REFERENCES:
%    [1] Tomasi, C., Vitale, V., Petkov, B., Lupi, A. & Cacciari, A. Improved
%        algorithm for calculations of Rayleigh-scattering optical depth in standard
%        atmospheres. Applied Optics 44, 3320 (2005).
%    [2] Bates, D. R.: Rayleigh scattering by air, Planetary and Space Science, 32(6),
%        785-790, doi:10.1016/0032-0633(84)90102-8, 1984.
%
% HISTORY:
%    2022-10-30: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

lambda_cm = 1 / wavenumber;
lambda_um = lambda_cm * 1e4;

Fk = 1.034 + 3.17e-4 * lambda_um.^(-2);

end