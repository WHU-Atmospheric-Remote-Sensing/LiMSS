function [E] = saturation_vapor_pressure(temperature)
% SATURATION_VAPOR_PRESSURE Saturation vapor pressure of water of moist air.
%
% USAGE:
%    [E] = saturation_vapor_pressure(temperature)
%
% INPUTS:
%    temperature: float
%        Atmospheric temperature [K] 
%
% OUTPUTS:
%    E: float
%        Saturation vapor pressure [hPa]
%
% REFERENCES:
%    [1] Ciddor, P. E.: Refractive index of air: new equations for the visible and near 
%        infrared, Appl. Opt., 35(9), 1566-1573, doi:10.1364/AO.35.001566, 1996.
%     
%    [2] Davis, R. S.: Equation for the Determination of the Density of 
%        Moist Air (1981/91), Metrologia, 29(1), 67, doi:10.1088/0026-1394/29/1/008, 1992.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

T = temperature;
E = exp(1.2378847e-5 * T .^ 2 - 1.9121316e-2 * T + 33.93711047 - 6343.1645 ./ T) / 100.;

end