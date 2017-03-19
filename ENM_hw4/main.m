% 30-by-30 grid
N = 30;
x = 0 : N - 1;
x = x ./ (N - 1);
x = repmat(x, N, 1);
y = x';

% construct matrix A (FD of the Laplacian)
M = (N - 2) * (N - 2); % M unknowns
A = zeros(M, M);
h_2 = (N - 1) * (N - 1);
row_id = 0;

for i = 2 : N - 1
    for j = 2 : N - 1
        % construct 1 row in 1 inner loop
        
        % center
        id = grid_id(i, j, N);
        A(id, id) = -4 * h_2;

        % east
        if j < N - 1
            eid = grid_id(i, j + 1, N);
            A(id, eid) = h_2;
        end

        % west
        if j > 2
            wid = grid_id(i, j - 1, N);
            A(id, wid) = h_2;
        end

        % north
        if i > 2
            nid = grid_id(i - 1, j, N);
            A(id, nid) = h_2;
        end

        % south
        if i < N - 1
            sid = grid_id(i + 1, j, N);
            A(id, sid) = h_2;
        end
    end
end

% linear problem solution
n = 1;
m = 2;
Anm = -1;
u = Anm .* sin(m * pi * x) .* sin(n * pi * y);
U = reshape(u(2:N - 1, 2:N - 1)', [], 1);
lambda = (m.^2 + n.^2) * pi.^2;

% use linear solution to jump on non-linear solution branch
U = newton_solve(A, lambda, U);
%plot_solution(U, x, y, N);

% advance paramter to do AC (lambda in this case)
delta_lambda = 0.015;

Unorms = [];
lambdas = lambda : delta_lambda : 60;
for next_lambda = lambdas
    % dR_dU * dU_dLambda = -dR_dLambda
    % solve for dU_dLambda
    % U_k+1 = U_k + dU_dLambda * delta_lambda to get initial guess
    dR_dU = A + diag(next_lambda * (1 + 2 * U));
    dR_dLambda = U .* (1 + U);
    dU_dLambda = -dR_dU \ dR_dLambda;
    U0 = U + dU_dLambda * delta_lambda;

    % use Newton to converge to solution
    U = newton_solve(A, next_lambda, U0);
    Unorms = [Unorms norm(U, 2)];
end

plot(lambdas, Unorms, 'rx');
