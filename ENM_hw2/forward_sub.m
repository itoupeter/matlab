function [x] = backsub(L, b)
% function thats takes in lower triangular matrix U and vector b and solve for
% x in Lx = b

n = size(L, 1);
x = zeros(n, 1);

for i = 1 : n
    tmp = b(i);
    for j = 1 : i - 1
        tmp = tmp - L(i, j) * x(j);
    end
    x(i) = tmp / L(i, i);
end
