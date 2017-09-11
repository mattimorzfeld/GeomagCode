clear all
close all
clc
colors

%% Load the data
load myPADM2M.mat
s2 = sigma_dip;
v2 = sigma_dip.^2;
v2(end) = v2(end-1);

%% Assimilation
dt = 1;
Steps = 2000;
t = (dt:Steps)*dt*1e-3-2;
%% Model parameters
load BruceB.mat


avg_D = Assim_PADM2M_EnKF_func(50);
%% Plot results
myerrorCloud(dipole,2*sigma_dip,epoch,Color(:,6),Color(:,2))
hold on, plot(t(1:end-2)+1e-3,avg_D(3:end),'-','Color',Color(:,3),'LineWidth',2);
set(gcf,'Color','w')
xlabel('Time in Myr'),ylabel('Signed relative paleointensity')
axis([-1.25 -0.85 -1.5 1.5])


