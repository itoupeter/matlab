% 30-by-30 grid
N = 30;
x = 0 : N - 1;
x = x ./ (N - 1);
x = repmat(x, N, 1);
y = x';

% construct matrix A (FD of the Laplacian)
M = (N - 2) * (N - 2); % M unknowns
A = zeros(M, M);

sinpix = sin(pi * x);
sinpix = reshape(sinpix(2:N - 1, 2:N - 1)', [], 1);

lambda = 20;
epsilon = 2;

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

% use solution to epsilon = 0, lambda = 20 to jump on to epsilon = 2 solution branch
load data.mat U2_20;
U = U2_20;
%plot_solution(U, x, y, N);

% advance paramter to do AC (lambda in this case)
delta_lambda = 0.1;

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

    % use Newton to converge to solutionon_solve(A
    U = newt, next_lambda, epsilon, U0, sinpix);
    Unorms = [Unorms norm(U, 2)];
    %plot_solution(U, x, y, N);
    %pause(0.2);
end

plot(lambdas, Unorms, 'rx');
