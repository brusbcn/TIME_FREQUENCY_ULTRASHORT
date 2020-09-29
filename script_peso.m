clear all;
close all;

%% Parametros adelgazar

Edad = 31;
Altura = 1.70;
Peso = 73;
CAF = 1.27;

%% Formula
REE = 354 - 6.91*Edad + (CAF*(9.361*Peso + 726*Altura))


