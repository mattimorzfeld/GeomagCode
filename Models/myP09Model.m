function [D,theta,t] = myP09Model(T,xo)

%% Model parameters
a1 = -185;
a0 = -.9*a1;
s = sqrt(abs(a1))*.2;
R = 1;
theta_o = 0.3;

% time step
dt = 1e-3;
Steps = T/dt;

%% Initialize
theta = zeros(Steps,1);
D = zeros(Steps,1);
D(1) = xo(1);
theta(1) = xo(2);

%% simulation
for kk=2:Steps 
    fn = theta(kk-1) +dt*(a0+a1*sin(2*theta(kk-1)));
    theta(kk) = real(fn+sqrt(dt)*s*randn);
    D(kk) = R*cos(theta(kk)+theta_o);
end
t = (0:length(D)-1)*dt; % time