clc;
clear all;
%% Parametros
c = 3e8;
%% Leer archivo de texto
%% import data para coger los datos
spec = importdata('measure.txt');
pow = spec(:,2);
lambda=spec(:,1)*10^-9;
f = c./lambda;
T = 1./f;
%plot(spec(:,1),spec(:,2));
%% Temporal waveform
beta_lin = 10^-16;
phase = exp(1i*2*pi*f*beta_lin);
temporal_shape = ifft(pow.*phase);
t_shape = fftshift(temporal_shape);
plot(T,abs(t_shape));
%% Suponemos waveshaper (cambia amplitud y fase del espectro) + técnicas nuevas (espacio fases, cracterizacion FROG, MIIPS, SPIDER, etc.)