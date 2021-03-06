clear all;
close all;
%% import data para coger los datos
[temp_pulse,pow,lambda,T,L] = input_pulse;
%% Parametros
c0 = 3e8;
%lambda_c = 1550*10^-9;
%f=0:1/(t(2)-t(1)):(length(t)-1)*1/(t(2)-t(1))
lambda_c = lambda(round(length(lambda)/2))*10^-9;
f = c0./(lambda*10^-9);
t = linspace(0e-13,5e-13,length(f))'; %tiempo
%t = 1./f;
fc = c0/lambda_c;
%k = 2*pi*f; %n� onda
%L = linspace(1,100,length(lambda));
Ptol = 27; %dBm
att = 10^(-6/10)*10^-3; %atenuaci�n fibra �ptica
%% Caracterizaci�n Pulso Gaussiano
%for Lfib = 2:8/length(lambda):10
Lfib = 2;
t_pulso = 50e-15;
pow_peak = 2e5;
amp = sqrt(pow_peak); %amplitud mW
t0 = t(round(length(t)/2));
a = amp*exp(-(((t - t0)./(2*t_pulso)).^2)); %pulso gaussiano
figure(2);
plot(t,a);
%% Caracterizaci�n Dispersi�n Pulso
tau = Lfib/c0; %delay
D = 16; %ps/nm-1*km-1
Dslope = (1/1e5)*D; %dispersion
cte = ((lambda_c)^2/(2*pi*c0));
beta2 = -cte*D; %GDD
beta3 = cte^2*Dslope; %TOD
phi_w_disp = tau*2*pi.*(f-fc)+ (1/2)*beta2*Lfib.*(2*pi*(f-fc)).^2+(1/6)*beta3*beta3*Lfib.*(2*pi*(f-fc)).^3; %phase with dispersion terms
%phase_lin = exp(1i*(2*pi*f.*t.*beta_lin));
phase = exp(1i*phi_w_disp); %dispersion
%% Forma Temporal + Potencia
fpulse=fft(a);%.*exp(1i*aaa*f)
figure(3);
plot(f,a);
temp_puls_prueba = 1/(2*pi)*ifft(fpulse.*phase);
temp_puls_prueba_dbm = 10*log(temp_puls_prueba);
figure(4)
plot(t,abs(temp_puls_prueba_dbm));
pause(0.01);
Peak = max(abs(temp_puls_prueba_dbm))
Att = Peak - Ptol
%% Efectos No-lineales Fibra �ptica

%end
%Ppeak_prueba = max(temp_puls_prueba);