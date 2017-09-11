clear all
close all
clc
colors

NOP = 1000;
avg_D = Assim_PADM2M_SIR_func(NOP);

%%
load myPADM2M.mat
dt = 1e-3;
Steps = 2/dt;
t = (dt:Steps)*dt-2;

figure
myerrorCloud(dipole,2*sigma_dip,epoch,Color(:,6),Color(:,2))
hold on, plot(dt+t,avg_D,'-','Color',Color(:,4),'LineWidth',2);
set(gcf,'Color','w')
xlabel('Time in Myr'),ylabel('Signed relative paleointensity')
% axis([-1.25 -0.85 -2 2])