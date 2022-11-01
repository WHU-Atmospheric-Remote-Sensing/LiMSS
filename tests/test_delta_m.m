clc;

%% Parameter Definition
temperature = 200:2:300;
wavelegnth = 532;
wavelength0 = 532.0;
FWHM = [0.1, 0.2, 0.5, 1, 2, 3, 5, 10];

%% Calculation
mdr = NaN(length(temperature), length(FWHM));
for iT = 1:length(temperature)
    for iF = 1:length(FWHM)
        mdr(iT, iF) = delta_mol_temperature(temperature(iT), wavelegnth, 'wavelength0', wavelength0, 'FWHM', FWHM(iF));
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

set(gca, 'XMinorTick', 'on', 'YMinorTick', 'on', 'FontSize', 11, 'Layer', 'bottom');

l = legend(lineInstances, 'Location', 'northeast');
set(l, 'FontSize', 10);