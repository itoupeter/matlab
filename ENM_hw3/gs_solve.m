function [x] = gs_solve(A, b, x0)
% solve for x in Ax=b using Gauss-Seidel iterative solver.

n = size(A, 1);
x = ones(n, 1);
xx = ones(n, 1);

if exist('x0')
    xx = x0;
end

tol = 1e-14;
ite = 0;

while 1
    ite = ite + 1;

    for i = 1 : n
        tmp = 0;
        for j = 1 : n
            if i == j
                continue;
            end

            tmp = tmp + A(i, j) * x(j);
        end
        x(i) = (b(i) - tmp) / A(i, i);
    end

    if norm(xx - x) < tol
        break;
    elseif norm(x) > 1e10
        disp('Diverges.');
        x = zeros(n, 1);
        return;
    else
        xx = x;
    end
end

disp(['# of iterations: ', num2str(ite)]);
