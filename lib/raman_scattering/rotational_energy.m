function [E_rot] = rotational_energy(J, molecular_parameters)
% ROTATIONAL_ENERGY Calculate the rotational energy of a homonuclear diatmoic
% molecule for quantum number J. The molecule is specified by passing a dictionary
% with parameters.
%
% USAGE:
%    [E_rot] = rotational_energy(J, molecular_parameters)
%
% INPUTS:
%    J: numeric
%        Rotation quantum number.
%    molecular_parameters: struct
%        struct with molecular parameters.
%
% OUTPUTS:
%    E_rot: numeric
%        Rotational energy of the molecule. (J)
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

constants = loadConstants();

E_rot = (B0 * J * (J + 1) - D0 * J.^2 * (J + 1).^2) * constants.hc;

end