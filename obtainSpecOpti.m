close all;
clear all;
%% Parametros
terminator = 'CR/LF'; 
lc = 1550.0; %frecuencia central -nm
BW = 200.0; % ancho de banda -nm
address = '172.26.0.5'; %direccion del conector GPIB
GPIBaddress = 1234; %direcci�n GPIB
timeout = 30;
g_ins = 4;
c_lbd = 1550;
lbd_start = 1300;
lbd_stop = 1800;
vector_res = [1.0,0.5,0.2,0.1,0.07]; %resolution vector
data_vec = cell(1,length(vector_res));
%% Creacion de la conexi�n
specA = createConex(address,GPIBaddress,timeout,terminator);
%% Apertura de conexi�n GPIB-TCP
OpenConex(specA,g_ins);
%% Medidas
for i = 1:length(vector_res) 
%% Controlar la resoluci�n para obtener n� de puntos
select_resolution(vector_res(i))
%% Establecer la frecuencia central y m�rgen de la medida
define_wavelength(c_lbd,lbd_start,lbd_stop);
%% Realizaci�n de la medida
fprintf(specA, 'LOG?'); %especifica escala logar�tmica
fprintf(specA, 'SSI'); %Indica un barrido
fprintf(specA, 'AUT'); %efectua una medida del espectro "Automeasure"
%% Obtener datos de la memoria
fprintf(specA, 'DQA?');
data_vec{i}= data;
end
%% crear vector lambda para cada medida!!!
%guardar en un .mat los datos
save('specOpt.mat','address','b','BW','specA','data_vec');
%% Cierre de conexi�n
fclose(specA);
ff=8; %chivato para "garantizar" cierre de conexi�n
%% cada vez que ejecuto, cerrar conexi�n en consola para evitar cuelgue!!!!!
%% Importante
%1. write CMD ARG (program)
%2. write CMD? (query)
%3. read RSP (response)
%% Funciones
function ipobj = createConex(address,GPIBaddress,timeout,terminator)
dbstop if error
ipobj = tcpip(address, GPIBaddress);%opcional especificar 'NetworkRole', 'server, crea TCP/IP
ipobj.Timeout = timeout; %timeout de conexi�n
ipobj.Terminator = terminator; %especifica terminador (LF, CR, etc.)
end
function OpenConex(specA,g_ins)
fopen(specA); %abre la conexi�n
Cg = {'++addr',num2str(g_ins)};
gpib = strjoin(Cg,{' '});
fprintf(specA,gpib); %especifica de direcci�n GPIB en espectr�metro
fprintf(specA,'++ver'); %especifica la versi�n del GPIB
a=fscanf(specA); %lee el comando guardado en la memoria del espectr�metro
for i = 1:length(a)
    b(i)=char(a(i)); %muestra en pantalla los datos guardados
end
disp(b);
end
function select_resolution(vector_res)
Cr = {'RES',num2str(vector_res)};
resol = strjoin(Cr,{' '});
fprintf(specA,resol);
fprintf(specA, 'RES?');
end
function define_wavelength(c_lbd,lbd_start,lbd_stop)
Cc = {'CNT',num2str(c_lbd)};
central = strjoin(Cc,{' '});
fprintf(specA,central);
fprintf(specA,'CNT?'); %escribe comando - asignar la frecuencia central 
Cm = {'WSS',num2str(lbd_start),num2str(lbd_stop)};
margin = strjoin(Cm,{' ',','});
fprintf(specA,margin);
fprintf(specA,'WSS?');
end