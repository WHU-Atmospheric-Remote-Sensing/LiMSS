% Test water vapor Raman Scattering Calculation
% Author: Zhenping
% Date: 2024-01-30

clc;
close all;
global LIMSS_ENVS;

%% Parameter Definitions
inWL = 355e-9;   % wavelength of incident light. (m)
temperature = 300;   % ambient temperature. (K)

%% Calculation
[wvRamanLines, outWL] = getWVRamanLines(inWL, temperature);

%% Display

% in wavenumber
figure('Position', [0, 30, 500, 320], 'Units', 'Pixels', 'Color', 'w');

hold on;
stem(1e-2 ./ inWL - 1e-2 ./ outWL, wvRamanLines * 1e4, 'filled', 'MarkerSize', 1);
hold off;

xlim([2800, 4300]);

xlabel('Wavenumber (cm-1)');
ylabel('Cross Section (cm^2 mole^{-1} sr^{-1})');
title(sprintf('Raman spectra of water vapor at %dK', temperature));

set(gca, 'YScale', 'log', 'box', 'on', 'XMinorTick', 'on', 'FontSize', 11, 'ticklen', [0.02, 0.02], 'layer', 'top');

export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'wv_Raman_spectra_wavenumber.png'), '-r300');

% in wavelength
figure('Position', [0, 30, 500, 320], 'Units', 'Pixels', 'Color', 'w');

hold on;
stem(outWL * 1e9, wvRamanLines * 1e4, 'filled', 'MarkerSize', 1);
hold off;

xlim([395, 420]);

xlabel('Wavelength (nm)');
ylabel('Cross Section (cm^2 mole^{-1} sr^{-1})');
title(sprintf('Raman spectra of water vapor at %dK', temperature));

set(gca, 'YScale', 'log', 'box', 'on', 'XMinorTick', 'on', 'FontSize', 11, 'ticklen', [0.02, 0.02], 'layer', 'top');

export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'wv_Raman_spectra_wavelength.png'), '-r300');