function [x,hessian]=minimizeM(xo,dt,Gap,nObsAtATime,R,y,PoInv,muo)
f=@(x)funcF(x,R,y,Gap,nObsAtATime,PoInv,muo,dt);
TypX = xo;
tmp = find(TypX ==0);
TypX(tmp)=1;
options = optimoptions('fminunc','Algorithm','quasi-newton','GradObj','off','DerivativeCheck','off',...
    'Display','off','TypicalX',TypX,'TolFun',1e-4);
[x,~,~,~,~,hessian] = fminunc(f,muo,options);