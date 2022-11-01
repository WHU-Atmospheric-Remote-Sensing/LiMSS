function [fh] = plot_fullspectrum(temperature, varargin)
% PLOT_FULLSPECTRUM plot full rotational Raman spectrum of a given molecule.
%
% USAGE:
%    [fh] = plot_fullspectrum(temperature)
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


p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'temperature', @isnumeric);
addParameter(p, 'wavelength', 532.0, @isnumeric);
addParameter(p, 'fwhm', 0.55, @isnumeric);

parse(p, temperature, varargin{:});

%% Parameter Definition
constants = lidar_mol_toolbox_constants();
J_stokes = 0:39;
J_antistokes = 2:39;

%% Calculus
% N2
wavenumber = 1e7 / p.Results.wavelength;
dn_stokes_N2 = [];
for iJ = 1:length(J_stokes)
    dn_stokes_N2 = cat(2, dn_stokes_N2, raman_shift_stokes(J_stokes(iJ), constants.N2_parameters));
end
dn_antistokes_N2 = [];
for iJ = 1:length(J_antistokes)
    dn_antistokes_N2 = cat(2, dn_antistokes_N2, raman_shift_antistokes(J_antistokes(iJ), constants.N2_parameters));
end

dl_stokes_N2 = 1 ./ (1 ./ p.Results.wavelength + dn_stokes_N2 * 1e-7);
dl_antistokes_N2 = 1 ./ (1 ./ p.Results.wavelength + dn_antistokes_N2 * 1e-7);

ds_stokes_N2 = [];
for iJ = 1:length(J_stokes)
    ds_stokes_N2 = cat(2, ds_stokes_N2, cross_section_stokes(wavenumber, J_stokes(iJ), temperature, constants.N2_parameters));
end
ds_antistokes_N2 = [];
for iJ = 1:length(J_antistokes)
    ds_antistokes_N2 = cat(2, ds_antistokes_N2, cross_section_stokes(wavenumber, J_antistokes(iJ), temperature, constants.N2_parameters));
end

% O2
wavenumber = 1e7 / p.Results.wavelength;
dn_stokes_O2 = [];
for iJ = 1:length(J_stokes)
    dn_stokes_O2 = cat(2, dn_stokes_O2, raman_shift_stokes(J_stokes(iJ), constants.O2_parameters));
end
dn_antistokes_O2 = [];
for iJ = 1:length(J_antistokes)
    dn_antistokes_O2 = cat(2, dn_antistokes_O2, raman_shift_antistokes(J_antistokes(iJ), constants.O2_parameters));
end

dl_stokes_O2 = 1 ./ (1 ./ p.Results.wavelength + dn_stokes_O2 * 1e-7);
dl_antistokes_O2 = 1 ./ (1 ./ p.Results.wavelength + dn_antistokes_O2 * 1e-7);

ds_stokes_O2 = [];
for iJ = 1:length(J_stokes)
    ds_stokes_O2 = cat(2, ds_stokes_O2, cross_section_stokes(wavenumber, J_stokes(iJ), temperature, constants.O2_parameters));
end
ds_antistokes_O2 = [];
for iJ = 1:length(J_antistokes)
    ds_antistokes_O2 = cat(2, ds_antistokes_O2, cross_section_stokes(wavenumber, J_antistokes(iJ), temperature, constants.O2_parameters));
end

%% Data Visualization
fh = figure('Position', [0, 10, 600, 300], 'Units', 'Pixels', 'Color', 'w');

yyaxis left;
barWidth = 0.5;

% N2
p1 = bar(dl_stokes_N2, ds_stokes_N2, 'DisplayName', 'Spec. N2'); hold on;
p1.FaceColor = [117, 181, 183] / 255;
p1.EdgeColor = [117, 181, 183] / 255;
p1.BarWidth = barWidth;
p2 = bar(dl_antistokes_N2, ds_antistokes_N2);
p2.FaceColor = [117, 181, 183] / 255;
p2.EdgeColor = [117, 181, 183] / 255;
p2.BarWidth = barWidth;
p3 = bar(dl_stokes_N2, ds_stokes_N2 .* filterFunc(dl_stokes_N2, p.Results.wavelength, p.Results.fwhm), 'DisplayName', 'Filtered Spec. N2');
p3.FaceColor = [0, 121, 106] / 255;
p3.EdgeColor = [0, 121, 106] / 255;
p3.BarWidth = barWidth;
p4 = bar(dl_antistokes_N2, ds_antistokes_N2 .* filterFunc(dl_antistokes_N2, p.Results.wavelength, p.Results.fwhm));
p4.FaceColor = [0, 121, 106] / 255;
p4.EdgeColor = [0, 121, 106] / 255;
p4.BarWidth = barWidth;

% O2
p5 = bar(dl_stokes_O2, ds_stokes_O2, 'DisplayName', 'Spec. O2'); hold on;
p5.FaceColor = [173, 162, 205] / 255;
p5.EdgeColor = [173, 162, 205] / 255;
p5.BarWidth = barWidth;
p6 = bar(dl_antistokes_O2, ds_antistokes_O2);
p6.FaceColor = [173, 162, 205] / 255;
p6.EdgeColor = [173, 162, 205] / 255;
p6.BarWidth = barWidth;
p7 = bar(dl_stokes_O2, ds_stokes_O2 .* filterFunc(dl_stokes_O2, p.Results.wavelength, p.Results.fwhm), 'DisplayName', 'Filtered Spec. O2');
p7.FaceColor = [234, 75, 18] / 255;
p7.EdgeColor = [234, 75, 18] / 255;
p7.BarWidth = barWidth;
p8 = bar(dl_antistokes_O2, ds_antistokes_O2 .* filterFunc(dl_antistokes_O2, p.Results.wavelength, p.Results.fwhm));
p8.FaceColor = [234, 75, 18] / 255;
p8.EdgeColor = [234, 75, 18] / 255;
p8.BarWidth = barWidth;

ax = gca;
ax.YColor = 'k';
ax.YLabel.Interpreter = 'latex';
ax.YLabel.String = '$\left(\frac{d\sigma}{d\omega}\right)_{\pi}$ $[cm^{2}sr^{-1}]$';
ax.XLabel.String = 'Wavelength (nm)';
ax.Title.String = sprintf('Full rotational Raman spectrum at %5.1f K', temperature);
set(ax, 'FontSize', 12);

yyaxis right;
wlArr = linspace(min([dl_antistokes_N2, dl_stokes_N2]), max([dl_antistokes_N2, dl_stokes_N2]), 1e5);
p9 = plot(wlArr, filterFunc(wlArr, p.Results.wavelength, p.Results.fwhm), '--r', 'DisplayName', sprintf('Filter FWHM %4.1f nm', p.Results.fwhm)); hold on;

ax = gca;
ax.YColor = 'k';
ax.YLabel.String = 'Filter efficiency';
set(ax, 'FontSize', 12);

l1 = legend([p1, p3, p5, p7, p9], 'Location', 'NorthEast');
set(l1, 'FontSize', 8);

end