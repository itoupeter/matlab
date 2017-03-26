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
sinpix = reshape(sinpix(2:N-1, 2:N-1)', [], 1);

h_2 = (N - 1) * (N - 1);

for i = 2 : N - 1
    for j = 2 : N - 1
        % construct 1 row in 1 inner loop

        % center
        id = grid_id(i, j, N);
        A(id, id) = -4 * h_2;

        % east
        if j + 1 < N
            eid = grid_id(i, j + 1, N);
            A(id, eid) = h_2;
        end

        % west
        if j - 1 > 1
            wid = grid_id(i, j - 1, N);
            A(id, wid) = h_2;
        end

        % north
        if i - 1 > 1
            nid = grid_id(i - 1, j, N);
            A(id, nid) = h_2;
        end

        % south
        if i + 1 < N
            sid = grid_id(i + 1, j, N);
            A(id, sid) = h_2;
        end
    end
end

% parameters
epsilon = 2;
lambda0 = 50;
lambda1 = 50.5;

% load initial solutions U0
load b.mat u_l15_e2_b1_hill u_l25_e2_b1_bowl u_l50_e2_b2_hill u_l50_e2_b2_bowl;
U0 = u_l50_e2_b2_bowl;
plot_solution(U0, x, y, N);

% do AC on lambda and calculate U1
dR_dU = A + diag(lambda0 * (1 + 2 * U0));
dR_dLambda = U0 .* (1 + U0);
dU_dLambda = -dR_dU \ dR_dLambda;
U1 = U0 + dU_dLambda * (lambda1 - lambda0);
U1 = newton_solve(A, lambda1, epsilon, U1, sinpix);
plot_solution(U1, x, y, N);

% do ALC on s
delta_s = (norm(U1 - U0, 2) + norm(lambda1 - lambda0, 2))^0.5;

Unorms = [norm(U0, 2) norm(U1, 2)];
lambdas = [lambda0 lambda1];
while lambda1 < 60
    % Jacobi
    dR_dU = A + diag(lambda1 * (1 + 2 * U1));
    dR_dLambda = U1 .* (1 + U1);
    dEta_dU = -2 * (U1 - U0);
    dEta_dLambda = -2 * (lambda1 - lambda0);
    J = zeros(M + 1, M + 1);
    J(1:M, 1:M) = dR_dU;
    J(1:M, M + 1) = dR_dLambda;
    J(M + 1, 1:M) = dEta_dU';
    J(M + 1, M + 1) = dEta_dLambda;
    
    dR_dS = zeros(M + 1, 1);
    dR_dS(M + 1) = 2 * delta_s;
    
    dU_dLambda_dS = -J \ dR_dS;
    dU_dS = dU_dLambda_dS(1:M, 1);
    dLambda_dS = dU_dLambda_dS(M + 1, 1);
    U2 = U1 + delta_s * dU_dS;
    lambda2 = lambda1 + delta_s * dLambda_dS;
    
    % use Newton
    [U2 lambda2] = augmented_newton_solve(A, J, epsilon, sinpix, delta_s, U1, U2, lambda1, lambda2);
    if lambda2 == 0
        break;
    end
    Unorms = [Unorms norm(U2, 2)];
    lambdas = [lambdas lambda2];
%     plot_solution(U2, x, y, N);
    
    % for next iteration
    U0 = U1;
    U1 = U2;
    lambda0 = lambda1;
    lambda1 = lambda2;
end

plot(lambdas, Unorms, 'rx');
