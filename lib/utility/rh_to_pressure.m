function [p_wv] = rh_to_pressure(rh, temperature)
% RH_TO_PRESSURE Convert relative humidity to water vapour partial pressure.  
%
% USAGE:
%    [p_wv] = rh_to_pressure(rh, temperature)
%
% INPUTS:
%    rh: float
%        Relative humidity from 0 to 100 [%]
%    temperature: float
%        Temperature [K]
%
% OUTPUTS:
%    p_wv: float
%        Water vapour pressure [hPa].
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

svp = saturation_vapor_pressure(temperature);
h = rh ./ 100.;

p_wv = h .* svp;   % Previously / 100. This seems to be a bug (SVP already in hPA)/

end