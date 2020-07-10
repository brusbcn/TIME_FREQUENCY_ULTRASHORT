close all;
clear all;
%% Parametros
dbstop if error
lc = 1580; %frecuencia central -nm
BW = 200; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB
GPIBaddress = 1234; %direcci�n GPIB
timeout = 30;
g_ins = 4;
%% Creacion y apertura de conexi�n
specA = tcpip(address, GPIBaddress);%opcional especificar 'NetworkRole', 'server, crea TCP/IP
specA.Timeout = timeout; %timeout de conexi�n
specA.Terminator = 'CR/LF'; %especifica terminador (LF, CR, etc.)
%Apertura de conexi�n GPIB-TCP
b= OpenGPIB(specA,g_ins);
disp(b);

%% Medidas
%% Asignar span + frecuencia central
fprintf(specA, 'AUT?'); %efectua una medida del espectro "Automeasure"
fprintf(specA,'CNT?'); %escribe comando - asignar la frecuencia central
l = fscanf(specA); 
disp(l)
fprintf(specA, 'LOG?');
disp(fscanf(specA));

%% Spectrum obtention
%for i = 0:BW-1
% spectrum(i+1) = ObtainPower(specA,i+(lc-BW/2));
%end
lambda = 1480;
fprintf(specA, 'PWR lambda');
fprintf(specA, 'PWR?');
fprintf(specA,'PWRR?');
power = fscanf(specA);
%guardar en un .mat los datos
%% Graphic Display
plot(lambda,spect);

%% Cierre de conexi�n
save('specOpt.mat','a','address','b','BW','l','meas','pwr','specA');
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexi�n

%% cada vez que ejecuto, cerrar conexi�n en consola para evitar cuelgue!!!!!
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%% Funciones

function b = OpenGPIB(specA,gpibad)
fopen(specA); %abre la conexi�n
ad = gpibad;
fprintf(specA, '++addr ad'); %especifica de direcci�n GPIB en espectr�metro
fprintf(specA,'++ver'); %especifica la versi�n del GPIB
a=fscanf(specA); %lee el comando guardado en la memoria del espectr�metro
%printf(specA, '++eos 3'); %evita tener que transmitir bits de control en transmisi�n/recepci�n
for i = 1:length(a)
    b(i)=char(a(i)); %muestra en pantalla los datos guardados
end
end
function power = ObtainPower(specA,lambda)
fprintf(specA, 'PWR lambda');
fprintf(specA, 'PWR?');
fprintf(specA,'PWRR?');
power = fscanf(specA);
end