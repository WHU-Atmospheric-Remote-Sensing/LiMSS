function [beta_pi] = beta_pi_cabannes(wavelength, pressure, temperature, C, rh, varargin)
% BETA_PI_CABANNES Calculate the backscattering coefficient for the cabannes line.
%
% USAGE:
%    [beta_pi] = beta_pi_cabannes(wavelength, pressure, temperature, C, rh)
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
% OUTPUTS:
%    beta_pi: numeric
%        The backscattering coefficient of the Cabannes line (m^-1 sr^-1).
%
% EXAMPLE:
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

sigma_pi = sigma_pi_cabannes(wavelength, pressure, temperature, C, rh);
N = number_density_at_pt(pressure, temperature, rh, p.Results.ASSUME_AIR_IDEAL);

beta_pi = N .* sigma_pi;

end