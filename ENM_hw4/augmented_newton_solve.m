function [U] = augmented_newton_solve(A, J, lambda, epsilon, U0, sinpix)
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
    
    dU_dLambda = -J \ r;
    dU = dU_dLambda(1:n - 1, 1);
    dLambda = dU_dLambda(n
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
