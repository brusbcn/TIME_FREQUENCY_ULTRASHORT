clear all;
close all;
%% Spectrum & Phase modification - Pulse  Shaping
%% Pulse obtention from OSA
%% Input pulse
[temp_pulse,lambda,T,L] = input_pulse;
fwhm = fwhm(temp_pulse);
%% Parameters
c0 = 3e8;
lc = 1550e-9; %central lambda(nm)
B_opt = max(lambda) - min(lambda); %Pulse Bandwidth
tau = L/c0; %delay
D = -17*10^-6; %ps/nm-1*km-1
Dslope = (1/1e5)*D; %dispersion
beta1 = tau.*L; %componente lineal dispersion Taylor
beta_lin = 10^16;
NA = 0.102; %fiber numerical aperture
V = 6.3*lc; %fiber core diameter
%% Fiber Modelling -Spatial and Temporaal profile
w0_fib = (V*lambda)/pi*NA; %fiber beam raidus
phi_disp = k*L.*(tau + (1/2)*D + (1/6).*k*Dslope); %phase with dispersion terms
phase_disp = exp(1i.*phi_disp);
s_fib = exp(-x.^2/((w0_fib)^2)); %spatial profile fiber
%% Spatial Mask Modeling

%% Spatial filter application - amplitude manipulation
%% Temporal phase - phase manipulation
