% Build an ideal FFP scanner
clear all

%% Commun parameter to each fields

maxOrder = 1; % maximal order for the spherical harmonics serie
maxDegree = 1; % maximal order for the spherical harmonics serie
rhoReference = 0.5;% [m] Fields are described inside a sphere of 1 meter of diameter

%sometime, we cannot use zero, for examples when we want to display in a
%log scale
amplitude_zero = 10^-18;

gradientInMainDirection = 5.5;
drivePeakAmplitude = 0.018;

coefGradient = (gradientInMainDirection)*rhoReference;
coefDrive_X = drivePeakAmplitude;
coefDrive_Y = drivePeakAmplitude;
coefDrive_Z = drivePeakAmplitude;

%% Selection
disp('Define the Selection coil')
Selection_Z.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Selection_Z.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

Selection_Z.bc(1).coefficient(2,2) = coefGradient/2;
Selection_Z.bs(2).coefficient(2,2) = coefGradient/2;
Selection_Z.bs(3).coefficient(2,1) = coefGradient;

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
Drive_X.current = 200;
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
Drive_Y.current = 250;
Drive_Y.bc(2).coefficient(1,1) = coefDrive_Y/Drive_Y.current;

Drive_Y.rhoReference = rhoReference;

%% Drive Z
disp('Define the Drive Z')
Drive_Z.bc(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Z.bc(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Z.bc(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Z.bs(1).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Z.bs(2).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;
Drive_Z.bs(3).coefficient = ones(maxOrder+1,maxDegree+1)*amplitude_zero;

%we set the current higher, in order to get a relatively small sensitivity
Drive_Z.current = 150;
Drive_Z.bc(3).coefficient(1,1) = coefDrive_Z/Drive_Z.current;

Drive_Z.rhoReference = rhoReference;

clear('maxOrder+1','maxDegree+1','rhoReference',...
    'amplitude_zero','gradientInMainDirection','drivePeakAmplitude',...
    'coefGradient','coefDrive_X','coefDrive_Y','coefDrive_Z')

save(fullfile('examples','IdealFFP.mat'))
