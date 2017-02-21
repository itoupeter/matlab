function [x] = direct_solve(A, b)
% solve for x in Ax=b using my LU decomposition, back/forward substitution.

addpath('../ENM_hw2/');

[L, U, P] = ludecomp(A);
b = P * b;
d = forward_sub(L, b);
x = back_sub(U, d);

rmpath('../ENM_hw2/');
