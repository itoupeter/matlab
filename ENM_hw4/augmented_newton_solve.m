function [U, lambda] = augmented_newton_solve(A, J, epsilon, sinpix, delta_s, U1, U2, lambda1, lambda2)
% function: solve for U and lambda given intial guess.

M = size(J, 1);
U = U2;
lambda = lambda2;
ite = 0;
tol = 1e-10;

while 1
    % non-linear
    r = A * U2 + lambda2 * (U2 .* (1 + U2)) - epsilon * sinpix;
    eta = delta_s^2 - norm(U2 - U1, 2) - (lambda2 - lambda1)^2;
    R = [r; eta];
    
    dU_dLambda = -J \ R;
    dU = dU_dLambda(1:M - 1, 1);
    dLambda = dU_dLambda(M, 1);
    U = U2 + dU;
    lambda = lambda2 + dLambda;

    if norm(dU, 1) + norm(dLambda, 1) < tol
        break;
    elseif norm(U) > 1e10 || abs(lambda) > 1e10
        disp('Diverges.');
        U = zeros(M - 1, 1);
        lambda = 0;
        return;
    else
        U2 = U;
        lambda2 = lambda;
    end

    ite = ite + 1;
end

disp(['# of iterations: ', num2str(ite)]);

end
