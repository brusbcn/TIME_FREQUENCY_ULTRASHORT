clear all;
close all;
%% Spectrum & Phase modification - Pulse  Shaping
%% Pulse obtention from OSA
% Se tiene que añadir función!!!
%% Input pulse from mode-locked laser
[temp_pulse,specrum,lambda,T,L] = input_pulse;
fwhm = ((max(T)-min(T))/length(T))*fwhm(temp_pulse);
%% Parameters
%% General
c0 = 3e8;
lc = 1550e-9; %central lambda(nm)
f0 = c0/lc; %operation frequency
f = c0./lambda; %vector frecuencias
B_opt = max(lambda) - min(lambda); %Pulse Bandwidth
foc = 0.213; %focus (m)
foc_p = foc; %backprop focus (m)
%% Time-Bandwidth Product

%% Fibra - wave shaper
NA = 0.102; %fiber numerical aperture - estimation
V = 6.3*lc; %fiber core diameter - estimation
%% Spatial light Modulator LCoS
delta_x = 14e-6; %LCoS space between pixels
Nx = 1024;% number of pixels - x
Ny = 768; % number of pixels - y 
delta_phi = 0; %cambio de fase
%% 1st Hypotesis - Pulse as a delta
delt = dirac(T);
figure(3);% set Inf to finite value
stem(T,delt)
delt_f = fft(delt);
figure(4);
plot(f,delt_f);


%% Modelling
%% Fiber Modelling -Spatial and Temporal profile
w0_fib = (V*lambda)/pi*NA; %fiber beam raidus
phi_disp = k*L.*(tau + (1/2)*D + (1/6).*k*Dslope); %phase with dispersion terms
phase_disp = exp(1i.*phi_disp);
s_fib = exp(-x.^2/((w0_fib)^2)); %spatial profile fiber
%% Wave-Shaper Modeling
%alpha = lc^2*foc/(2*pi*c0*d*cos(theta_d));
%tau = 0;
%w_0 = (foc*w0_fib*beta_a)/foc_p;
%% Spatial filter application - amplitude manipulation
%% Temporal phase - phase manipulation
