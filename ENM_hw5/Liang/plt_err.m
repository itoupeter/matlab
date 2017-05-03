load a.mat;

err = [];

N = 5;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c5 - c_bar, 1) / 6];

N = 10;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c10 - c_bar, 1) / 11];

N = 20;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c20 - c_bar, 1) / 21];

N = 40;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c40 - c_bar, 1) / 41];

N = 50;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c50 - c_bar, 1) / 51];

N = 100;
step = 200 / N;
idx = 1 : step : 201;
c_bar = c200(idx);
err = [err norm(c100 - c_bar, 1) / 101];

n = [5, 10, 20, 40, 50, 100];
loglog(n, err); hold on;

P = polyfit(log(n), log(err), 1);
fit_err = P(1) * log(n) + P(2);
loglog(n, exp(fit_err)); hold off;

title('Error v.s. Nel')
xlabel('# of Elements')
ylabel('Error')
legend('error', 'linear fit')
