function [A] = generate_random(N, M, scale)
% function that generate dense random matrix of size N by M

if ~exist('M')
    M = N;
end

if ~exist('scale')
    scale = 1;
end

A = rand(N, M) * scale;
