% Implements the [Lee & Seung, 2001] scheme 
% for nonnegative matrix factorization
% with inner dimension k
function [fro, W, H] = MU(A, k, maxiter, W, H)

    [n,m] = size(A);
    
    % initializes W and H if not given
    if nargin == 3
        W = rand(n,k);
        H = rand(k,m);
    end
    
    fro = zeros(maxiter+1,1);
    fro(1) = 0.5*norm(A-W*H,'fro')^2;
    
    for i = 1:maxiter
        % update H
        Sh = H./(W'*W*H);
        Hnew = Sh.*(W'*A);
        Hnew(isnan(Sh)) = H(isnan(Sh));
        H = Hnew;
        
        % update W
        Sw = W./(W*H*H');
        Wnew = Sw.*(A*H');
        Wnew(isnan(Sw)) = W(isnan(Sw));
        W = Wnew;
        
        fro(i+1) = 0.5*norm(A-W*H,'fro')^2;
    end
end