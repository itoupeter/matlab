% 30-by-30 grid
N = 30;
x = 0 : N - 1;
x = x ./ (N - 1);
x = repmat(x, N, 1);
y = x';

% construct matrix A (FD of the Laplacian)
M = N * N; % M unknowns
A = eye(M, M);

sinpix = sin(pi * x);
sinpix = reshape(sinpix', [], 1);

epsilon = 0;

h_2 = (N - 1) * (N - 1);

for i = 2 : N - 1
    for j = 2 : N - 1
        % construct 1 row in 1 inner loop

        % center
        id = grid_id(i, j, N);
        A(id, id) = -4 * h_2;

        % east
        if j + 1 <= N
            eid = grid_id(i, j + 1, N);
            A(id, eid) = h_2;
        end

        % west
        if j - 1 >= 1
            wid = grid_id(i, j - 1, N);
            A(id, wid) = h_2;
        end

        % north
        if i - 1 >= 1
            nid = grid_id(i - 1, j, N);
            A(id, nid) = h_2;
        end

        % south
        if i + 1 <= N
            sid = grid_id(i + 1, j, N);
            A(id, sid) = h_2;
        end
    end
end

% linear problem solution
n = 1;
m = 1;
Anm = 1;
u = Anm .* sin(m * pi * x) .* sin(n * pi * y);
U = reshape(u', [], 1);

% advance paramter to do AC (lambda in this case)
lambda = (m.^2 + n.^2) * pi.^2;
delta_lambda = -0.1;

Unorms = [];
lambdas = lambda : delta_lambda : 2;
for old_lambda = lambdas
    % dR_dU * dU_dLambda = -dR_dLambda
    % solve for dU_dLambda
    % U_k+1 = U_k + dU_dLambda * delta_lambda to get initial guess
    dR_dU = A + diag(old_lambda * (1 + 2 * U));
    dR_dLambda = U .* (1 + U);
    dU_dLambda = -dR_dU \ dR_dLambda;
    U0 = U + dU_dLambda * delta_lambda;

    % use Newton to converge to solutionon_solve(A
    U = newton_solve(A, old_lambda + delta_lambda, epsilon, U0);
%     plot_solution(U, x, y, N); zlim([0 1]);
%     pause(0.2);
    
    % save solution norm for plotting
    Unorms = [Unorms norm(U, 2)];
end

plot(lambdas, Unorms, 'rx');
