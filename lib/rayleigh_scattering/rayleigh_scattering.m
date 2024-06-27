function [ beta_mol, alpha_mol ] = rayleigh_scattering(wavelength, pressure, temperature, C, rh)
% RAYLEIGH_SCATTERING calculate the molecular volume backscatter coefficient and
% extinction coefficient.
%
% USAGE:
%    [output] = rayleigh_scattering(wavelength, pressure, temperature, C, rh)
%
% INPUTS:
%    wavelength: float
%        Wavelegnth [nm]
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
%    beta_mol: float
%        molecular backscatter coefficient. [m^{-1}*Sr^{-1}]
%    alpha_mol: float
%        molecular extinction coefficient. [m^{-1}]
%
% REFERENCES:
%    [1] Bucholtz, A.: Rayleigh-scattering calculations for the terrestrial atmosphere, Appl. Opt. 34, 2765-2773 (1995)
%    [2] A. Behrendt and T. Nakamura, "Calculation of the calibration constant of polarization lidar and its dependency on atmospheric temperature," Opt. Express, vol. 10, no. 16, pp. 805-817, 2002.
%    [3] python source code of Ioannis Binietoglou's [repo](https://bitbucket.org/iannis_b/lidar_molecular). 
%        Detailed information please go to [repo](https://bitbucket.org/iannis_b/lidar_molecular)
%
% HISTORY:
%    2024-06-27: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

beta_mol = beta_pi_rayleigh(wavelength, pressure, temperature, C, rh);
alpha_mol = alpha_rayleigh(wavelength, pressure, temperature, C, rh);

end