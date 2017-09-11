function [x,t] = myG12Model(xo,T)
dt  = 5e-2;      % Time step
G2R  = 4e-3;
t = 0:dt:(T/G2R);
[~,x] =ode45(@fG12,t,xo);
t = t*G2R;