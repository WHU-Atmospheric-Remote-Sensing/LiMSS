clc;

%% Parameter Definition
temperature = 200:2:300;
wavelength = 1064;
wavelength0 = 1064.0;
FWHM = [0.6];

%% Calculation
mdr = NaN(length(temperature), length(FWHM));
for iT = 1:length(temperature)
    for iF = 1:length(FWHM)
        mdr(iT, iF) = delta_mol_temperature(temperature(iT), wavelength, 'wavelength0', wavelength0, 'FWHM', FWHM(iF), 'ignore_range', true);
    end
end

%% Data Visualization
figure('Position', [0, 30, 500, 300], 'Units', 'Pixels', 'Color', 'w');

lineInstances = cell(0);

for iF = 1:length(FWHM)
    lIns = plot(temperature, mdr(:, iF), 'Marker', 'o', 'MarkerSize', 5, 'DisplayName', sprintf('FWHM: %4.1f nm', FWHM(iF))); hold on;
    lineInstances = cat(2, lineInstances, lIns);
end

xlabel('Temperature (K)');
ylabel('Mol. Dep. Ratio');
title(sprintf('Molecular Depolarization Ratio (%6.1f nm)', wavelength));

ylim([0, 0.01]);

set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'FontSize', 11, 'Layer', 'bottom');

l = legend(lineInstances, 'Location', 'northeast');
set(l, 'FontSize', 11);

export_fig(gcf, 'mol_depol_1064_reference_lidar.pdf');