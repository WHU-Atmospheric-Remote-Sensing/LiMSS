function [Fk] = kings_factor_Ar()
% KINGS_FACTOR_AR Return the King's correction factor of Ar.
% According to Tomasi et al. (2005), it's wavelength independent and equal to 1.
%
% USAGE:
%    [Fk] = kings_factor_Ar()
%
% OUTPUTS:
%    Fk: numeric
%        King's factor for Ar.
%
% REFERENCES:
%    [1] Tomasi, C., Vitale, V., Petkov, B., Lupi, A. & Cacciari, A. Improved
%        algorithm for calculations of Rayleigh-scattering optical depth in standard 
%        atmospheres. Applied Optics 44, 3320 (2005).
%    [2] Alms et al. Measurement of the discpersion in polarizability anisotropies.
%        Journal of Chemical Physics (1975)
%
% HISTORY:
%    2022-10-30: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

Fk = 1.0;

end