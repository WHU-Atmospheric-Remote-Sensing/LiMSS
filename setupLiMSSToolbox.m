global LIMSS_ENVS;

LIMSS_ENVS.Author = 'Zhenping Yin';
LIMSS_ENVS.Email = 'zp.yin@whu.edu.cn';
LIMSS_ENVS.Affiliation = 'Wuhan University';
LIMSS_ENVS.RootDir = fileparts(mfilename('fullpath'));
LIMSS_ENVS.Toolbox_name = 'lidar molecular toolbox';
LIMSS_ENVS.Version = '0.0.1';
LIMSS_ENVS.UpdateTime = '2024-01-30';
LIMSS_ENVS.Description = 'Lidar molecular toolbox is dedicated for molecular optical properties calculation for lidar application. The toolbox was interpreted from Python package [https://bitbucket.org/iannis_b/] developed by Iannis Binietoglou.';

addpath(genpath(fullfile(LIMSS_ENVS.RootDir, 'lib')));
addpath(genpath(fullfile(LIMSS_ENVS.RootDir, 'tests')));
addpath(genpath(fullfile(LIMSS_ENVS.RootDir, 'include')));
addpath(genpath(fullfile(LIMSS_ENVS.RootDir, 'data')));