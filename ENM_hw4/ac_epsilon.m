% 30-by-30 grid
N = 30;
x = 0 : N - 1;
x = x ./ (N - 1);
x = repmat(x, N, 1);
y = x';

% construct matrix A (FD of the Laplacian)
M = N * N; % M unknowns
A = zeros(M, M);

sinpix = sin(pi * x);
sinpix = reshape(sinpix', [], 1);

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

% use epsilon = 0 problem solution to jump on epsilon = 2 solution branch
load b.mat u_l15_e0_b1_hill u_l25_e0_b1_bowl u_l50_e0_b2_hill u_l50_e0_b2_bowl;
U = u_l50_e0_b2_bowl;
% plot_solution(U, x, y, N);

% advance paramter to do AC (epsilon in this case)
lambda = 50;
epsilon = 0;
delta_epsilon = 0.1;

Unorms = [];
epsilons = epsilon : delta_epsilon : 2;
for old_epsilon = epsilons
    % dR_dU * dU_dEpsilon = -dR_dEpsilon
    % solve for dU_dEpsilon
    % U_k+1 = U_k + dU_dEpsilon * delta_epsilon to get initial guess
    dR_dU = A + diag(lambda * (1 + 2 * U));
    dR_dEpsilon = sinpix;
    dU_dEpsilon = -dR_dU \ dR_dEpsilon;
    U0 = U + dU_dEpsilon * delta_epsilon;

    % use Newton to converge to solution
    U = newton_solve(A, lambda, old_epsilon + delta_epsilon, U0, sinpix);
%     plot_solution(U, x, y, N);
%     pause(0.2);
    Unorms = [Unorms norm(U, 2)];
end

plot(epsilons, Unorms, 'rx');
