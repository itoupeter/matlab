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

lambda = 55;
epsilon = 0;

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

% use epsilon = 0 problem solution to jump on epsilon = 2 solution branch
load data.mat U_lambda55_epsilon0_bowl U_lambda55_epsilon0_hill;
U = U_lambda55_epsilon0_hill;
%plot_solution(U, x, y, N);

% advance paramter to do AC (epsilon in this case)
delta_epsilon = 0.1;

epsilons = epsilon : delta_epsilon : 2;
Unorms = [];
for next_epsilon = epsilons
    % dR_dU * dU_dEpsilon = -dR_dEpsilon
    % solve for dU_dEpsilon
    % U_k+1 = U_k + dU_dEpsilon * delta_epsilon to get initial guess
    dR_dU = A + diag(lambda * (1 + 2 * U));
    dR_dEpsilon = sinpix;
    dU_dEpsilon = -dR_dU \ dR_dEpsilon;
    U0 = U + dU_dEpsilon * delta_epsilon;

    % use Newton to converge to solution
    U = newton_solve(A, lambda, next_epsilon, U0);
    %plot_solution(U, x, y, N);
    %pause(0.2);
    Unorms = [Unorms norm(U, 2)];
end

plot(epsilons, Unorms);
