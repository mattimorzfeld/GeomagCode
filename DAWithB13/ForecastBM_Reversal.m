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

%% Assimilation
dt = 1;
Steps = 2000;
%% Model parameters
load BruceB.mat


%% Load the data
load DAResult.mat

%% BM Reversal at
i = 1224;
% i = 1013;
% i = 930;
% i = 500;

t = t(1:i);
D = D(1:i,:); 
avg_D = mean(D,2);

%% Forecast
Stepsf = 100;%4;
tf = t(i)+(0:Stepsf)*dt*1e-3;

Df = zeros(Stepsf+1,NOP);
Df(1,:)=D(i,:);
for jj=1:NOP
    x = D(i,jj);
%     fprintf('Forecast %g / %g \n',jj,NOP)
    for kk=1:Stepsf
        x =x+polyval(pv,x)*dt+sqrt(dt*polyval(pD,x))*randn;
        Df(kk+1,jj) = x;
    end
end
avg_Df = mean(Df,2);

%% Plot results
myerrorCloud(dipole,2*sigma_dip,epoch,Color(:,6),Color(:,2))
hold on, plot(t,avg_D,'--','Color',Color(:,3),'LineWidth',2);
hold on, plot(tf,Df','-','Color',Color(:,3),'LineWidth',1);
hold on, plot(tf,avg_Df,'-','Color',[220 125 0]/255,'LineWidth',2);

set(gcf,'Color','w')
axis([-.88 -.68 -2.5 2.5])


