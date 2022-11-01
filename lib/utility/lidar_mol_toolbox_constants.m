function [constants] = lidar_mol_toolbox_constants()

constants = struct();

constants.N2_parameters = struct();
constants.N2_parameters.name = 'N_{2}';
constants.N2_parameters.B0 = 1.989500;
constants.N2_parameters.D0 = 5.76e-6;
constants.N2_parameters.I = 1;
constants.N2_parameters.gamma_square = @(x) gamma_square_N2(x);
constants.N2_parameters.epsilon = @(x) epsilon_N2(x);
constants.N2_parameters.g = [6, 3];
constants.N2_parameters.relative_concentration = 0.79;

constants.O2_parameters = struct();
constants.O2_parameters.name = 'O_{2}';
constants.O2_parameters.B0 = 1.437682;
constants.O2_parameters.D0 = 4.85e-6;
constants.O2_parameters.I = 0;
constants.O2_parameters.gamma_square = @(x) gamma_square_O2(x);
constants.O2_parameters.epsilon = @(x) epsilon_O2(x);
constants.O2_parameters.g = [0, 1];
constants.O2_parameters.relative_concentration = 0.21;

% physical 
constants.h = 6.626070040e-34;   % plank constant in J s
constants.c = 299792458.;   % speed of light in m s-1
constants.k_b = 1.38064852 * 1e-23;   % Boltzmann constant in J/K
% constants.k_b = 1.3806504 * 10**-23  % J/K  - Folker value

% Molar gas constant
% constants.R = 8.3144598  % in J/mol/K --
constants.R = 8.314510;   % Value in Ciddor 1996.


% plank constant * speed of light in cm * J
constants.hc = constants.h * constants.c * 100;   % cm * J

% plank constant * speed of light / Boltzmann constant in cm * K
constants.hc_k = constants.h * constants.c / constants.k_b * 100;   % cm * K

end