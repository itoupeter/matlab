function [A] = generate_banded_random(N, K1, K2, scale)
% function that generates a banded matrix of size N by N
% N: dimension of the matrix
% K1: bottom bandwidth
% K2: top bandwidth

if ~exist('K1')
    K1 = 1;
end

if ~exist('K2')
    K2 = K1;
end

if ~exist('scale')
    scale = 1;
end

mask = eye(N);

% lower band
for i = 1 : K1
    if N - i <= 0
        break;
    end
    mask = mask + diag(ones(1, N - i), -i);
end

% upper band
for i = 1 : K2
    if N - i <= 0
        break;
    end
    mask = mask + diag(ones(1, N - i), i);
end

A = rand(N) .* mask * scale;
