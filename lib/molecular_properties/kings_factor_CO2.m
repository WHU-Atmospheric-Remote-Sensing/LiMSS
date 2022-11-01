function [Fk] = kings_factor_CO2()
% KINGS_FACTOR_CO2 Return the King's correction factor of CO2.
%
% USAGE:
%    [Fk] = kings_factor_CO2()
%
% OUTPUTS:
%    Fk: numeric
%        King's factor for CO2.
%
% REFERENCES:
%    [1] Tomasi, C., Vitale, V., Petkov, B., Lupi, A. & Cacciari, A. Improved
%        algorithm for calculations of Rayleigh-scattering optical depth in standard 
%        atmospheres. Applied Optics 44, 3320 (2005).
%    [2] Alms et al. Measurement of the discpersion in polarizability anisotropies.
%        Journal of Chemical Physics (1975)
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

Fk = 1.15;

end