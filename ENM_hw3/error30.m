
% grid_direct;
% grid_gs;
% grid_jacobi;
% grid_newton;

% U = U_direct_30;
% U = U_jacobi_30;
U = U_gs_30;

U_gt = zeros(31);
step = 1 / 100;

M = 31;
x = 0 : 1 : M - 1;
x = x ./ (M - 1);
x = repmat(x, M, 1);
y = x';

for i = 2 : 30
    for j = 2 : 30
        xx = x(i, j);
        yy = y(i, j);

        ii = ceil(yy / step);
        jj = ceil(xx / step);
        U1 = gt(ii, jj);
        U2 = gt(ii, jj + 1);
        U3 = gt(ii + 1, jj);
        U4 = gt(ii + 1, jj + 1);

        c1 = (xx - (jj - 1) * step) / step;
        c2 = (yy - (ii - 1) * step) / step;
        U0 = (U1 * c1 + U2 * (1 - c1)) * c2 + (U3 * c1 + U4 * (1 - c1)) * (1 - c2);

        U_gt(i, j) = U0;
    end
end

error = norm(U - U_gt, 'fro') / M^2;
