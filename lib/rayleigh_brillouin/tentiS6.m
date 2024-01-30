function [specs] = tentiS6(x, y)
% TENTIS6 analytical model of Tenti S6 model.
%
% USAGE:
%    [specs] = tentiS6(x, y)
%
% INPUTS:
%    x: numeric
%        normalized optical frequency shift.
%    y: numeric
%        normalized collision frequency.
%
% OUTPUTS:
%    specs: numeric
%        normalized intensity at x. 
%
% REFERENCES:
%    B. Witschas, "Analytical model for Rayleigh¨CBrillouin line shapes in air: errata," Appl. Opt. 50, 5758-5758 (2011)
%
% HISTORY:
%    2023-12-02: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

A = 0.18526 * exp(-1.31255 * y) + 0.07103 * exp(-18.26117 * y) + 0.74421;

sigmaR = 0.70813 - 0.16366 * y^2 + 0.19132 * y^3 - 0.07217 * y^4;
sigmaB = 0.07845 * exp(-4.88663 * y) + 0.804 * exp(-0.15003 * y) - 0.45142;
xB = 0.80893 - 0.30208 * 0.10898 ^ y;

specs = A / (sqrt(2 * pi) * sigmaR) * exp(-0.5 * (x / sigmaR).^2) + (1 - A) / (2 * sqrt(2 * pi) * sigmaB) * exp(-0.5 * ((x + xB) / sigmaB).^2) + (1 - A) / (2 * sqrt(2 * pi) * sigmaB) * exp(-0.5 * ((x - xB) / sigmaB).^2);

end