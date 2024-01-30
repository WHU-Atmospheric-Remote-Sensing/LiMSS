% Written by John Smith
% October 21st, 2010
% University of Colorado at Boulder, CIRES
% John.A.Smith@Colorado.EDU
% MATLAB version 7.10.0.59 (R2010a) 64-bit
% Adapted from "Coherent Rayleigh-Brillouin Scattering"
% by Xingguo Pan
% Sets and computes all relevant parameters
% for s6 and s7 models given in Xingguo Pan's
% dissertation entitled "Coherent Rayleigh-
% Brillouin Scattering", 2003, Princeton Univ.
% 
% downloaded from www.mathworks.com/matlabcentral/fileexchange/
% adapted/modified for backscatter in air by Scott Spuler Nov 2021 

function [sptsig6] = tentiS7(tem, p_pa, lambda, wlSca)
% TENTIS7 Rayleigh-Brillouin spectra based on tentiS6 model
%
% USAGE:
%    [Norm_RD] = tentiS7(temp, p_pa, lambda, wlSca)
%
% INPUTS:
%    tem: numeric
%        ambient temperature. (K)
%    p_pa: numeric
%        ambient pressure. (pa)
%    lambda: numeric
%        laser wavelength. (nm)
%    wlSca: numeric
%        wavelength of scattering light. (nm)
%
% OUTPUTS:
%    Norm_RD: numeric
%        normalized RBS.
%
% EXAMPLE:
%
% HISTORY:
%    2023-12-23: first edition by Zhenping
% .. Authors: - zp.yin@whu.edu.cn

% calculate the RD only spectrum
const.k_B = 1.380649e-23; % (J/K, or Pa m^3/K)
const.c = 299792458; % (m/s) (exact)  
const.N_A = 6.022E23; % (/mol) Avagadros number
const.M = 28.97E-3; % (kg/mol) air molecular mass per mol 
const.m = const.M./const.N_A; % (kg) mass of a air molecule

% set laser parameters
angle=(180)*(pi/180);  % Set at 180 for backscatter

% The Matlab File Exchange version had an error.  The k term needed to use angle/2 
k=sin(angle/2)*4*pi/lambda;
% compute most probable gas velocity
v0=sqrt(2*const.k_B*tem/const.m);

% create the domain of xi
xi = 2 * pi * (const.c ./ wlSca - const.c ./ lambda) ./ (sqrt(2) * k * v0);
% xi_lef=-5.0d0;
% xi_rgt=5.0d0;
% xi=linspace(xi_lef,xi_rgt,N);
% *** 
% 'xi' is dimensionless and should be scaled by k*v0/(2*pi) [Hz],
% where 'v0' is the most probable gas velocity, or sqrt(2*kb*T/m),
% and 'k' is 4*pi/lambda*sin(scatter_angle/2)
% ***

% Modified to update mass, viscosity, bulk viscosity, and thermal conductivity for air 
% set N2 gas quantities
%m_m=(1.66053886e-27)*28.013;
%viscosity=17.63e-6; 
   T_0 = 273; % K
   eta_0 = 1.716e-5; %Pa s
   S_eta = 111; %K
   viscosity= eta_0*(tem/T_0)^(3/2)*(T_0+S_eta)/(tem+S_eta); % Sutherland law
%bulk_vis=viscosity*0.73; 
    %  bulk_vis=viscosity*0.71; % used by Luke Colberg/MSU
     bulk_vis=0.86e-5+(1.29e-7*(tem-250)); % Wang et al. Molecular Physics 2021
%thermal_cond=25.2e-3;
     kappa_0 = 0.0241; % 1W/m K
     S_th = 194; %K
     thermal_cond=kappa_0*(tem/T_0)^(3/2)*(T_0+S_th)/(tem+S_th); % Sutherland law
c_int=1.0;
% convert pressures and densities
n0=p_pa/(tem*const.k_B);
% compute and set RBS model input parameters
c_tr=3/2;
y=n0*const.k_B*tem/(k*v0*viscosity);
gamma_int=c_int/(c_tr+c_int);
rlx_int=1.5*bulk_vis/(viscosity*gamma_int);
eukenf=const.m*thermal_cond/(viscosity*const.k_B*(c_tr+c_int));
% run the code
%[cohsig7,sptsig7]=crbs7(y,rlx_int,eukenf,c_int,c_tr,xi);
[cohsig6,sptsig6]=crbs6(y,rlx_int,eukenf,c_int,c_tr,xi);
% OUTPUTS-
% **cohsig7: coherent RBS spectrum using s7 model**
% **cohsig6: coherent RBS spectrum using s6 model**
% **sptsig7: spontaneous RBS spectrum using s7 model**
% **sptsig6: spontaneous RBS spectrum using s6 model**

end