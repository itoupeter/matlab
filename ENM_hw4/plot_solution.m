function [ dummy ] = plot_solution(U, x, y, N)
%PLOT_SOLUTION Summary of this function goes here
%   Detailed explanation goes here

U = reshape(U, N, N)';

figure(1);
surf(x, y, U);

figure(2);
[C, h] = contour(x, y, U);
clabel(C, h);

end
