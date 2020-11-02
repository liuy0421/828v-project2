function [C,U,R] = CUR(A,c,k)
    C = ColumnSelect(A,c,k);
    R = ColumnSelect(A',c,k);
    U = (R\(C\A)')';
end