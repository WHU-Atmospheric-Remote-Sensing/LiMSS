function [Xw] = molar_fraction_water_vapor(pressure, temperature, relative_humidity)
% MOLAR_FRACTION_WATER_VAPOR description
%
% USAGE:
%    [Xw] = molar_fraction_water_vapor(pressure, temperature, relative_humidity)
%
% INPUTS:
%    pressure: float
%        Total pressure [hPa]
%    temperature: float
%        Atmospehric temperature [K] 
%    relative_humidity:
%        Relative humidity from 0 to 100 [%]
%
% OUTPUTS:
%    Xw: numeric
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

% Convert units
P = pressure;   % In hPa
h = relative_humidity / 100.;   % From 0 to 1

% Calculate water vapor pressure
f = enhancement_factor_f(pressure, temperature);
svp = saturation_vapor_pressure(temperature);

p_wv = h .* f .* svp;   % Water vapor pressure

Xw = p_wv ./ P;

end