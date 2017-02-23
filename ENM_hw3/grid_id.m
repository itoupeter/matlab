function [id] = grid_id(row, col, n)
% calculate 1D index of a grid point at (x, y) in a n-by-n grid.

% e.g.
% n = 3
% indices are:
% 7 8 9
% 4 5 6
% 1 2 3

id = (row - 1) * n + col;
