
N = 30;
x = 0 : N - 1;
x = x ./ (N - 1);
x = repmat(x, 30, 1);
y = x';

M = (N - 2) * (N - 2);
A = zeros(M, M);
b = zeros(M, 1);
h = 1 / (N - 1);
h_2 = 1 / h / h;
row_id = 0;

for i = 2 : N - 1
    for j = 2 : N - 1
        % construct 1 row in 1 inner loop
        row_id = row_id + 1;

        % RHS
        b(row_id) = .1;

        % center
        id = grid_id(i, j, N);
        A(row_id, id) = -4 * h_2;

        % east
        if j < N - 1
            eid = grid_id(i, j + 1, N);
            A(row_id, eid) = h_2;
        end

        % west
        if j > 2
            wid = grid_id(i, j - 1, N);
            A(row_id, wid) = h_2;
        end

        % north
        if i > 2
            nid = grid_id(i - 1, j, N);
            A(row_id, nid) = h_2;
        end

        % south
        if i < N - 1
            sid = grid_id(i + 1, j, N);
            A(row_id, sid) = h_2;
        end
    end
end

u = newton_solve(A, b);
u = reshape(u, N - 2, N - 2);
U = zeros(N, N);
U(2:N-1, 2:N-1) = u';
