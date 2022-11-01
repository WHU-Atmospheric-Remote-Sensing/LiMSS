function [dSig] = dsigma_phi_rayleigh(theta, wavelength, pressure, temperature, C, rh)
% DSIGMA_PHI_RAYLEIGH Calculates the angular rayleigh scattering cross section per molecule.
%
% USAGE:
%    [dSig] = dsigma_phi_rayleigh(theta, wavelength, pressure, temperature, C, rh)
%
% INPUTS:
%    theta: float
%        Scattering angle [rads]
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
% OUTPUTS:
%    dSig: numeric
%        rayleigh-scattering cross section [m^2sr^-1]
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

phase = phase_function(theta, wavelength, pressure, temperature, C, rh);
phase = phase ./ (4 * pi);
sigma = sigma_rayleigh(wavelength, pressure, temperature, C, rh);
dSig = sigma .* phase;

end