function [e] = epsilon_N2(wavenumber)
% EPSILON_N2 Return the epsilon parameter of N2 for a given wavelength.
%
% USAGE:
%    [e] = epsilon_N2(wavenumber)
%
% INPUTS:
%    wavenumber: numeric
%        wavenumber in cm-1.
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

Fk = kings_factor_N2(wavenumber);

e = (Fk - 1) * 9 / 2;

end