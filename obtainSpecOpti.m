close all;
clear all;
%% Parametros
dbstop if error
lc = 1550.0; %frecuencia central -nm
BW = 200.0; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB
GPIBaddress = 1234; %direcci�n GPIB
timeout = 30;
g_ins = 4;
c_lbd = 1550.0;
lbd_start = 1300.0;
lbd_stop = 1800.0;
%% Creacion y apertura de conexi�n
specA = tcpip(address, GPIBaddress);%opcional especificar 'NetworkRole', 'server, crea TCP/IP
specA.Timeout = timeout; %timeout de conexi�n
specA.Terminator = 'CR/LF'; %especifica terminador (LF, CR, etc.)
%Apertura de conexi�n GPIB-TCP
fopen(specA); %abre la conexi�n
g = num2str(g_ins);
fprintf(specA, '++addr 4'); %especifica de direcci�n GPIB en espectr�metro
fprintf(specA,'++ver'); %especifica la versi�n del GPIB
a=fscanf(specA); %lee el comando guardado en la memoria del espectr�metro
%printf(specA, '++eos 3'); %evita tener que transmitir bits de control en transmisi�n/recepci�n
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
fprintf(specA, 'LOG?');
disp(fscanf(specA))
%% Spectrum obtention
fprintf(specA,'WSS 1300.0,1800.0');
fprintf(specA,'WSS?');
disp(fscanf(specA));
%Controlar la resoluci�n para obtener n� de puntos
fprintf(specA, 'RES 1');
fprintf(specA, 'RES 1');
fprintf(specA, 'RES?');
disp(fscanf(specA));
% Obtener datos de la memoria
fprintf(specA, 'DQA?');
data = fscanf(specA);
%guardar en un .mat los datos
%% Graphic Display
%plot(lambda,spect);
%% Cierre de conexi�n
save('specOpt.mat','address','b','BW','specA');
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexi�n

%% cada vez que ejecuto, cerrar conexi�n en consola para evitar cuelgue!!!!!
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%% Funciones


