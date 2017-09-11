function out = mypinv(A,tol)
[U S V] = svd(A);
S = diag(S);
ii = find(abs(S)>tol);
if isempty(ii)
    out = eye(3);
else
    Sinv = diag([1./S(ii);zeros(length(S)-length(ii),1)]);
    out = V*(Sinv*U');
end
