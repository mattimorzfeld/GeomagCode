clear all
close all
clc
colors

%% Load the data
load mysint2000.mat

dipole=dipole;
s2 = sigma_dip;
v2 = sigma_dip.^2;
v2(end) = v2(end-1);

dt = 1;
Steps = 2000;
t = (dt:Steps)*dt*1e-3-2;

NOP = 200;
[avg_D,D] = Assim_SINT_EnKF_func(NOP);

%% Plot result
myerrorCloud(dipole,2*sigma_dip,epoch,Color(:,6),Color(:,2))
hold on, plot(t,avg_D,'-','Color',Color(:,3),'LineWidth',2);
set(gcf,'Color','w')
xlabel('Time in Myr'),ylabel('Signed relative paleointensity')
axis([-1.25 -0.85 -1.5 1.5])

% save DAResult.mat
