% generate grid points
M = 31;
x = 0 : 1 : M - 1;
x = x ./ (M - 1);
x = repmat(x, M, 1);

y = x';

dx_2 = (M - 1) * (M - 1);
dy_2 = (M - 1) * (M - 1);

% sin(2 pi x) * cos(2 pi y)
f = sin(2 * pi * x) .* sin(2 * pi * y);

% construct matrix A and vector b in Ax=b
% # of equations/unknowns: (M - 2) * (M - 2)
n = (M - 2)^2;
A = zeros(n, n);
b = zeros(n, 1);
row_id = 0;

for i = 2 : M - 1
	for j = 2 : M - 1
		% construct 1 row in one inner loop
		row_id = row_id + 1;

		% RHS (b)
		b(row_id) = -f(i, j);

		% id of unknowns, 2D to 1D
		x_id = grid_id(i - 1, j - 1, M - 2);

		% A
        % Center
        A(row_id, x_id) = -2 * (dx_2 + dy_2);

		% East
		if j + 1 < M
			e_id = grid_id(i - 1, j, M - 2);
			A(row_id, e_id) = dx_2;
		end

		% West
		if j - 1 > 1
			w_id = grid_id(i - 1, j - 2, M - 2);
			A(row_id, w_id) = dx_2;
        end

        % North
        if i + 1 < M
            n_id = grid_id(i, j - 1, M - 2);
            A(row_id, n_id) = dy_2;
        end

        % South
        if i - 1 > 1
            s_id = grid_id(i - 2, j - 1, M - 2);
            A(row_id, s_id) = dy_2;
        end
    end
end

u = gs_solve(A, b);
u = reshape(u, M - 2, M - 2)';
U = zeros(M);
U(2:M - 1, 2:M - 1) = u;

figure(1);
[C, h] = contour(x, y, U);
clabel(C, h)
title(['Contour ', num2str(M), '-by-', num2str(M), ' with Gauss-Seidel']);

% figure(2);
% surf(x, y, U);
% title(['Solution ', num2str(M), '-by-', num2str(M)]);
