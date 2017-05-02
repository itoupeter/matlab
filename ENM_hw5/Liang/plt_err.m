load a.mat;

err = [];

N = 5;
step = 100 / N;
x = (1:N) / N;
idx = 1 : step : 101;
c_bar = c100(idx);
err = [err norm(c5 - c_bar, 2) / 6];

N = 10;
step = 100 / N;
x = (1:N) / N;
idx = 1 : step : 101;
c_bar = c100(idx);
err = [err norm(c10 - c_bar, 2) / 11];

N = 20;
step = 100 / N;
x = (1:N) / N;
idx = 1 : step : 101;
c_bar = c100(idx);
err = [err norm(c20 - c_bar, 2) / 21];

N = 50;
step = 100 / N;
x = (1:N) / N;
idx = 1 : step : 101;
c_bar = c100(idx);
err = [err norm(c50 - c_bar, 2) / 51];

n = [5, 10, 20, 50];
loglog(n, err); hold on;

P = polyfit(log(n), log(err), 1);
fit_err = P(1) * log(n) + P(2);
loglog(n, exp(fit_err)); hold off;

title('Error v.s. Nel')
xlabel('# of Elements')
ylabel('Error')
legend('error', 'linear fit')
