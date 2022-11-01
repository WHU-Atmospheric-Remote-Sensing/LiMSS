function [Fk] = kings_factor_H2O()
% KINGS_FACTOR_H2O Return the King's correction factor of H2O.
%
% USAGE:
%    [Fk] = kings_factor_H2O()
%
% OUTPUTS:
%    Fk: numeric
%        King's factor for H2O.
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

Fk = 1.001;

end