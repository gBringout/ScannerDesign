% Build an ideal FFL scanner
clear all

%% Commun parameter to each fields

maxOrder = 1; % maximal order for the spherical harmonics serie
maxDegree = 1; % maximal order for the spherical harmonics serie
rhoReference = 0.10;% [m] Fields are described inside a sphere of 1 meter of diameter

%sometime, we cannot use zero, for examples when we want to display in a
%log scale
amplitude_zero = 0;

gradientOnTheLine = 4;
drivePeakAmplitude = 0.015;

coefGradient = (gradientOnTheLine/2)*rhoReference;
coefDrive_X = drivePeakAmplitude;
coefDrive_Y = drivePeakAmplitude;

%% Quadrupole 0
disp('Defines the quadrupole 0')
Quadru_0.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_0.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_0.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_0.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_0.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_0.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

Quadru_0.bc(1).coefficient(2,2) = coefGradient;
Quadru_0.bs(2).coefficient(2,2) = -coefGradient;

Quadru_0.current = 1;
Quadru_0.rhoReference = rhoReference;

%% Q45
disp('Defines the quadrupole 45')
Quadru_45.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_45.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_45.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_45.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_45.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Quadru_45.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

Quadru_45.bs(1).coefficient(2,2) = coefGradient;
Quadru_45.bc(2).coefficient(2,2) = coefGradient;

Quadru_45.current = 1;
Quadru_45.rhoReference = rhoReference;
%% Selection
disp('Define the Selection coil')
Selection_Z.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

Selection_Z.bc(1).coefficient(2,2) = -coefGradient;
Selection_Z.bs(2).coefficient(2,2) = -coefGradient;
Selection_Z.bc(3).coefficient(2,1) = -2*coefGradient;

Selection_Z.current = 1;
Selection_Z.rhoReference = rhoReference;
%% Drive X
disp('Define the Drive X')
Drive_X.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_X.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_X.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_X.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_X.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_X.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

%we set the current higher, in order to get a relatively small sensitivity
Drive_X.current = 293.29;
Drive_X.bc(1).coefficient(1,1) = coefDrive_X/Drive_X.current;

Drive_X.rhoReference = rhoReference;
%% Drive Y
disp('Define the Drive Y')
Drive_Y.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Y.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Y.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Y.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Y.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Y.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

%we set the current higher, in order to get a relatively small sensitivity
Drive_Y.current = 379.71;
Drive_Y.bc(2).coefficient(1,1) = coefDrive_Y/Drive_Y.current;

Drive_Y.rhoReference = rhoReference;

%%
clear('maxOrder+1','maxDegree+1','rhoReference',...
    'amplitude_zero','gradientOnTheLine','drivePeakAmplitude',...
    'coefGradient','coefDrive_X','coefDrive_Y')

save(fullfile('examples','IdealFFL.mat'))
