function [b_s] = cross_section_antistokes(n_incident, J, temperature, molecular_parameters)
% CROSS_SECTION_ANTISTOKES Calculate the rotational Raman backscattering cross section
% for the anti-Stokes branch for quantum number J at a temperature T.
%
% USAGE:
%    [b_s] = cross_section_antistokes(n_incident, J, temperature, molecular_parameters)
%
% INPUTS:
%    n_incident: numeric
%        wavenumber of incident light. (cm-1)
%    J: numeric
%        Rotational quantum number.
%    temperature: numeric
%        The ambient temperature (K)
%    molecular_parameters: struct
%        struct containing molecular parameters.
%
% OUTPUTS:
%    b_s: float
%        Scattering cross section. (cm^2*sr^-1)
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'n_incident', @isnumeric);
addRequired(p, 'J', @isnumeric);
addRequired(p, 'temperature', @isnumeric);
addRequired(p, 'molecular_parameters', @isstruct);

parse(p, n_incident, J, temperature, molecular_parameters);

B0 = molecular_parameters.B0;

gamma_square_input = molecular_parameters.gamma_square;

if isa(gamma_square_input, 'function_handle')
    gamma_square = gamma_square_input(n_incident);
else
    gamma_square = gamma_square_input;
end

g_index = mod(J, 2);
g = molecular_parameters.g(g_index + 1);
constants = loadConstants();

b_s = 64 * pi^4 * constants.hc_k / 15;
b_s = b_s * g * B0 * (n_incident + raman_shift_stokes(J, molecular_parameters)).^4 * gamma_square;
b_s = b_s ./ (2 * molecular_parameters.I + 1).^2 .* temperature;
b_s = b_s * J .* (J - 2) ./ (2 * J - 1);
b_s = b_s * exp(-rotational_energy(J, molecular_parameters) ./ (constants.k_b * temperature));

end