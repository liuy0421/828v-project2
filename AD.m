function [f,X,Y] = AD(A,k,lambda,maxiter,X,Y)

    [n,m] = size(A);
    Omega = isnan(A);
    A(Omega) = 0;

    % initializes X and Y if not given
    if nargin == 4
        X = rand(n,k);
        Y = rand(k,m);
    end
    
    f = zeros(maxiter+1,1);
    f(1) = 0.5 * norm(A-X*Y.*~Omega,'fro')^2 ...
           + (lambda/2)*(norm(X,'fro')^2+norm(Y,'fro')^2);
    
    for iter = 1:maxiter
        
        % update X
        X = zeros(n,k);
        for i = 1:n
            oi = find(Omega(i,:)==0);
            X(i,:) = ((Y(:,oi)*Y(:,oi)'+lambda*eye(k)) ...
                     \ (Y(:,oi)*A(i,oi)'))';
        end
        
        % update Y
        Y = zeros(k,m);
        for j = 1:m
            oj = find(Omega(:,j)==0);
            Y(:,j) = (X(oj,:)'*X(oj,:)+lambda*eye(k)) ...
                     \ (X(oj,:)'*A(oj,j));
        end
        
        f(iter+1) = 0.5 * norm(A-X*Y.*~Omega,'fro')^2 ...
                    + (lambda/2)*(norm(X,'fro')^2 ...
                                  + norm(Y,'fro')^2);
    end
end