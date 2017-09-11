function avg_D = Assim_IS_SINT_func(NOP)

%% Load the data
load mysint2000.mat

s2 = sigma_dip;
v2 = (sigma_dip).^2;
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
w = zeros(NOP,1);
for kk=2:Steps % time loop  
    fprintf('Assimilation %g / %g\n',kk,Steps)
    v2TMP = v2(kk);
    z = dipole(kk);
    dn = D(kk-1,:);
    dn1 = D(kk,:);
    for jj=1:NOP
        q = dt*polyval(pD,dn(jj));
        r = v2TMP;
        s = q*r/(q+r);
        fn = dn(jj)+polyval(pv,dn(jj))*dt;
        dn1(jj) = s*(fn/q+z/r)+sqrt(s)*randn;
        w(jj) = exp(-(z-fn)^2/2/(q+r));
    end
    w = w/sum(w);
    dn1 =  resampling(w,dn1 ,NOP,1);
    D(kk,:) = dn1;
end
avg_D = mean(D,2);



