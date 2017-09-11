clear 
close all
clc
colors

%% B13 model
xo = 1; % initial amplitude
T = 10; % simulation time in million years
[X,t] = myB13Model(xo,T);
figure
hold on,plot(t,X,'Color',Color(:,2),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20')
xlabel('Time in Myr'),ylabel('Dipole')
title('B13')


%% P09 Model
xo = [.42; -36.7853]; % initial amplitude and angle
T = 5; % simulation time in million years
[D,theta,t] = myP09Model(T,xo);


figure, plot(t,D,'Color',Color(:,2),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20')
box off
xlabel('Time in Myr'),ylabel('Dipole')
title('P09')


%% G12 model
xo = [-0.8603;1.3667;-0.0094];
T = 5; % simulation time in million years
[x,t] = myG12Model(xo,T);
% Dipole is second variable of G12 model
D = x(:,2);

figure
hold on,plot(t,D,'Color',Color(:,2),'LineWidth',2)
set(gcf,'Color','w')
set(gca,'FontSize',20')
xlabel('Time in Myr'),ylabel('Dipole')
title('G12')