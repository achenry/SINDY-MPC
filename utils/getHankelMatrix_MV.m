function H = getHankelMatrix_MV(xdat,stackmax)

[M,Nvar] = size(xdat);

H = zeros(Nvar*stackmax,M-stackmax+1);
for k=1:stackmax
    rows = ((k-1) * Nvar) + 1:k * Nvar; % row indices corresponding to this set of (delayed by k) states
    H(rows,:) = xdat(k:M - stackmax + k, :)'; % set states at each time instance
end

end