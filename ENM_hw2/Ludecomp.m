function [L, U] = ludecomp(A)
% function that decompose a square matrix A into product of two matrix L and U,
% where L is a lower triangular matrix and U is a upper trianagular matrix.

assert(size(A, 1) == size(A, 2), 'Input matrix needs to be a square matrix.');

L = eye(size(A));
U = A;
n = size(A, 1);

for k = 1 : n - 1
    for i = k + 1 : n
        fact = U(i, k) / U(k, k);
        L(i, k) = fact;
        U(i, k) = 0;
        for j = k + 1 : n
            U(i, j) = U(i, j) - fact * U(k, j);
        end
    end
end
