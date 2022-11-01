function [rho, rho_air, rho_wv] = moist_air_density(pressure, temperature, C, Xw)
% MOIST_AIR_DENSITY Calculate the moist air density using the BIPM 1981/91 equation.
%
% USAGE:
%    [rho, rho_air, rho_wv] = moist_air_density(pressure, temperature, C, Xw)
%
% INPUTS:
%    pressure: numeric
%        Total pressure. (hPa)
%    temperature: numeric
%        Atmospheric temperature. (K)
%    C: numeric
%        CO2 concentration. (ppmv)
%    Xw: numeric
%        Molar fraction of water vapor.
%
% OUTPUTS:
%    rho: numeric
%        density of total air.
%    rho_air: numeric
%        density of dry air.
%    rho_wv: numeric
%        density of water vapor.
%
% REFERENCES:
%    [1] Tomasi, C., Vitale, V., Petkov, B., Lupi, A. & Cacciari, A. Improved 
%        algorithm for calculations of Rayleigh-scattering optical depth in standard 
%        atmospheres. Applied Optics 44, 3320 (2005).
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'pressure', @isnumeric);
addRequired(p, 'temperature', @isnumeric);
addRequired(p, 'C', @isnumeric);
addRequired(p, 'Xw', @isnumeric);

parse(p, pressure, temperature, C, Wx);

constants = lidar_mol_toolbox_constants();

Ma = molar_mass_dry_air(C);
Mw = 0.018015;

Z = compressibility_of_moist_air(pressure, temperature, Xw);

P = pressure * 100;
T = temperature;

rho = P .* Ma ./ (Z .* constants.R .* T) .* (1 - Xw .* (1 - Mw ./ Ma));

rho_air = (1 - Xw) .* P .* Ma ./ (Z .* constants.R .* T);
rho_wv = Xw .* Mw ./ (z .* constants.R .* T);

end