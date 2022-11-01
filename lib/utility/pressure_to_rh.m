function [rh] = pressure_to_rh(partial_pressure, temperature)
% PRESSURE_TO_RH Convert water vapor partial pressure to relative humidity.
%
% USAGE:
%    [rh] = pressure_to_rh(partial_pressure, temperature)
%
% INPUTS:
%    partial_pressure: numeric
%        water vapor partial pressure. (hPa)
%    temperature: numeric
%        Temperature. (K)
%
% OUTPUTS:
%    rh: numeric
%        Relative humidity from 0 to 100. (%)
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

svp = saturation_vapor_pressure(temperature);

rh = partial_pressure ./ svp * 100;

end