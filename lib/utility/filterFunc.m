function res = filterFunc(wavelength, wavelength0, fwhm)
    res = exp(- ( wavelength - wavelength0).^2 ./ (2 * (fwhm / 2.354820045031).^2));
end