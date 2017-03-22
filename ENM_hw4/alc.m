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

% load initial solutions U0, U1
load d.mat U_l20_e0 U_l20_01_e0 U_l20_1_e0;
U0 = U_l20_e0;
U1 = U_l20_01_e0;
lambda0 = 20;
lambda1 = 20.01;

% advance paramter to do ALC (s in this case)
delta_s = (norm(U1 - U0, 2) + norm(lambda1 - lambda0, 2))^0.5;

Unorms = [U0 U1];
lambdas = [lambda0 lambda1];
dR_dS = zeros(M + 1, 1);
dR_dS(M + 1) = 2 * delta_s;
while lambda1 < 60
    % use ALC to calculate initial guess
    dR_dU = A + diag(next_lambda * (1 + 2 * U));
    dR_dLambda = U .* (1 + U);
    dEta_dU = -2 * (U1 - U0);
    dEta_dLambda = -2 * (lambda1 - lambda0);
    J = zeros(M + 1, M + 1);
    J(1:M, 1:M) = dR_dU;
    J(1:M, M + 1) = dR_dLambda;
    J(M + 1, 1:M) = dEta_dU;
    J(M + 1, M + 1) = dEta_dLambda;
    
    dU_dLambda_dS = -J \ dR_dS;
    dU_dS = dU_dLambda_dS(M, 1);
    dLambda_dS = dU_dLambda_dS(1, 1);
    U20 = U1 + delta_s * dU_dS;
    lambda20 = lambda1 + delta_s * dLambda_dS;
    
    % use Newton
    U = newton_solve(A, next_lambda, epsilon, U0);
    Unorms = [Unorms norm(U, 2)];
    plot_solution(U, x, y, N);
    pause(0.1);
end

plot(lambdas, Unorms, 'rx');
