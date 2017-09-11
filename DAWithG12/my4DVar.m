function xAll = my4DVar(muo,PoInv,nObs,nObsAtATime,Gap,dt,var_dip,dipole)

Steps = nObs*Gap;
xAll = zeros(3,Steps);
for ll=1:nObs/nObsAtATime
    disp(' ' )
    fprintf('Assimilation %g / %g \n',ll,nObs/nObsAtATime)
    R = var_dip((ll-1)*nObsAtATime+2:ll*nObsAtATime+1);
    z = dipole((ll-1)*nObsAtATime+2:ll*nObsAtATime+1);
%     [~,Mode_4DVar,~,~,~] = minimizeX(muo,mu,nu,G,dt,Gap,nObsAtATime,R,H,z,Po,PoInv,muo);
    [Mode_4DVar,~]=minimizeM(muo,dt,Gap,nObsAtATime,R,z,PoInv,muo);
%     x4DVar = forwardModel(dt,nObsAtATime*Gap,Mode_4DVar,mu,nu,G);
    [~,x4DVar] =ode45(@f,(0:Gap*nObsAtATime)*dt,Mode_4DVar); x4DVar = x4DVar';
    muo=x4DVar(:,end);
    xAll(:,(ll-1)*Gap*nObsAtATime+1:ll*nObsAtATime*Gap+1)=x4DVar;
%     hold on, plot(dt*((ll-1)*nObsAtATime*Gap+1:ll*nObsAtATime*Gap+1)*4e-3,x4DVar(2,:),'r')
%     drawnow
end