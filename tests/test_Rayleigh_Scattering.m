% Test Rayleigh Scattering Calculation
% Author: Zhenping
% Date: 2024-01-27

clc;
global LIMSS_ENVS;

%% Parameter Definition
wavelengths = [355, 532, 1064];   % (nm)
rsFile = 'radiosonde_57494_20170102_0000.nc';

%% Read Data
altitude = ncread(rsFile, 'altitude');
temperature = ncread(rsFile, 'temperature');
pressure = ncread(rsFile, 'pressure');
const = loadConstants();

%% Rayleight Scattering
mBscs = NaN(length(wavelengths), length(altitude));
mExts = NaN(length(wavelengths), length(altitude));
for iWL = 1:length(wavelengths)
    mBscs(iWL, :) = beta_pi_rayleigh(wavelengths(iWL), pressure, temperature - const.T0, 380, 40);
    mExts(iWL, :) = alpha_rayleigh(wavelengths(iWL), pressure, temperature - const.T0, 38, 40);
end

%% Display
figure('Position', [0, 30, 600, 400], 'Units', 'Pixels', 'Color', 'w');

% scattering
subplot(121);
hold on;
lineInstances = [];
for iLine = 1:length(wavelengths)
    thisInstance = plot(mBscs(iLine, :), altitude, 'LineWidth', 2, 'DisplayName', sprintf('%5.1f nm', wavelengths(iLine)));
    lineInstances = cat(2, lineInstances, thisInstance);
end
hold off;

xlabel('Backscatter (m-1sr-1)');
ylabel('Altitude (m)');

ylim([0, 15000]);

set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'Box', 'on', 'XScale', 'log', 'FontSize', 11);
legend(lineInstances, 'Location', 'NorthEast');

% extinction
subplot(122);
hold on;
lineInstances = [];
for iLine = 1:length(wavelengths)
    thisInstance = plot(mExts(iLine, :), altitude, 'LineWidth', 2, 'DisplayName', sprintf('%5.1f nm', wavelengths(iLine)));
    lineInstances = cat(2, lineInstances, thisInstance);
end
hold off;

xlabel('Extinction (m-1)');
ylabel('Altitude (m)');
text(-1.2, 1.06, 'Rayleigh Scattering at different wavelength', 'Units', 'Normalized', 'FontSize', 12, 'FontWeight', 'Bold');

ylim([0, 15000]);

set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'Box', 'on', 'XScale', 'log', 'FontSize', 11);

export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'Rayleigh_Scattering.png'), '-r300');