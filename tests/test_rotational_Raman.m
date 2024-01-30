% Test Rotational Raman Scattering Calculation
% Author: Zhenping
% Date: 2024-01-27

clc;
close all;
global LIMSS_ENVS;

%% Parameter Definition
T = 300;   % temperature. (K)
lambda = 355;   % central wavelength of laser. (nm)
fwhm = 0.2;   % FWHM of the optical filter. (nm)

%% Iannis's approach
% plot_fullspectrum(T, 'wavelength', lambda, 'fwhm', fwhm, 'figFile', fullfile(LIMSS_ENVS.RootDir, 'image', 'Rotational_Raman_Spectra.png'));

%% Zhenping's approach
getDiMolRamanLines(lambda, T, 'showFigure', true, 'molecular', 'N2', 'branch', 'RR');
export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'rotational-Raman-spectra.png'), '-r300');