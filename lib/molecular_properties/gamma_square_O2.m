function [gSq] = gamma_square_O2(wavenumber, varargin)
% GAMMA_SQUARE_O2 Return the gamma squared parameter for O2 for a given wavelength.
%
% USAGE:
%    [gSq] = gamma_square_O2(wavenumber)
%
% INPUTS:
%    wavenumber: numeric
%        wavenumber in cm-1.
%
% KEYWORDS:
%    ignore_range: logical
%        If set to True, it will ignore the valid range of the formulat (200 nm - 1000 nm)
%
% OUTPUTS:
%    gSq: numeric
%        gamma squared in cm^6
%
% HISTORY:
%    2022-10-31: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'wavenumber', @isnumeric);
addParameter(p, 'ignore_range', false, @islogical);

parse(p, wavenumber, varargin{:});

if ~ p.Results.ignore_range
    if any((wavenumber > 50000) | (wavenumber < 1000))
        error('The empirical formula for gamma-squared is valid only between 200 nm and 1000 nm');
    end
end

wavenumber_um = wavenumber * 1e-4;

g = 0.07149 + 45.9364 ./ (48.2716 - wavenumber_um.^2);

g = g * 1e-24;

gSq = g.^2;

end