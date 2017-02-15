function [ time_cost ] = time_dense_random(n)
% Function that times LU decomposition on dense random matrix of various
% sizes.

N = numel(n);
time_cost = zeros(1, N);
NUM_TRIAL = 10;

for i = 1 : N
    size = n(i);
    A = generate_dense_random(size, size, 100);
    for j = 1 : NUM_TRIAL
        tic;
        % Uncomment one to time
        % res = Ludecomp(A);
        res = lu(A);
        duration = toc;
        time_cost(i) = time_cost(i) + duration;
    end
end

time_cost = time_cost * 100;
