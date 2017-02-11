function [A] = generate_hilbert(N, M)
% This function generates Hilbert matrix of size N by M

if ~exist('M')
    M = N;
end

B = [1 : N]'; % [1 2 ...]'
B = repmat(B, 1, M);

C = [0 : M - 1]; % [1 2 ...]
C = repmat(C, N, 1);

A = 1 ./ (B + C);
