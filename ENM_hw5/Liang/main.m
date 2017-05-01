
% define element 
N = 30;
x = (0 : N) / N;
h = 1 / N;

% convection-diffusion reaction parameters
v = 1;
D = 1;
k = 1;

% integration terms
A = {@(x) v * -0.25 * (1 - x), @(x) v * 0.25 * (1 - x);
    @(x) v * -0.25 * (1 + x), @(x) v * 0.25 * (1 + x)};

B = {@(x) D * 0.5 / h, @(x) D * -0.5 / h;
    @(x) D * -0.5 / h, @(x) D * 0.5 / h};

C = {@(x) k * (1 - x)^3 * 0.5 / h, ...
    @(x) k * (1 - x) * (1 + x)^2 * 0.5 / h;
    @(x) k * (1 - x)^2 * (1 + x) * 0.5 / h, ...
    @(x) k * (1 + x)^3 * 0.5 / h};

D = {@(x) k * (1 - x)^2 * (1 + x) * 0.25 / h, ...
    @(x) k * (1 - x)^2 * (1 + x) * 0.25 / h;
    @(x) k * (1 - x) * (1 + x)^2 * 0.25 / h, ...
    @(x) k * (1 - x) * (1 + x)^2 * 0.25 / h};

% equation
J = zeros(N, N);
c = ones(N, 1) * 0.5;
R = zeros(N, 1);

for e = 1 : N
    % local-to-global index mapping
    idx_global = @(x) x + e - 2;
    
    J_tmp = zeros(2, 2);
    R_tmp = zeros(2, 1);
    
    for i = 1 : 2
        for j = 1 : 2
            j_global = idx_global(j);
            m_global = idx_global(3 - j);
            
            if j_global == 0
                cj = 1;
            else
                cj = c(j_global);
            end
            
            if m_global == 0
                cm = 1;
            else
                cm = c(m_global);
            end
            
            J_tmp(i, j) = gqi(A{i, j}) + gqi(B{i, j}) ...
                + cj * gqi(C{i, j})...
                + cm * gqi(D{i, j});
        end
    end
    
    J(e:e + 1, e:e + 1) = J_tmp;
    
    for i = 1 : 2
        
    end
end
