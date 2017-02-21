function [x] = direct_solve(A, b)
% solve for x in Ax=b using my LU decomposition, back/forward substitution.

addpath('../ENM_hw2/');

[B, P] = ludecomp(A);
U = triu(B);
L = tril(B);
L(logical(eye(size(B)))) = 1;

b = P * b;
d = forward_sub(L, b);
x = back_sub(U, d);

rmpath('../ENM_hw2/');
