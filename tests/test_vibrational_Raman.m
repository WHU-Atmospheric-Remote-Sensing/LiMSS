% Test Rotational Raman Scattering Calculation
% Author: Zhenping
% Date: 2024-01-27

clc;
close all;
global LIMSS_ENVS;

%% Parameter Definition
T = 300;   % temperature. (K)
lambda = 532.2453;   % central wavelength of laser. (nm)

%% Display
getDiMolRamanLines(lambda, T, 'showFigure', true, 'molecular', 'N2', 'branch', 'VRR');
export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'vibrational-rotational-Raman-spectra.png'), '-r300');