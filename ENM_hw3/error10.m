
% grid_direct;
% grid_gs;
grid_jacobi;
% grid_newton;

step = 100 / (M - 1);
idx = 1 : step : 101;
U_gt = gt(idx, idx);
error = norm(U - U_gt, 'fro') / M^2;
