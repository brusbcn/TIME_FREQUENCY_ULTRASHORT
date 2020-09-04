clc;
clear all;
%% import data para coger los datos
spec = importdata('measure.txt');
pow = spec(:,2);
lambda=spec(:,1);
figure(1);
plot(lambda,pow);
%% Parametros
c0 = 3e8;
f = c0./lambda;
T = 1./f; %periodo
k = 2*pi*f; %nº onda
L = linspace(1,100,length(f));
tau = L/c0; %delay
D = -17*10^-6; %ps/nm-1*km-1
Dslope = (1/1e5)*D; %dispersion
beta1 = tau.*L; %componente lineal dispersion Taylor
beta_lin = 10^-16;
%% Fibra - fase
phase = exp(1i*2*pi*f*beta_lin);
%phi_disp = k*L.*(tau + (1/2)*D + (1/6).*k*Dslope); %phase with dispersion terms
%phase_disp = exp(1i.*phi_disp);
%% Temporal waveform
temporal_shape = (1/(2*pi))*ifft(pow);
t_shape = fftshift(temporal_shape);
t_shape_dB = 10.*log10(t_shape)+30; %power dBm
temp_pulse = abs(t_shape);
figure(2);
plot(T,temp_pulse);
fwhm = fwhm(temp_pulse);
xlabel('wavelength(m)');
ylabel('Power(dBm)');