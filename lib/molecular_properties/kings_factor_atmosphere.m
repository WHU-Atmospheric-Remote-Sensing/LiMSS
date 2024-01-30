function [Fk] = kings_factor_atmosphere(wavelength, C, p_e, p_t)
% KINGS_FACTOR_ATMOSPHERE Calculate the King's factor for the atmosphere.
%
% USAGE:
%    [Fk] = kings_factor_atmosphere(wavelength, C, p_e, p_t)
%
% INPUTS:
%    wavelength: numeric
%        wavelength. (nm)
%    C: numeric
%        CO2 concentration in ppmv.
%    p_e: numeric
%        water-vapor pressure in hPa.
%    p_t: numeric
%        total air pressure in hPa.
%
% OUTPUTS:
%    Fk: numeric
%        total atmospheric King's factor.
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'wavelength', @isnumeric);
addRequired(p, 'C', @isnumeric);
addRequired(p, 'p_e', @isnumeric);
addRequired(p, 'p_t', @isnumeric);

parse(p, wavelength, C, p_e, p_t);

if ~ any((wavelength >= 200) & (wavelength <= 4000))
    error('Kings factor formula is only valid from 0.2 to 4 um.');
end

lambda_cm = wavelength * 1e-7;
wavenumber = 1 / lambda_cm;

F_N2 = kings_factor_N2(wavenumber);
F_O2 = kings_factor_O2(wavenumber);
F_Ar = kings_factor_Ar();
F_CO2 = kings_factor_CO2();
F_H2O = kings_factor_H2O();

% relative concentration
C_N2 = 0.78084;
C_O2 = 0.20946;
C_Ar = 0.00934;
C_CO2 = 1e-6 * C;
C_H2O = p_e ./ p_t;

C_tot = C_N2 + C_O2 + C_Ar + C_CO2 + C_H2O;

Fk = (C_N2 * F_N2 + C_O2 * F_O2 + C_Ar * F_Ar + C_CO2 * F_CO2 + C_H2O * F_H2O) ./ C_tot;

end