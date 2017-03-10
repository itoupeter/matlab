function [x] = newton_solve(A, b, x0)
% function: solve for x in Ax=b using Newton's method.

n = size(A, 1);
xx = ones(n, 1);
x = zeros(n, 1);
ite = 0;
tol = 1e-14;

if exist('x0')
    xx = x0;
end

while 1
    r = A * xx - b;
    dx = -A \ r;
    x = xx + dx;

    if norm(x - xx) < tol
        break;
    elseif norm(x) > 1e10
        disp('Diverges.');
        x = zeros(n, 0);
        return;
    else
        xx = x;
    end

    ite = ite + 1;
end

disp(['# of iterations: ', num2str(ite)]);
