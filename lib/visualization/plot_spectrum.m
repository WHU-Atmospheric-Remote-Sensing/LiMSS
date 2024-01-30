function [fh] = plot_spectrum(temperature, varargin)
% PLOT_SPECTRUM plot rotational Raman spectrum of a given molecule.
%
% USAGE:
%    [fh] = plot_spectrum(temperature)
%
% INPUTS:
%    temperature: numeric
%        ambient temperature. (K)
%
% KEYWORDS:
%    molecular_parameters: struct
%        struct containing molecular parameters.
%    wavelength: numeric
%        incident wavelength. (nm)
%    fwhm: numeric
%        FWHM of the optical filter. (nm)
%
% OUTPUTS:
%    fh: figure handle
%        figure handle of the plot.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

constants = loadConstants();

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'temperature', @isnumeric);
addParameter(p, 'molecular_parameters', constants.N2_parameters, @isstruct);
addParameter(p, 'wavelength', 532.0, @isnumeric);
addParameter(p, 'fwhm', 0.55, @isnumeric);

parse(p, temperature, varargin{:});

%% Parameter Definition
J_stokes = 0:39;
J_antistokes = 2:39;

%% Calculus
wavenumber = 1e7 / p.Results.wavelength;
dn_stokes = [];
for iJ = 1:length(J_stokes)
    dn_stokes = cat(2, dn_stokes, raman_shift_stokes(J_stokes(iJ), p.Results.molecular_parameters));
end
dn_antistokes = [];
for iJ = 1:length(J_antistokes)
    dn_antistokes = cat(2, dn_antistokes, raman_shift_antistokes(J_antistokes(iJ), p.Results.molecular_parameters));
end

dl_stokes = 1 ./ (1 ./ p.Results.wavelength + dn_stokes * 1e-7);
dl_antistokes = 1 ./ (1 ./ p.Results.wavelength + dn_antistokes * 1e-7);

ds_stokes = [];
for iJ = 1:length(J_stokes)
    ds_stokes = cat(2, ds_stokes, cross_section_stokes(wavenumber, J_stokes(iJ), temperature, p.Results.molecular_parameters));
end
ds_antistokes = [];
for iJ = 1:length(J_antistokes)
    ds_antistokes = cat(2, ds_antistokes, cross_section_stokes(wavenumber, J_antistokes(iJ), temperature, p.Results.molecular_parameters));
end

%% Data Visualization
fh = figure('Position', [0, 10, 600, 300], 'Units', 'Pixels', 'Color', 'w');

yyaxis left;
barWidth = 0.5;
p1 = bar(dl_stokes, ds_stokes, 'DisplayName', 'Full Spec.'); hold on;
p1.FaceColor = [117, 181, 183] / 255;
p1.EdgeColor = [117, 181, 183] / 255;
p1.BarWidth = barWidth;
p2 = bar(dl_antistokes, ds_antistokes);
p2.FaceColor = [117, 181, 183] / 255;
p2.EdgeColor = [117, 181, 183] / 255;
p2.BarWidth = barWidth;
p3 = bar(dl_stokes, ds_stokes .* filterFunc(dl_stokes, p.Results.wavelength, p.Results.fwhm), 'DisplayName', 'Filtered Spec.');
p3.FaceColor = [0, 121, 106] / 255;
p3.EdgeColor = [0, 121, 106] / 255;
p3.BarWidth = barWidth;
p4 = bar(dl_antistokes, ds_antistokes .* filterFunc(dl_antistokes, p.Results.wavelength, p.Results.fwhm));
p4.FaceColor = [0, 121, 106] / 255;
p4.EdgeColor = [0, 121, 106] / 255;
p4.BarWidth = barWidth;

ax = gca;
ax.YColor = 'k';
ax.YLabel.Interpreter = 'latex';
ax.YLabel.String = '$\left(\frac{d\sigma}{d\omega}\right)_{\pi}$ $[cm^{2}sr^{-1}]$';
ax.XLabel.String = 'Wavelength (nm)';
ax.Title.String = sprintf('Rotational Raman spectrum of %s at %5.1f K', p.Results.molecular_parameters.name, temperature);
set(ax, 'FontSize', 12);

yyaxis right;
wlArr = linspace(min([dl_antistokes, dl_stokes]), max([dl_antistokes, dl_stokes]), 1e5);
p5 = plot(wlArr, filterFunc(wlArr, p.Results.wavelength, p.Results.fwhm), '--r', 'DisplayName', sprintf('Filter FWHM %4.1f nm', p.Results.fwhm)); hold on;

ax = gca;
ax.YColor = 'k';
ax.YLabel.String = 'Filter efficiency';
set(ax, 'FontSize', 12);

l1 = legend([p1, p3, p5], 'Location', 'NorthEast');
set(l1, 'FontSize', 8);

end