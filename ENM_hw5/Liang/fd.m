% finite difference method

% define grid
N = 100;
x = (0:N) / N;
h = 1 / N;

% velocity, diffusivity, reaction
v = 1;
D = 1;
k = 1;

% set up equations
A = zeros(N + 1, N + 1);
c = ones(N + 1, 1);
delta_c = ones(N + 1, 1);

for i = 2 : N
    A(i, i + 1) = v / 2 / h - D / h / h;
    A(i, i - 1) = -(v / 2 / h + D / h / h);
    A(i, i) = 2 * D / h / h;
end

% Neumann BC
A(N + 1, N) = -2 * D / h / h;
A(N + 1, N + 1) = 2 * D / h / h;

num_ites = 0;

while norm(delta_c, 1) > 1e-6
    num_ites = num_ites + 1;
    
    % Jacobian and Residual
    R = A * c + k * c .* c;
    J = A + diag(2 * k * c);
    
    % fixed BC
    J(1, 1) = 1;
    R(1) = c(1) - 1;
    
    % update c
    delta_c = -J \ R;
    c = c + delta_c;
    
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

plot(x, c);