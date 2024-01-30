function [outVal] = getDeltaV(molParam, branch, vibNum, rotNum)
% GETDELTAV Calculate the Raman frequency shifts delta_v
%
% USAGE:
%    [outVal] = getDeltaV(molParam, branch, vibNum, rotNum)
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
%
% OUTPUTS:
%    outVal: numeric
%        The delta of wavenumber. Unit: cm^(-1)
%
% HISTORY:
%    2024-01-28: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

switch branch
case 'S'
    if (vibNum == 0)
        % Rotational Raman Spectra
        outVal = -(4 * rotNum - 2) * molParam.B0 + molParam.D0 * (3 * (2 * rotNum - 1) + (2 * rotNum - 1).^3);
    else
        outVal = molParam.vib * abs(vibNum) + (4 * rotNum + 6) * molParam.B1;
    end
case 'AS'
    if (vibNum == 0)
        outVal = (4 * rotNum + 6) * molParam.B0 - molParam.D0 * (3 * (2 * rotNum + 3) + (2 * rotNum + 3).^3);
    else
        error('AS for pure rotational Raman spectra only!');
    end
case 'Q'
    if (vibNum == 0)
        error('No Q branch for rotational Raman spectra.');
    else
        % stokes vibrational Raman spectra
        outVal = molParam.vib * abs(vibNum) + rotNum .* (rotNum + 1) * (molParam.B1 - molParam.B0);
    end
case 'O'
    if (vibNum == 0)
        error('No O branch for pure rotational Raman spectra.');
    else
        outVal = molParam.vib * abs(vibNum) - (4 * rotNum - 2) * molParam.B0;
    end
otherwise
    error('Wrong input of branch: %s', branch);
end

end