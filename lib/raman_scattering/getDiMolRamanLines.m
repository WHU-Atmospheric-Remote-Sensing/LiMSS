function [outSigma, outWL] = getDiMolRamanLines(inWL, T, varargin)
% GETDIMOLRAMANLINES calculate the Raman spectra of O2 or N2.
%
% USAGE:
%    [outSigma, outWL] = getDiMolRamanLines(inWL, T)
%
% INPUTS:
%    inWL: numeric
%        wavelength of incident light. (nm)
%    T: numeric
%        ambient temperature. (K)
%
% KEYWORDS:
%    rotNumArray: numeric
%        rotational number.
%    branch: char
%        branch of Raman spectra:
%            'O': vibrational Raman (VR) O branch
%            'S': VR S branch or pure rotational Raman (PRR) stokes branch
%            'Q': VR Q branch
%            'AS': PRR anti-stokes branch
%            'full': full vibrational and rotational Raman spectra
%            'VRR': stokes vibrational Raman spectra
%            'RR':rotational Raman spectra
%    molecular: char
%        'N2': nitrogen
%        'O2': oxygen
%        'full': nitrogen + oxygen
%    vibNum: numeric
%        vibrational number
%    showFigure: logical
%        whether to display the figure.
%
% OUTPUTS:
%    outSigma: numeric
%        backscatter cross section. (m2sr-1)
%    outWL: numeric
%        Raman scattering wavelength. (nm)
%
% HISTORY:
%    2024-01-29: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'inWL', @isnumeric);
addRequired(p, 'T', @isnumeric);
addParameter(p, 'rotNumArray', 0:40, @isnumeric);
addParameter(p, 'branch', 'full', @ischar);
addParameter(p, 'molecular', 'full', @ischar);
addParameter(p, 'vibNum', 0, @isnumeric);
addParameter(p, 'showFigure', false, @islogical);

parse(p, inWL, T, varargin{:});

const = loadConstants();
kv = 16 * pi^4;
inWN = 1 ./ (inWL * 1e-9);

molSpec = cell(0);
switch p.Results.molecular
case 'O2'
    molSpec = cat(2, molSpec, const.O2_parameters);
case 'N2'
    molSpec = cat(2, molSpec, const.N2_parameters);
case 'full'
    molSpec = cat(2, molSpec, const.O2_parameters);
    molSpec = cat(2, molSpec, const.N2_parameters);
otherwise
    error('Unknow molecular: %s', p.Results.branch);
end

switch p.Results.branch

case 'full'
    vibs = [-1, -1, -1, 0, 0, 1, 1, 1];
    branches = {'S', 'Q', 'O', 'S', 'AS', 'O', 'Q', 'S'};
case 'VRR'
    vibs = [-1, -1, -1];
    branches = {'S', 'Q', 'O'};
case 'RR'
    vibs = [0, 0];
    branches = {'S', 'AS'};
case {'O', 'S', 'Q', 'AS'}
    vibs = [p.Results.vibNum];
    branches = {p.Results.branch};
otherwise
    error('Unknow branch: %s', p.Results.branch);
end

outWL = NaN(1, length(molSpec) * length(p.Results.rotNumArray) * length(branches));
outSigma = NaN(1, length(molSpec) * length(p.Results.rotNumArray) * length(branches));
for iMol = 1:length(molSpec)
    molecular_parameters = molSpec{iMol};

    for iBR = 1:length(branches)
        for iRN = 1:length(p.Results.rotNumArray)
            deltaV = getDeltaV(molecular_parameters, branches{iBR}, vibs(iBR), p.Results.rotNumArray(iRN));
            g_index = mod(p.Results.rotNumArray(iRN), 2);
            g_N = molecular_parameters.g(g_index + 1);
            I = molecular_parameters.I;
            Q = const.k_b * T ./ (2 * const.h * const.c * molecular_parameters.B0 * 100);
            phiJ = getPhiJ(molecular_parameters, branches{iBR}, vibs(iBR), p.Results.rotNumArray(iRN), T);

            ind = iMol + (iBR - 1) * length(molSpec) + (iRN - 1) * length(molSpec) * length(branches);
            if vibs(iBR) > 0.1
                % anti-stokes vibration Raman spectra
                outSigma(ind) = kv * (inWN + deltaV * 100).^4 .* g_N .* phiJ ./ ((2 * I + 1).^2 .* Q) .* exp(-molecular_parameters.B1 * 100 * const.h * const.c .* p.Results.rotNumArray(iRN) .* (1 + p.Results.rotNumArray(iRN)) / (const.k_b * T));
                outWL(ind) = 1 ./ (inWN + deltaV * 100) * 1e9;
            else
                % stokes vibration Raman spectra or pure rotational Raman spectra
                outSigma(ind) = kv * (inWN - deltaV * 100).^4 .* g_N .* phiJ ./ ((2 * I + 1).^2 .* Q) .* exp(-molecular_parameters.B0 * 100 * const.h * const.c .* p.Results.rotNumArray(iRN) .* (1 + p.Results.rotNumArray(iRN)) / (const.k_b * T));
                outWL(ind) = 1 ./ (inWN - deltaV * 100) * 1e9;
            end
        end
    end
end

%% Display
if p.Results.showFigure

    figure('Position', [0, 30, 600, 350], 'Units', 'Pixels', 'Color', 'w');

    hold on;
    stem(outWL, outSigma * 1e4 * 1e33, 'filled', 'MarkerSize', 3);
    hold off;

    xlim([min(outWL), max(outWL)]);
    ylim([min(outSigma), max(outSigma)] * 1e4 * 1e33);

    xlabel('Wavelength (nm)');
    ylabel(sprintf('Backscatter Cross Section (10^{-33} cm^2sr^{-1})'));
    title(sprintf('Raman spectra of %s at %6.2fK', p.Results.molecular, T));

    set(gca, 'yscale', 'log', 'XMinorTick', 'on', 'YTick', 10.^(-8:2:3), 'YMinorTick', 'on', 'Box', 'on', 'FontSize', 11);
end

end