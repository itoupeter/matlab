
load ground.mat time_direct time_jacobi time_gs;

ns = 10 : 10 : 1000;

loglog(ns, time_direct);
hold on;
loglog(ns, time_jacobi);
loglog(ns, time_gs);

start = 40;
x = ns(:, start:end);
y_direct = time_direct(:, start:end);
y_jacobi = time_jacobi(:, start:end);
y_gs = time_gs(:, start:end);

P1 = polyfit(log(x), log(y_direct), 1);
P2 = polyfit(log(x), log(y_jacobi), 1);
P3 = polyfit(log(x), log(y_gs), 1);

fit_direct = P1(1) * log(x) + P1(2);
fit_jacobi = P2(1) * log(x) + P2(2);
fit_gs = P3(1) * log(x) + P3(2);

loglog(x, exp(fit_direct));
loglog(x, exp(fit_jacobi));
loglog(x, exp(fit_gs));

title('Time Scaling');
xlabel('Matrix Size');
ylabel('Time to Solve');
legend('Direct', 'Jacobi', 'Gauss-Seidel', 'Direct Linear Fit', 'Jacobi Linear Fit', 'Gauss-Seidel Linear Fit', 'location', 'northwest');

hold off;