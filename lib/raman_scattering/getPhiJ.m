function [outVal] = getPhiJ(molParam, branch, vibNum, rotNum, temperature)
% GETPHIJ Calculate the Phi_J for the Raman Spectrum.
%
% USAGE:
%    [outVal] = getPhiJ(molParam, branch, vibNum, rotNum, temperature)
%
% INPUTS:
%    molParam: struct
%        struct containing molecular parameters.
%    branch: char
%        branch of Raman spectra:
%            'O': vibrational Raman (VR) O branch
%            'S': VR S branch or pure rotational Raman (PRR) stokes branch
%            'Q': VR Q branch
%            'AS': PRR anti-stokes branch
%    vibNum: numeric
%        vibrational levels. (+1 anti-stokes VRR; 0 RR; -1 stokes VRR)
%    rotNum: numeric
%        rotational levels.
%    temperature: numeric
%        ambient temperature. (K)
%
% OUTPUTS:
%    outVal: numeric
%        The delta of wavenumber. (m^6)
%
% HISTORY:
%    2024-01-29: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

const = loadConstants();
bv2 = const.h / (8 * pi^2 * const.c * molParam.vib * 100);

switch branch
case 'S'
    if (vibNum == 0)
        % Rotational Raman Spectra
        outVal = 7 * (rotNum - 1) .* rotNum ./ (30 * (2 .* rotNum + 3)) * molParam.AOPS;
    elseif (vibNum < 0)
        % stokes vibrational Raman spectra
        outVal = bv2 ./ (1 - exp(-const.h * const.c * molParam.vib * 100 / (const.k_b * temperature))) * (7 * (rotNum + 2) .* (rotNum + 1) ./ (30 * (2 * rotNum + 3)) * molParam.IAOPS);
    else
        % anti-stokes vibrational Raman spectra
        outVal = bv2 ./ (exp(const.h * const.c * molParam.vib * 100 / (const.k_b * temperature)) - 1) * (7 * (rotNum + 2) .* (rotNum + 1) ./ (30 * (2 * rotNum + 3)) * molParam.IAOPS);
    end
case 'AS'
    if (vibNum == 0)
        outVal = 7 * (rotNum + 1) .* (rotNum + 2) ./ (30 * (2 * rotNum + 3)) * molParam.AOPS;
    else
        error('AS for pure rotational Raman spectra only!');
    end
case 'Q'
    if (vibNum == 0)
        error('No Q branch for pure rotational Raman spectra.');
    elseif (vibNum < 0)
        % stokes vibrational Raman spectra
        outVal = bv2 * (2 * rotNum + 1) / (1 - exp(-const.h * const.c * molParam.vib * 100 / (const.k_b * temperature))) * (molParam.IMPS + 7 * rotNum .* (rotNum + 1) / (45 * (2 * rotNum + 3) .* (2 * rotNum - 1)) * molParam.IAOPS);
    else
        % anti-stokes vibrational Raman spectra
        outVal = bv2 * (2 * rotNum + 1) / (exp(const.h * const.c * molParam.vib * 100 / (const.k_b * temperature)) - 1) * (molParam.IMPS + 7 * rotNum .* (rotNum + 1) / (45 * (2 * rotNum + 3) .* (2 * rotNum - 1)) * molParam.IAOPS);
    end
case 'O'
    if (vibNum == 0)
        error('No O branch for pure rotational Raman spectra.');
    elseif (vibNum < 0)
        % stokes vibrational Raman spectra
        outVal = bv2 ./ (1 - exp(-const.h * const.c * molParam.vib * 100 / (const.k_b * temperature))) * (7 * rotNum .* (rotNum - 1) ./ (30 * (2 * rotNum - 1)) * molParam.IAOPS);
    else
        % anti-stokes vibrational Raman spectra
        outVal = bv2 ./ (exp(const.h * const.c * molParam.vib * 100 / (const.k_b * temperature)) - 1) * (7 * rotNum .* (rotNum - 1) ./ (30 * (2 * rotNum - 1)) * molParam.IAOPS);
    end
otherwise
    error('Wrong input of branch: %s', branch);
end

end