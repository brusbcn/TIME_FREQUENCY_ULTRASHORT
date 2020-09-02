clc;
clear all;
%% Parametros
c0 = 3e8;
%% Leer archivo de texto
%% import data para coger los datos
spec = importdata('measure.txt');
pow = spec(:,2);
lambda=spec(:,1);
%f = c0/1550e-9;
f = c0./lambda;
T = 1./f;
figure(1);
plot(lambda,pow);
%% Fibra 
L = linspace(1,100,length(f));
%L = linspace(1,100,length(f));
tau = L/c0;
D = -17*10^-6; %ps/nm-1*km-1
Dslope = (1/1e5)*D;
beta1 = tau.*L;
k = 2*pi*f;
beta_lin = 10^-16;
phase = exp(1i*2*pi*f*beta_lin);
%phi_disp = k*L.*(tau + (1/2)*D + (1/6).*k*Dslope); %phase with dispersion terms
%phase_disp = exp(1i.*phi_disp);
%% Temporal waveform
temporal_shape = (1/(2*pi))*ifft(pow.*phase);
t_shape = fftshift(temporal_shape);
t_shape_dB = 10.*log10(t_shape)+30; %power dBm
temp_pulse = abs(t_shape);
figure(2);
plot(T,temp_pulse);
xlabel('wavelength(m)');
ylabel('Power(dBm)');
%% Suponemos waveshaper (cambia amplitud y fase del espectro) + t�cnicas nuevas (espacio fases, cracterizacion FROG, MIIPS, SPIDER, etc.)
%% C�lculo FWHM
% Find the half max value.
halfMax = (1/2)*(min(temp_pulse) + max(temp_pulse));
% Find where the data first drops below half the max.
index1 = find(temp_pulse>=halfMax,1,'first');
% Find where the data last rises above half the max.
index2 = find(temp_pulse>=halfMax,1,'last');
FWHM = index2 - index1 + 1; % FWHM in indexes.