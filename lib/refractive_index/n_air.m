function [n] = n_air(wavelength, pressure, temperature, C, relative_humidity)
% N_AIR Calculate the refractive index of air.
%
% USAGE:
%    [n] = n_air(wavelength, pressure, temperature, C, relative_humidity)
%
% INPUTS:
%    wavelength: numeric
%        Light wavelength. (nm)
%    pressure: numeric
%        Atmospheric pressure. (hPa)
%    temperature: numeric
%        Atmospheric temperature. (K)
%    C: numeric
%        Concentration of CO2. (ppmv)
%    relative_humidity: numeric
%        Relative humidity from 0 to 200. (%)
%
% OUTPUTS:
%    n: numeric
%        Refractive index of air.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'wavelength', @isnumeric);
addRequired(p, 'temperature', @isnumeric);
addRequired(p, 'C', @isnumeric);
addRequired(p, 'relative_humidity', @isnumeric);

parse(p, wavelength, temperature, C, relative_humidity);

Xw = molar_fraction_water_vapor(pressure, temperature, relative_humidity);

rho_axs = moist_air_density(1013.25, 299.15, C, 0);
rho_ws = moist_air_density(13.33, 293.15, 0, 1);

[~, rho_a, rho_w] = moist_air_density(pressure, temperature, C, Xw);

n_axs = n_standard_air_with_CO2(wavelength, C);
n_ws = n_water_vapor(wavelength);

n = 1 + (rho_a ./ rho_axs) .* (n_axs - 1) + (rho_w + rho_ws) .* (n_ws - 1);

end