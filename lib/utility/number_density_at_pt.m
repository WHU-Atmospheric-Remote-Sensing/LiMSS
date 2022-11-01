function [n] = number_density_at_pt(pressure, temperature, relative_humidity, ideal)
% NUMBER_DENSITY_AT_PT Calculate the number density for a given temperature and pressure,
% taking into account the compressibility of air.
%
% USAGE:
%    [n] = number_density_at_pt(pressure, temperature, relative_humidity, ideal)
%
% INPUTS:
%    pressure: float or array
%        Pressure in hPa
%    temperature: float or array
%        Temperature in K
%    relative_humidity: float or array (?)
%        Relative humidity of air (Check)
%    ideal: boolean
%        If False, the compressibility of air is considered. If True, the 
%        compressibility is set to 1.
%
% OUTPUTS:
%    n: numeric
%        Number density of the atmosphere [m^{-3}]  
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

Xw = molar_fraction_water_vapor(pressure, temperature, relative_humidity);
    
if ideal
    Z = 1;
else   
    Z = compressibility_of_moist_air(pressure, temperature, Xw);
end

p_pa = pressure * 100.;   % Pressure in pascal
const = lidar_mol_toolbox_constants();
n = p_pa ./ (Z * temperature * const.k_b);

end

    
