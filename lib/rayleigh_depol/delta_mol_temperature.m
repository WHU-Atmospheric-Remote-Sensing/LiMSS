function [delta_m, x_N2, x_O2] = delta_mol_temperature(temperature, wavelength, varargin)
% DELTA_MOL_TEMPERATURE Calculate molecular depolarization ratio at a given temperature.
%
% USAGE:
%    [delta_m, x_N2, x_O2] = delta_mol_temperature(temperature, wavelegnth)
%
% INPUTS:
%    temperature: numeric
%        Ambient temperature. (K)
%    wavelength: numeric
%        incident wavelength. (nm)
%
% KEYWORDS:
%    wavelength0: numeric
%        central wavelength of the optical filter. (nm)
%    fwhm: numeric
%        FWHM of the optical filter. (nm)
%
% OUTPUTS:
%    delta_m: numeric
%        molecular depolarization ratio.
%    x_N2: numeric
%         Component fraction of N2.
%    x_O2: numeric
%        Component fraction of O2.
%
% HISTORY:
%    2022-11-01: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

p = inputParser;
p.KeepUnmatched = true;

addRequired(p, 'temperature', @isnumeric);
addRequired(p, 'wavelength', @isnumeric);
addParameter(p, 'wavelength0', 532, @isnumeric);
addParameter(p, 'fwhm', 0.55, @isnumeric);

parse(p, temperature, wavelength, varargin{:});

%% Parameter Definition
constants = lidar_mol_toolbox_constants();
J_stokes = 0:39;
J_antistokes = 2:39;

%% Calculation
wavenumber = 1e7 / wavelength;

% N2
dn_stokes_N2 = [];
for iJ = 1:length(J_stokes)
    dn_stokes_N2 = cat(2, dn_stokes_N2, raman_shift_stokes(J_stokes(iJ), constants.N2_parameters));
end
dn_antistokes_N2 = [];
for iJ = 1:length(J_antistokes)
    dn_antistokes_N2 = cat(2, dn_antistokes_N2, raman_shift_antistokes(J_antistokes(iJ), constants.N2_parameters));
end

dl_stokes_N2 = 1 ./ (1 ./ p.Results.wavelength + dn_stokes_N2 * 1e-7);
dl_antistokes_N2 = 1 ./ (1 ./ p.Results.wavelength + dn_antistokes_N2 * 1e-7);

ds_stokes_N2 = [];
for iJ = 1:length(J_stokes)
    ds_stokes_N2 = cat(2, ds_stokes_N2, cross_section_stokes(wavenumber, J_stokes(iJ), temperature, constants.N2_parameters));
end
ds_antistokes_N2 = [];
for iJ = 1:length(J_antistokes)
    ds_antistokes_N2 = cat(2, ds_antistokes_N2, cross_section_stokes(wavenumber, J_antistokes(iJ), temperature, constants.N2_parameters));
end

x_N2 = (sum(filterFunc(dl_stokes_N2, p.Results.wavelength0, p.Results.fwhm) .* ds_stokes_N2) + sum(filterFunc(dl_antistokes_N2, p.Results.wavelength0, p.Results.fwhm .* ds_antistokes_N2))) / (sum(ds_stokes_N2) + sum(ds_antistokes_N2));

% O2
dn_stokes_O2 = [];
for iJ = 1:length(J_stokes)
    dn_stokes_O2 = cat(2, dn_stokes_O2, raman_shift_stokes(J_stokes(iJ), constants.O2_parameters));
end
dn_antistokes_O2 = [];
for iJ = 1:length(J_antistokes)
    dn_antistokes_O2 = cat(2, dn_antistokes_O2, raman_shift_antistokes(J_antistokes(iJ), constants.O2_parameters));
end

dl_stokes_O2 = 1 ./ (1 ./ p.Results.wavelength + dn_stokes_O2 * 1e-7);
dl_antistokes_O2 = 1 ./ (1 ./ p.Results.wavelength + dn_antistokes_O2 * 1e-7);

ds_stokes_O2 = [];
for iJ = 1:length(J_stokes)
    ds_stokes_O2 = cat(2, ds_stokes_O2, cross_section_stokes(wavenumber, J_stokes(iJ), temperature, constants.O2_parameters));
end
ds_antistokes_O2 = [];
for iJ = 1:length(J_antistokes)
    ds_antistokes_O2 = cat(2, ds_antistokes_O2, cross_section_stokes(wavenumber, J_antistokes(iJ), temperature, constants.O2_parameters));
end

x_O2 = (sum(filterFunc(dl_stokes_O2, p.Results.wavelength0, p.Results.fwhm) .* ds_stokes_O2) + sum(filterFunc(dl_antistokes_O2, p.Results.wavelength0, p.Results.fwhm .* ds_antistokes_O2))) / (sum(ds_stokes_O2) + sum(ds_antistokes_O2));

% Depolarization ratio
delta_m = delta_mol(wavenumber, {constants.N2_parameters, constants.O2_parameters}, [x_N2, x_O2]);

end