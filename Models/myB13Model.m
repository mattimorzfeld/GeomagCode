function [X,t] = myB13Model(xo,T)

% this file contains the drift and diffusion coefficients
% of the B13 model.These were made with Bruce's code
% If you want, you can also have the files to create the model
load B13.mat

dt    = 1;
B132Real = 1e-3; % model time to geophysical time conversion
Steps = T/(dt*B132Real);
t = (1:Steps)*dt*B132Real; % in Myrs
x = xo; % initial condition
X = zeros(Steps,1);
X(1) = x;
for kk=2:Steps
    x =x+fnval(pv,x)*dt+sqrt(dt*polyval(pD,x))*randn;
    X(kk) = x;
end
