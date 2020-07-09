close all;
clear all;
%% Parametros
dbstop if error
lc = 1580; %frecuencia central -nm
BW = 200; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB

%% Creacion y apertura de conexi�n
specA = tcpip(address,1234);%,'NetworkRole', 'server');%, opcional especificar 'NetworkRole', 'server, crea TCP/IP
specA.Timeout = 30; %timeout de conexi�n
specA.Terminator = 'CR/LF'; %especifica terminador (LF, CR, etc.)
%%
fopen(specA); %abre la conexi�n
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
fprintf(specA, 'AUT?'); %efectua una medida del espectro "Automeasure"
meas = fscanf(specA);
disp(meas)
fprintf(specA,'CNT?'); %escribe comando - asignar la frecuencia central
l = fscanf(specA); 
disp(l);
fprintf(specA, 'LOG?');
disp(fscanf(specA));

%% Power obtention
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%%
fprintf(specA, 'PWR 1350.5');
fprintf(specA, 'PWR?');
pwr = fscanf(specA);
disp(pwr);
fprintf(specA,'PWRR?');
disp(fscanf(specA));
%guardar en un .mat los datos
%% Graphic Display
%lambda = linspace(lc-BW/2,lc+BW/2,BW);
%plot(lambda,spect);
%% Cierre de conexi�n
save('specOpt.mat','a','address','b','BW','l','meas','pwr','specA');
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexi�nn
%% cada vez que ejecuto, cerrar conexi�n en consola para evitar cuelgue!!!!!
