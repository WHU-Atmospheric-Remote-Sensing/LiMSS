function [alp] = alpha_rayleigh(wavelength, pressure, temperature, C, rh, varargin)
% ALPHA_RAYLEIGH Calculate the extinction coefficient for Rayleigh scattering.
%
% USAGE:
%    [alp] = alpha_rayleigh(wavelength, pressure, temperature, C, rh)
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
%    alpha: float
%        The molecular scattering coefficient [m-1]
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

sigma = sigma_rayleigh(wavelength, pressure, temperature, C, rh);
N = number_density_at_pt(pressure, temperature, rh, p.Results.ASSUME_AIR_IDEAL);

alp = N .* sigma;

end