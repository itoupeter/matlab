function [out] = ludecomp(A)
% function that decompose a square matrix A into product of two matrix L and U,
% where L is a lower triangular matrix and U is a upper trianagular matrix.

assert(size(A, 1) == size(A, 2), 'Input matrix needs to be a square matrix.');

out = A;
n = size(A, 1);

for k = 1 : n - 1
    out = pivot(out, k);

    for i = k + 1 : n
        fact = out(i, k) / out(k, k);
        out(i, k) = fact;
        % U(i, k) = 0;
        for j = k + 1 : n
            out(i, j) = out(i, j) - fact * out(k, j);
        end
    end
end
