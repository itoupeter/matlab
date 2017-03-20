load data.mat;

plot(Unorms4_x, Unorms4_y, 'rx');
hold on;
plot(Unorms5_x, Unorms5_y, 'Rx');
title('Norm of Solution v.s. Lambda (Epsilon = 2)');
legend('branch 1', 'branch 2', 'location', 'northwest');
xlabel('lambda');
ylabel('norm');
hold off;