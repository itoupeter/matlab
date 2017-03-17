function [U] = newton_solve(A, lambda, U0)
% function: solve for U in AU + lambda*U*(1+U)=0 using Newton's method.

n = size(A, 1);
UU = ones(n, 1);
U = zeros(n, 1);
ite = 0;
tol = 1e-14;

if exist('U0', 'var')
    UU = U0;
end

while 1
    r = A * UU + lambda * (UU .* (1 + UU));
    J = A + (1 + 2 * lambda) * diag(UU); 
    dU = -J \ r;
    U = UU + dU;

    if norm(U - UU) < tol
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