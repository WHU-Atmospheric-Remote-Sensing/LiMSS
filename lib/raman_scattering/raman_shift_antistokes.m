function [delta_n] = raman_shift_antistokes(J, molecular_parameters)
% RAMAN_SHIFT_ANTISTOKES Calculate the rotational Raman shift for the anti-Stokes
% branch for quantum number J.
%
% USAGE:
%    [delta_n] = raman_shift_antistokes(J, molecular_parameters)
%
% INPUTS:
%    J: numeric
%        Rotational quantum number.
%    molecular_parameters: struct
%        struct containing molecular parameters.
%
% OUTPUTS:
%    delta_n: numeric
%        Rotational Raman shift. (cm-1)
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'J', @isnumeric);
addRequired(p, 'molecular_parameters', @isstruct);

parse(p, J, molecular_parameters);

B0 = molecular_parameters.B0;
D0 = molecular_parameters.D0;

delta_n = B0 * 2 * (2 * J - 1) - D0 * (3 * (2 * J - 1) + (2 * J - 1).^3);

end