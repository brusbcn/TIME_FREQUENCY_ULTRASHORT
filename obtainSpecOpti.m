close all;
clear all;
%% Parametros
dbstop if error
lc = 1550.0; %frecuencia central -nm
BW = 200.0; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB
GPIBaddress = 1234; %dirección GPIB
timeout = 30;
g_ins = 4;
%% Creacion y apertura de conexión
specA = tcpip(address, GPIBaddress);%opcional especificar 'NetworkRole', 'server, crea TCP/IP
specA.Timeout = timeout; %timeout de conexión
specA.Terminator = 'CR/LF'; %especifica terminador (LF, CR, etc.)
%Apertura de conexión GPIB-TCP
fopen(specA); %abre la conexión
fprintf(specA, '++addr 4'); %especifica de dirección GPIB en espectrómetro
fprintf(specA,'++ver'); %especifica la versión del GPIB
a=fscanf(specA); %lee el comando guardado en la memoria del espectrómetro
%printf(specA, '++eos 3'); %evita tener que transmitir bits de control en transmisión/recepción
for i = 1:length(a)
    b(i)=char(a(i)); %muestra en pantalla los datos guardados
end
disp(b);

%% Medidas
%% Asignar span + frecuencia central
fprintf(specA, 'SSI');
fprintf(specA, 'AUT'); %efectua una medida del espectro "Automeasure"
meas = fscanf(specA);
disp(meas);
fprintf(specA,'CNT 1550.0');
fprintf(specA,'CNT?'); %escribe comando - asignar la frecuencia central
disp(fscanf(specA)); 
%fprintf(specA, 'LOG?');
%disp(fscanf(specA))
%% Spectrum obtention
fprintf(specA,'WSS 1450.0,1650.0');
fprintf(specA,'WSS?');
disp(fscanf(specA));
fprintf(specA,'MKA 1500.0');
%fprintf(specA,'MKA?');
fprintf(specA,'PWRR?');
pow=fscanf(specA);
disp(pow);
%guardar en un .mat los datos
%% Graphic Display
%plot(lambda,spect);

%% Cierre de conexión
save('specOpt.mat','address','b','BW','specA');
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexión

%% cada vez que ejecuto, cerrar conexión en consola para evitar cuelgue!!!!!
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%% Funciones


