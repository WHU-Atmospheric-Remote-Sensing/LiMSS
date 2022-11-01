function [f] = enhancement_factor_f(pressure, temperature)
% ENHANCEMENT_FACTOR_F Enhancement factor.
%
% USAGE:
%    [f] = enhancement_factor_f(pressure, temperature)
%
% INPUTS:
%    pressure: float
%        Atmospheric pressure [hPa]
%    temperature: float
%        Atmospehric temperature [K]   
%
% OUTPUTS:
%    f: numeric
%
% EXAMPLE:
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

T = temperature;
P = pressure * 100.;   % In Pa

f = 1.00062 + 3.14e-8 * P + 5.6e-7 * (T - 273.15) .^ 2;

end