
% define element 
N = 100;
x = (0 : N)' / N;
h = 1 / N;

% convection-diffusion reaction parameters
v = 1;
D = 1;
k = 1;

% integration terms
A = {@(x) v * -0.25 * (1 - x) + D * 0.5 / h, ...
    @(x) v * 0.25 * (1 - x) + D * -0.5 / h;
    @(x) v * -0.25 * (1 + x) + D * -0.5 / h, ...
    @(x) v * 0.25 * (1 + x) + D * 0.5 / h};

B = {@(x) k * (1 - x)^3 / 16 * h, ...
    @(x) k * (1 - x) * (1 + x)^2 / 16 * h;
    @(x) k * (1 - x)^2 * (1 + x) / 16 * h, ...
    @(x) k * (1 + x)^3 / 16 * h};

C = {@(x) k * (1 - x)^2 * (1 + x) / 16 * h, ...
    @(x) k * (1 - x)^2 * (1 + x) / 16 * h;
    @(x) k * (1 - x) * (1 + x)^2 / 16 * h, ...
    @(x) k * (1 - x) * (1 + x)^2 / 16 * h};

AA = zeros(2, 2);
BB = zeros(2, 2);
CC = zeros(2, 2);

for i = 1 : 2
    for j = 1 : 2
        AA(i, j) = gqi(A{i, j});
        BB(i, j) = gqi(B{i, j});
        CC(i, j) = gqi(C{i, j});
    end
end

% equation
J = zeros(N + 1, N + 1);
c = ones(N + 1, 1) * 0.5;
R = zeros(N + 1, 1);

delta_c = ones(N, 1);
num_ites = 0;

while norm(delta_c, 1) > 1e-4
    num_ites = num_ites + 1;
    
    % J, R
    for e = 1 : N
        % local-to-global index mapping
        idx_global = @(x) x + e - 1;

        % construct J and R locally
        J_tmp = zeros(2, 2);
        R_tmp = zeros(2, 1);

        for i = 1 : 2
            for j = 1 : 2
                j_global = idx_global(j);
                m_global = idx_global(3 - j);

                J_tmp(i, j) = AA(i, j) ...
                    + 2 * c(j_global) * BB(i, j) ...
                    + c(m_global) * CC(i, j);

                R_tmp(i) = R_tmp(i) + c(j_global) * AA(i, j) ...
                    + c(j_global)^2 * BB(i, j) ...
                    + c(j_global) * c(m_global) * CC(i, j);
            end
        end

        % construct global J and R
        J(e:e + 1, e:e + 1) = J(e:e + 1, e:e + 1) + J_tmp;
        R(e:e + 1, :) = R(e:e + 1, :) + R_tmp;
    end
    
    % impose Dirichlet boundary condition
    J(1, 1:2) = [1, 0];
    R(1) = c(1) - 1;
    
    delta_c = -J \ R;
    c = c + delta_c;
%     plot(x, c);
%     pause(0.2);
    
    if norm(c, 1) > 1e10
        c = c * 0;
        break;
    end
end

if norm(c, 1) == 0
    disp('Diverged.')
else
    disp(['Converged. #iterations: ', num2str(num_ites)]);
end