% calculate Rayleigh-Brillouin spectrum
% find more details in 
% B. Witschas, "Analytical model for Rayleigh¨CBrillouin line shapes in air: errata," Appl. Opt. 50, 5758-5758 (2011)
% Author: Zhenping Yin
% Date: 2024-01-27

% set fundamental constants
const = loadConstants();
viscosity = 1.846e-5;   % shear viscosity. (Pa m-1 s-1)
m_air = 4.789e-26;   % molecular mass. (kg)
angle = (180)*(pi/180);

% laser
laserFWHM = 1e8;   % FWHM of laser spectrum. (Hz)
lambda = 532.2453e-9;   % central wavelength of laser. (m)

% air
T = 300;   % temperature. (K)
p = 1.01325e5;   % pressure. (Pa)
n_air = p ./ (T * const.k_b);  % number density. (m-3)

k = sin(angle/2) * 4 * pi / lambda;
v0 = sqrt(2 * const.k_b * T / m_air);

deltaFreq = (-1000:1000) * 1e7;

sigmaLaser = laserFWHM / 2.35;
lv = @(v) (1 ./ (sqrt(2 * pi) * sigmaLaser) * exp(-0.5 * (v - 0).^2 / sigmaLaser^2));

% Tenti-S6 model (analytical form)
freq0 = const.c / (lambda);
x = 2 * pi * deltaFreq ./ (k * v0);
y = n_air * const.k_b * T ./ (sqrt(2) * k * v0 * viscosity);
specs = tentiS6(x, y);

lambdaBsc = const.c ./ (x * (sqrt(2) * k * v0) / (2 * pi) + const.c / lambda);

%% Display

% in frequency
figure('Position', [0, 0, 500, 300], 'Units', 'Pixels', 'Color', 'w');

hold on;
p1 = plot(deltaFreq * 1e-9, lv(deltaFreq) / max(lv(deltaFreq)), 'Linewidth', 2, 'DisplayName', 'laser spectrum');
p2 = plot(deltaFreq * 1e-9, specs, 'Linewidth', 2, 'DisplayName', 'Rayleigh-Brillouin');
hold off;

grid on;

xlim([-4, 4]);
ylim([0, 1]);

xlabel('Frequency Offset (GHz)');
ylabel('Power');
title(sprintf('Rayleigh-Brillouin spectrum @%6.1fnm T=%5.1fK', lambda * 1e9, T));

set(gca, 'XMinorTick', 'on', 'XTick', -5:5, 'box', 'on', 'Fontsize', 12, 'TickLen', [0.02, 0.02]);

legend([p1, p2], 'Location', 'NorthEast');

export_fig(gcf, fullfile(LIMSS_ENVS.RootDir, 'image', 'Rayleigh_Brillouin_spectra.png'), '-r300');

% in wavelength
% figure('Position', [0, 0, 500, 300], 'Units', 'Pixels', 'Color', 'w');
% 
% hold on;
% p1 = plot(lambdaBsc * 1e9, lv(deltaFreq) / max(lv(deltaFreq)), 'Linewidth', 2, 'DisplayName', 'laser spectrum');
% p2 = plot(lambdaBsc * 1e9, specs, 'Linewidth', 2, 'DisplayName', 'Rayleigh-Brillouin');
% hold off;
% 
% xlim([532.243, 532.25]);
% ylim([0, 1]);
% 
% xlabel('wavelength (nm)');
% ylabel('Power');
% title('Rayleigh-Brillouin spectrum');
% 
% set(gca, 'XMinortick', 'on', 'box', 'on', 'Fontsize', 12);
% 
% legend([p1, p2], 'Location', 'NorthEast');