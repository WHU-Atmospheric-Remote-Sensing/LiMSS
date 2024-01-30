function [beta_pi] = beta_pi_rayleigh(wavelength, pressure, temperature, C, rh, varargin)
% BETA_PI_RAYLEIGH Calculate the total Rayleigh backscatter coefficient.
%
% USAGE:
%    [beta_pi] = beta_pi_rayleigh(wavelength, pressure, temperature, C, rh)
%
% INPUTS:
%    wavelength: float
%        Wavelength [nm]
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
%    beta_pi: numeric
%        molecule backscatter coefficient. [m^{-1}sr^{-1}]
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

dsigma_pi = dsigma_phi_rayleigh(pi, wavelength, pressure, temperature, C, rh);
N = number_density_at_pt(pressure, temperature, rh, p.Results.ASSUME_AIR_IDEAL);

beta_pi = dsigma_pi .* N;

end
