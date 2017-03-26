function [id] = grid_id(i, j, N)
% return 1d index of a 2d grid point in N-by-N grid
% e.g.
% 0 0 0 0
% 0 1 2 0
% 0 3 4 0
% 0 0 0 0

% id = (i - 1) * N + j;
id = (i - 2) * (N - 2) + j - 1;
