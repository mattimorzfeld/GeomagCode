function [avg_D,D,theta] = Assim_SINT_SIR_func(NOP)

%% Load the data
load mysint2000.mat

s2 = sigma_dip;
v2 = sigma_dip.^2;
v2(end) = v2(end-1);

%% Assimilation
dt = 1e-3;
Steps = 2/dt;

%% Model parameters
a0 = -185;
a1 = a0/.9;
s = sqrt(abs(a1))*.2;
R = 1.3;
theta_o = 0.3;

%% Initialize particles
theta = zeros(Steps,NOP);
D = zeros(Steps,NOP);

for kk=1:NOP
    D(1,kk) = dipole(1)+0.1*randn;
    theta(1,kk) =  pi*rand;
end
clear tmp sTMP dTMP

%% Run assimilation
w = zeros(NOP,1);
for kk=2:Steps % time loop  
    fprintf('Assimilation %g / %g\n',kk,Steps)
    T = theta(kk-1,:);
%     d = D(kk-1,:);
    v2TMP = v2(kk);
    z = dipole(kk);
    
    for jj=1:NOP
        fn = DPetrelis(T(jj),dt);
        T(jj) = real(fn+sqrt(dt)*s*randn);
        d(jj) = R*cos(T(jj)-theta_o);
        w(jj) = exp(-(d(jj)-z)^2/2/v2TMP);
    end
    w = w/sum(w);
    T =  resampling(w,T,NOP,1);
    theta(kk,:) = T;
    d =  resampling(w,d,NOP,1);
    D(kk,:) = d;
end

avg_D = mean(D,2);

fprintf('Error = %g\n', norm(dipole-avg_D)/norm(dipole))


