function [temp_pulse,lambda,T,L] = input_pulse
clc;
clear all;
%% import data para coger los datos
spec = importdata('measure.txt');
pow = spec(:,2);
lambda=spec(:,1)/10;
figure(1);
plot(lambda,pow);
%% Parametros
c0 = 3e8;
f = c0./lambda;
T = 1./f; %periodo
k = 2*pi*f; %nº onda
L = linspace(1,100,length(f));
%% Temporal waveform
temporal_shape = (1/(2*pi))*ifft(pow);
t_shape = fftshift(temporal_shape);
t_shape_dB = 10.*log10(t_shape)+30; %power dBm
temp_pulse = abs(t_shape);
figure(2);
plot(T,temp_pulse);
xlabel('Duration(s)');
ylabel('Power(dBm)');
end