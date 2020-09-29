function [temp_pulse,pow,lambda,T,L] = input_pulse
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
%ss=size(pow)
%pow(ss(1)/2-20:ss(1)/2+20)=zeros(41,1);
temporal_shape = (1/(2*pi))*ifft(pow);
t_shape = fftshift(temporal_shape);
temp_pulse = abs(t_shape);
temp_pulse_dB = 10.*log10(temp_pulse)+30; %power dBm
figure(2);
plot(T,temp_pulse);
xlabel('Duration(s)');
ylabel('Power(W)');


end