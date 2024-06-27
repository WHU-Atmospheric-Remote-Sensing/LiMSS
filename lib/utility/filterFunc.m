function [res] = filterFunc(wavelength, wavelength0, fwhm)
% FILTERFUNC generate transmission function for optical filters.
%
% USAGE:
%    [res] = filterFunc(wavelength, wavelength0, fwhm)
%
% INPUTS:
%    wavelength: array
%        wavelength of incident light. (nm)
%    wavelength0: numeric
%        central wavelength of the optical filter. (nm)
%    fwhm: numeric
%        bandwidth of the optical filter. (nm)
%
% OUTPUTS:
%    res: array
%        transmission of the light at given incident wavelength.
%
% HISTORY:
%    2024-06-27: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

res = exp(- ( wavelength - wavelength0).^2 ./ (2 * (fwhm / 2.354820045031).^2));

end