function [f, M] = NNT(A,lambda,maxiter,M)

    [n,m] = size(A);
    Omega = isnan(A);
    A(Omega) = 0;

    % initializes M if not given
    if nargin == 3
        M = rand(n,m);
    end
    
    f = zeros(maxiter+1,1);
    f(1) = 0.5 * norm((A-M).*~Omega,'fro')^2 ...
           + lambda*norm(svd(M),1);
    
    for iter = 1:maxiter
        [U,S,V] = svd(M+(A-M).*~Omega);
        S(1:m,1:m) = S(1:m,1:m) - lambda*eye(m);
        S(S<0) = 0;
        M = U*S*V';
        f(iter+1) = 0.5 * norm((A-M).*~Omega,'fro')^2 ...
                    + lambda*norm(svd(M),1);
    end
    
end