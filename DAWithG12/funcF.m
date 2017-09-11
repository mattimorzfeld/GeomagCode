function out = funcF(xo,R,y,Gap,nObsAtATime,PoInv,muo,dt)
%%
% .........................................................................
% Evaluate the function F in implicit sampling
%
% syntax:   
%           Input:
%                           x                state trajectory
%                           R                covariane of observations
%                           y                the data
%
%                    
%           Output:  out               value of F at xo
%
% .........................................................................
[~,x] =ode45(@f,(0:Gap*nObsAtATime)*dt,xo);
x = x';
out = 0.5*(x(:,1)-muo)'*(PoInv*(x(:,1)-muo));
for kk=1:nObsAtATime
    out = out+(2*R(kk))\(x(2,kk*Gap+1)/sqrt(2)-y(kk))^2;
end