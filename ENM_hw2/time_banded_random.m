function [ time_cost ] = time_banded_random( n )
%TIME_BANDED_RANDOM Summary of this function goes here
%   Detailed explanation goes here

N = numel(n);
time_cost = zeros(1, N);
NUM_TRIAL = 10;

for i = 1 : N
    size = n(i);
    A = generate_banded_random(size, 1, 1, 100);
    for j = 1 : NUM_TRIAL
        tic;
        % Uncomment one to time
        res = Ludecomp(A);
        % res = lu(A);
        duration = toc;
        time_cost(i) = time_cost(i) + duration;
    end
end

time_cost = time_cost * 100;
