% ColumnSelect is a subroutine for CUR factorization,
% and this code is based on Prof. Cameron's notes in
% class
function [C] = ColumnSelect(A,c,k)
    
    % selecting columns of V from top k singular values
    [~,~,V] = svd(A, 'econ');
    Vk = V(:,1:k);
    p = (1/k).*sum(Vk.^2,2);
    
    % keeping column j with probability min{1,ptemp_j}
    ptemp = c.*p;
    eta = rand(size(ptemp));
    diff = ptemp-eta;
    ind = find(diff > 0);
    C = A(:,ind);
    
end