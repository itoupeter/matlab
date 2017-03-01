
load ground.mat time_direct time_jacobi time_gs;

ns = 10 : 10 : 1000;

loglog(ns, time_direct);
hold on;
loglog(ns, time_jacobi);
loglog(ns, time_gs);

x = ns(:, 30:end);
y_direct = time_direct(:, 30:end);
y_jacobi = time_jacobi(:, 30:end);
y_gs = time_gs(:, 30:end);

P1 = polyfit(log(x), log(y_direct), 1);
P2 = polyfit(log(x), log(y_jacobi), 1);
P3 = polyfit(log(x), log(y_gs), 1);

fit_direct = P1(1) * x + P1(2);
fit_jacobi = P2(1) * x + P2(2);
fit_gs = P3(1) * x + P3(2);

loglog(x, fit_direct);
loglog(x, fit_jacobi);
loglog(x, fit_gs);

hold off;