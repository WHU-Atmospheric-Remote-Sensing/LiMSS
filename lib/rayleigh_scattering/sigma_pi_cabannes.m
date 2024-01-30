function [sigma_pi] = sigma_pi_cabannes(wavelength, pressure, temperature, C, rh, varargin)
% SIGMA_PI_CABANNES Calculate the backscattering cross section for the cabannes line.
%
% USAGE:
%    [sigma_pi] = sigma_pi_cabannes(wavelength, pressure, temperature, C, rh)
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
%    sigma_pi: numeric
%        The backscattering cross section of the Cabannes line. (m^2 sr^-1)
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
epsilon = epsilon_atmosphere(wavelength, C, p_e, pressure);

n = n_air(wavelength, pressure, temperature, C, rh);
N = number_density_at_pt(pressure, temperature, rh, p.Results.ASSUME_AIR_IDEAL);

lambda_m = wavelength * 1e-9;

f1 = 9 * pi.^2 ./ (lambda_m.^4 .* N.^2);
f2 = (n.^2 - 1).^2 ./ (n.^2 + 2).^2;
f3 = 1 + 7/ 180 .* epsilon;

sigma_pi = f1 .* f2 .* f3;

end