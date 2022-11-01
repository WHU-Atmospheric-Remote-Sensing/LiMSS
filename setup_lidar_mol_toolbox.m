global LIDAR_MOL_TOOLBOX;

LIDAR_MOL_TOOLBOX.author = 'Zhenping Yin';
LIDAR_MOL_TOOLBOX.email = 'zp.yin@whu.edu.cn';
LIDAR_MOL_TOOLBOX.affiliation = 'Wuhan University';
LIDAR_MOL_TOOLBOX.projectDir = fileparts(mfilename('fullpath'));
LIDAR_MOL_TOOLBOX.toolbox_name = 'lidar molecular toolbox';
LIDAR_MOL_TOOLBOX.version = '1.0';
LIDAR_MOL_TOOLBOX.description = 'Lidar molecular toolbox is dedicated for molecular optical properties calculation for lidar application. The toolbox was interpreted from Python package [https://bitbucket.org/iannis_b/] developed by Iannis Binietoglou.';

addpath(genpath(fullfile(LIDAR_MOL_TOOLBOX.projectDir, 'lib')));
addpath(genpath(fullfile(LIDAR_MOL_TOOLBOX.projectDir, 'tests')));