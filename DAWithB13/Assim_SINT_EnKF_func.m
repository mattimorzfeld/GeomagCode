function [avg_D,D] = Assim_SINT_EnKF_func(NOP)

%% Load the data
load mysint2000.mat
s2 = sigma_dip;
v2 = sigma_dip.^2;
v2(end) = v2(end-1);

%% Assimilation
dt = 1;
Steps = 2000;
%% Model parameters
load BruceB.mat

%% Initialize particles
D = zeros(Steps,NOP);
D(1,:) = dipole(1)+s2(1)*randn(size(D(1,:)));
%% Run assimilation
for kk=2:Steps % time loop  
    fprintf('Assimilation %g / %g\n',kk,Steps) 
    v2TMP = v2(kk);
    z = dipole(kk);
    dn = D(kk-1,:);
    dn1 = D(kk,:);
    pertData = zeros(1,NOP);
    for jj=1:NOP
        dn1(jj) = dn(jj)+polyval(pv,dn(jj))*dt...
                    +sqrt(dt*polyval(pD,dn(jj)))*randn;
        pertData(jj)  = z+sqrt(v2TMP)*randn;
    end
    % EnKF step
    E = mean(dn1,2);
    A = dn1-E*ones(1,NOP);
    C = (NOP-1)\(A*A');
    X = dn1+C*((C+v2TMP)\(pertData-dn1));    
    D(kk,:) = X;
end

avg_D = mean(D,2);

