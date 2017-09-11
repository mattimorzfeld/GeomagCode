function [xAll,  Xn] = myIPF(NOP,muo,PoInv,nObs,nObsAtATime,Gap,dt,var_dip,dipole)
Steps = nObs*Gap;
xAll = zeros(3,Steps+1);

for ll=1:nObs/nObsAtATime
    fprintf('Assimilation %g / %g \n',ll,nObs/nObsAtATime)      
    R = var_dip((ll-1)*nObsAtATime+2:ll*nObsAtATime+1);
    z = dipole((ll-1)*nObsAtATime+2:ll*nObsAtATime+1);
    [Mode_4DVar,H]=minimizeM(muo,dt,Gap,nObsAtATime,R,z,PoInv,muo);
    Hinv = mypinv(H,1e-3); % pseudo-inverse
    [U,S,~] = svd(Hinv);
    L = U*diag(sqrt(diag(S)));
    Xo = zeros(3,NOP);
    Xn = zeros(3,NOP);
    w  = zeros(NOP,1);
    for kk=1:NOP
        Xo(:,kk) = Mode_4DVar + L*randn(3,1);

        [~,x] =ode45(@f,(0:Gap*nObsAtATime)*dt,Xo(:,kk));x = x';
        Xn(:,kk) = x(:,end);
        w(kk) = 0.5*(Xo(:,kk)-Mode_4DVar)'*(H*(Xo(:,kk)-Mode_4DVar))...
            -funcF(Xo(:,kk),R,z,Gap,nObsAtATime,PoInv,muo,dt);
    end
    
    w = w-max(w);
    w = exp(w);
    w = w/sum(w);
    [~,xIPF] =ode45(@f,(0:Gap*nObsAtATime)*dt,Xo*w); xIPF = xIPF';

    muo  = xIPF(:,end);
    xAll(:,(ll-1)*Gap*nObsAtATime+1:ll*nObsAtATime*Gap+1)=xIPF;
    Xn = resampling(w,Xn,NOP,3);


end

