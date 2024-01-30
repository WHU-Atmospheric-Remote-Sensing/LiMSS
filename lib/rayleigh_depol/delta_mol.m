function [delta_m] = delta_mol(n_incident, molecular_parameters, relative_transmissions, varargin)
% DELTA_MOL Calculates the depoalrization ratio of the molecular signal detected by a lidar.
%
% USAGE:
%    [delta_m] = delta_mol(n_incident, molecular_parameters, relative_transmissions)
%
% INPUTS:
%    n_incident: numeric
%        wavenumber of the incident light (cm-1)
%    molecular_parameters: cell
%        cells of molecular parameters.
%    relative_transmissions: numeric
%        relative transmissions of molecules.
%
% OUTPUTS:
%    delta_m: numeric
%        molecular depolarization ratio.
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'n_incident', @isnumeric);
addRequired(p, 'molecular_parameters', @iscell);
addRequired(p, 'relative_transmissions', @isnumeric);

parse(p, n_incident, molecular_parameters, relative_transmissions);

concentrations = [];
gamma_squares = [];
epsilons = [];
for iParam = 1:length(molecular_parameters)
    concentrations = cat(2, concentrations, molecular_parameters{iParam}.relative_concentration);

    if isa(molecular_parameters{iParam}.epsilon, 'function_handle')
        epsilons = cat(2, epsilons, molecular_parameters{iParam}.epsilon(n_incident));
    else
        epsilons = cat(2, epsilons, molecular_parameters{iParam}.epsilon);
    end

    if isa(molecular_parameters{iParam}.gamma_square, 'function_handle')
        gamma_squares = cat(2, gamma_squares, molecular_parameters{iParam}.gamma_square(n_incident, varargin{:}));
    else
        gamma_squares = cat(2, gamma_squares, molecular_parameters{iParam}.gamma_square);
    end
end

numerator = sum(concentrations .* gamma_squares .* (3 * relative_transmissions + 1));
denominator = sum(concentrations .* gamma_squares .* (3 * relative_transmissions + 1 + 45 ./ epsilons));

delta_m = 3.0 / 4 * numerator / denominator;

end