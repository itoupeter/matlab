function [U] = newton_solve(A, lambda, epsilon, U0, sinpix)
% function: solve for U in AU + lambda*U*(1+U)=0 using Newton's method.

n = size(A, 1);
UU = ones(n, 1);
U = zeros(n, 1);
ite = 0;
tol = 1e-8;

if exist('U0', 'var')
    UU = U0;
end

if ~exist('sinpix', 'var')
    sinpix = zeros(n, 1);
end

while 1
    % non-linear
    r = A * UU + lambda * (UU .* (1 + UU)) - epsilon * sinpix;
    J = A + diag(lambda * (1 + 2 * UU));
    
    % linearized
    %r = A * UU + lambda * UU;
    %J = A + lambda * eye(n);
    
    dU = -J \ r;
    U = UU + dU;

    if norm(U - UU, 1) < tol
        break;
    elseif norm(U) > 1e10
        disp('Diverges.');
        U = zeros(n, 1);
        return;
    else
        UU = U;
    end

    ite = ite + 1;
end

disp(['# of iterations: ', num2str(ite)]);

end
