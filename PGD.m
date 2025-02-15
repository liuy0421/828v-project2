% Implements projected gradient descent
% for nonnegative matrix factorization
% with inner dimension k
function [fro, W, H] = PGD(A, k, maxiter, W, H)

    [n,m] = size(A);
    
    % initializes W and H if not given
    if nargin == 3
        W = rand(n,k);
        H = rand(k,m);
    end
    
    alpha = 0.02;
    R = A-W*H;
    fro = zeros(maxiter+1,1);
    fro(1) = 0.5*norm(R,'fro')^2;
    
    for i = 1 : maxiter
        alpha = alpha/1.01;
        Wnew = W + alpha*(R*H');
        Hnew = H + alpha*(W'*R);
        Wnew(Wnew < 0) = 0;
        Hnew(Hnew < 0) = 0;
        R = A-Wnew*Hnew;
        fro(i+1) = 0.5*norm(R,'fro')^2;
        W = Wnew;
        H = Hnew;
    end
end