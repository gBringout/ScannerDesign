% Build an ideal FFL scanner
clear all

%% Commun parameter to each fields

maxOrder = 2; % maximal order for the spherical harmonics serie
maxDegree = 2; % maximal order for the spherical harmonics serie
rhoReference = 0.5;% [m] Fields are descrive inside a sphere of 1 meter of diameter

%sometime, we cannot use zero, for examples when we want to display in a
%log scale
amplitude_zero = 10^-18;

gradientOnTheLine = 4;
driveAmplitude = 0.005;

coefGradient = (gradientOnTheLine/2)*rhoReference;
coefDrive_X = driveAmplitude;
coefDrive_Y = driveAmplitude;

%% Quadrupole 0
disp('Defines the quadrupole 0')
Quadru_0.bc(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_0.bc(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_0.bc(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_0.bs(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_0.bs(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_0.bs(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;

Quadru_0.bc(1).coefficient(2,2) = coefGradient;
Quadru_0.bs(2).coefficient(2,2) = -coefGradient;

Quadru_0.current = 1;
Quadru_0.rhoReference = 1;

%% Q45
disp('Defines the quadrupole 45')
Quadru_45.bc(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_45.bc(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_45.bc(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_45.bs(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_45.bs(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Quadru_45.bs(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;

Quadru_45.bs(1).coefficient(2,2) = coefGradient;
Quadru_45.bc(2).coefficient(2,2) = coefGradient;

Quadru_45.current = 1;
Quadru_45.rhoReference = 1;
%% Delection
disp('Define the Selection coil')
Selection_Z.bc(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Selection_Z.bc(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Selection_Z.bc(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Selection_Z.bs(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Selection_Z.bs(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Selection_Z.bs(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;

Selection_Z.bc(1).coefficient(2,2) = coefGradient;
Selection_Z.bs(2).coefficient(2,2) = coefGradient;
Selection_Z.bc(3).coefficient(2,1) = 2*coefGradient;

Selection_Z.current = 1;
Selection_Z.rhoReference = 1;
%% Drive X
disp('Define the Drive X')
Drive_X.bc(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_X.bc(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_X.bc(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_X.bs(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_X.bs(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_X.bs(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;

%we set the current higher, in order to get a relatively small sensitivity
Drive_X.current = 100;
Drive_X.bc(1).coefficient(1,1) = coefDrive_X/Drive_X.current;

Drive_X.rhoReference = 1;
%% Drive Y
disp('Define the Drive Y')
Drive_Y.bc(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_Y.bc(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_Y.bc(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_Y.bs(1).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_Y.bs(2).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;
Drive_Y.bs(3).coefficient = ones(maxOrder,maxDegree)*amplitude_zero;

%we set the current higher, in order to get a relatively small sensitivity
Drive_Y.current = 100;
Drive_Y.bc(2).coefficient(1,1) = coefDrive_Y/Drive_Y.current;

Drive_Y.rhoReference = 1;

clear('maxOrder','maxDegree','rhoReference',...
    'amplitude_zero','gradientOnTheLine','driveAmplitude',...
    'coefGradient','coefDrive_X','coefDrive_Y')

save('examples\FieldsIdealFFL.mat')