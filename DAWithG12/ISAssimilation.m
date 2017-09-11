clear all
close all
clc
colors

%% Load the data
load mysint2000.mat
var_dip = sigma_dip.^2;
var_dip(end) = var_dip(end-1);

muo =  [1;sqrt(2)*dipole(1);0];
Po = diag([.5^2;.1;.5^2]);
PoInv =Po\eye(3);

%% Assimilation
nObsAtATime =  5;
nObs = 2000-nObsAtATime;

dt  = 5e-2; % Time step
G2R  = 4e-3;
Gap = 5;

NOP = 50;
[xAll, Xn] = myIPF(NOP,muo,PoInv,nObs,nObsAtATime,Gap,dt,var_dip,dipole);
t = (0:nObs*Gap)*dt*G2R+1*dt*Gap*G2R;
 
%% Plot results
myerrorCloud(dipole,2*sigma_dip,epoch,Color(:,6),Color(:,2))
hold on, plot(t-2,xAll(2,:)/sqrt(2),'-','Color',Color(:,4),'LineWidth',2);
set(gcf,'Color','w')
xlabel('Time in myr'),ylabel('Dipole')

