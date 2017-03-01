
hold on;

load ground.mat err_direct_10 err_direct_20 err_direct_30 err_direct_50;
y1 = [err_direct_10 err_direct_20 err_direct_30 err_direct_50];
plot(y1);

load ground.mat err_jacobi_10 err_jacobi_20 err_jacobi_30 err_jacobi_50;
y2 = [err_jacobi_10 err_jacobi_20 err_jacobi_30 err_jacobi_50];
plot(y2);

load ground.mat err_gs_10 err_gs_20 err_gs_30 err_gs_50;
y3 = [err_gs_10 err_gs_20 err_gs_30 err_gs_50];
plot(y3);

x = {'10x10', '20x20', '30x30', '50x50'};
set(gca, 'xtick', 1:4, 'xticklabel', x);
title('L2 Error v.s. Grid Resolution');
legend('Direct', 'Jacobi', 'Gauss-Seidel');
xlabel('Grid Resolution');
ylabel('Error');

hold off;
