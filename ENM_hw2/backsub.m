function [x] = backsub(U, b)
% function thats takes in upper triangular matrix U and vector b and solve for
% x in Ux = b

n = size(U, 1);
x = zeros(n, 1);

for i = n : -1 : 1
    tmp = b(i);
    for j = i + 1 : n
        tmp = tmp - U(i, j) * x(j);
    end
    x(i) = tmp / U(i, i);
end
