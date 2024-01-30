function [sig] = sigma_rayleigh(wavelength, pressure, temperature, C, rh, varargin)
% SIGMA_RAYLEIGH Calculate the Rayleigh-scattering cross section per molecule.
%
% USAGE:
%    [sig] = sigma_rayleigh(wavelength, pressure, temperature)
%
% INPUTS:
%    wavelength: float
%        wavelength [nm]
%    pressure: float
%        The atmospheric pressure [hPa]
%    temperature: float
%        The atmospheric temperature [K]   
%    C: float
%        CO2 concentration [ppmv].
%    rh: float
%        Relative humidity from 0 to 100 [%]
%
% KEYWORDS:
%    ASSUME_AIR_IDEAL: logical
%        assume ideal gas.
%
% OUTPUTS:
%    sigma: float
%        Rayleigh-scattering cross section [m2]
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'wavelength', @isnumeric);
addRequired(p, 'pressure', @isnumeric);
addRequired(p, 'temperature', @isnumeric);
addRequired(p, 'C', @isnumeric);
addRequired(p, 'rh', @isnumeric);
addParameter(p, 'ASSUME_AIR_IDEAL', true, @islogical);

parse(p, wavelength, pressure, temperature, C, rh, varargin{:});

p_e = rh_to_pressure(rh, temperature);

% Calculate properties of standard air
n = n_air(wavelength, pressure, temperature, C, rh);
N = number_density_at_pt(pressure, temperature, rh, p.Results.ASSUME_AIR_IDEAL);

% Wavelength of radiation
wl_m = wavelength;   % nm

% King's correction factor
f_k = kings_factor_atmosphere(wavelength, C, p_e, pressure);  % no units

% first part of the equation
f1 = (24. * pi .^ 3) ./ (wl_m .^ 4 .* (N * 1e-18) .^ 2);
% second part of the equation
f2 = (n .^ 2 - 1.) .^ 2 ./ (n .^ 2 + 2.) .^ 2;

% result
sig = f1 .* f2 .* f_k;

end