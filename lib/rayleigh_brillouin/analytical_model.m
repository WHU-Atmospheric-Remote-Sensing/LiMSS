function [S] = analytical_model(x, y)
% ANALYTICAL_MODEL The is an analytic approximation to the Tenti S6 model, proposed by B. Witschas.
% The fit was made assuming atmospheric air. The approximation is valid for y = 0-- 1.027. Within
% that region, the deviations are less than 0.85%.
%
% USAGE:
%    [S] = analytical_model(x, y)
%
% INPUTS:
%    x: numeric
%        Normalized optical frequency shift.
%    y: numeric
%        Normalized collision frequency.
%
% OUTPUTS:
%    S: numeric
%        Normalized integrated intensity.
%
% NOTE:
%    The model was constructed using a constant temperature T=250 K. It is not
%    valid for very different temperatures.
%
% REFERENCES:
%    [1] Witschas, B. Analytical model for Rayleigh-Brillouin line shapes in air. 
%        Appl. Opt. 50, 267-270 (2011).
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

% Calculate the empirical parameters for given y
A = 0.18526 * exp(-1.31255 * y) + 0.07103 * exp(-18.26117 * y) + 0.74421;

% The width of the Rayleigh pick
sigma_r = 0.70813 - 0.16366 * y.^2 + 0.19132 * y.^3 - 0.07217 * y.^4;

% The width of the side Brillouin picks
sigma_b = 0.07845 * exp(-4.88663 * y) + 0.804 * exp(-0.15003 * y) - 0.45142;

% The location of the side Brillouin picks
x_b = 0.80893 - 0.30208 * 0.10898.^y;

% Calculate the intensity of the three picks separately
S_r = A ./ (sqrt(2 * pi) .* sigma_r) .* exp(-0.5 * (x ./ sigma_r).^2);

S_b1 = (1 - A) ./ (2 * sqrt(2 * pi) * sigma_b) .* exp(-0.5 * ((x + x_b) ./ sigma_b).^2);

S_b2 = (1 - A) ./ (2 * sqrt(2 * pi) * sigma_b) .* exp(-0.5 * ((x - x_b) ./ sigma_b).^2);

S = S_r + S_b1 + S_b2;

end