function [x] = jacobi_solve(A, b, x0)
% solve for x in Ax=b using Jacobi iterative solver.

n = size(A, 1);
x = zeros(n, 1);
xx = ones(n, 1);

if exist('x0')
    xx = x0;
end

tol = 0.001;
ite = 0;

while 1
    ite = ite + 1;
    for i = 1 : n
        tmp = 0;
        for j = 1 : n
            if i == j
                continue;
            end
            tmp = tmp + A(i, j) * xx(j);
        end
        x(i) = (b(i) - tmp) / A(i, i);
    end

    if norm(x - xx) < tol
        break;
    elseif ite >= n
        x = zeros(n, 0);
        break;
    else
        xx = x;
    end
end
