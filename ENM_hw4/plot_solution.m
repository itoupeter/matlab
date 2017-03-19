function [ dummy ] = plot_solution(U, x, y, N)
%PLOT_SOLUTION Summary of this function goes here
%   Detailed explanation goes here

Uf = zeros(N, N);
Uf(2:N - 1, 2:N - 1) = reshape(U, N - 2, N - 2)';
surf(x, y, Uf);

end

