close all;
clear all;
%% Parametros
%SIEMPRE con números
dbstop if error
lc = 1550.0; %frecuencia central -nm
BW = 200.0; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB
GPIBaddress = 1234; %dirección GPIB
timeout = 30;
g_ins = 4;
c_lbd = 1550;
lbd_start = 1300;
lbd_stop = 1800;
vector_res = [1.0,0.5,0.2,0.1,0.07]; %resolution vector
data_vec = cell(1,length(vector_res));
%% Creacion de la conexión
specA = tcpip(address, GPIBaddress);%opcional especificar 'NetworkRole', 'server, crea TCP/IP
specA.Timeout = timeout; %timeout de conexión
specA.Terminator = 'CR/LF'; %especifica terminador (LF, CR, etc.)
%% Apertura de conexión GPIB-TCP
fopen(specA); %abre la conexión
Cg = {'++addr',num2str(g_ins)};
gpib = strjoin(Cg,{' '});
fprintf(specA,gpib); %especifica de dirección GPIB en espectrómetro
fprintf(specA,'++ver'); %especifica la versión del GPIB
a=fscanf(specA); %lee el comando guardado en la memoria del espectrómetro
for i = 1:length(a)
    b(i)=char(a(i)); %muestra en pantalla los datos guardados
end
disp(b);

%% Medidas
%% Controlar la resolución para obtener nº de puntos
for i = 1:length(vector_res)
Cr = {'RES',num2str(vector_res(i))};
resol = strjoin(Cr,{' '});
fprintf(specA,resol);
fprintf(specA, 'RES?');
disp(fscanf(specA));
%% Realización de la medida
fprintf(specA, 'SSI'); %Indica un barrido
fprintf(specA, 'AUT'); %efectua una medida del espectro "Automeasure"
meas = fscanf(specA);
disp(meas);
%% Establecer la frecuencia central
Cc = {'CNT',num2str(c_lbd)};
central = strjoin(Cc,{' '});
fprintf(specA,central);
fprintf(specA,'CNT?'); %escribe comando - asignar la frecuencia central
disp(fscanf(specA)); 
fprintf(specA, 'LOG?');
disp(fscanf(specA))
%% Spectrum obtention
%% Definir márgen de la medida del pulso
Cm = {'WSS',num2str(lbd_start),num2str(lbd_stop)};
margin = strjoin(Cm,{' ',','});
fprintf(specA,margin);
fprintf(specA,'WSS?');
disp(fscanf(specA));
%% Obtener datos de la memoria
fprintf(specA, 'DQA?');
data = fscanf(specA);
data_vec{i}= data;
end

%% crear vector lambda para cada medida!!!
%guardar en un .mat los datos
%% Cierre de conexión
save('specOpt.mat','address','b','BW','specA','data_vec');
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexión
%% cada vez que ejecuto, cerrar conexión en consola para evitar cuelgue!!!!!
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%% Funciones


