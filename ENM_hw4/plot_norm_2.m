load data.mat;

plot(Unorms4_x, Unorms4_y, 'rx'); % branch 1
hold on;
plot(Unorms6_x, Unorms6_y, 'bx'); % branch 2 hill

plot(Unorms5_x, Unorms5_y, 'rx'); % branch 1
plot(Unorms7_x, Unorms7_y, 'bx'); % branch 2 hill
plot(Unorms8_x, Unorms8_y, 'bx'); % branch 2 bowl
plot(Unorms9_x, Unorms9_y, 'bx'); % branch 2 bowl

title('Norm of Solution v.s. Lambda (Epsilon = 2)');
legend('branch 1', 'branch 2', 'location', 'northwest');
xlabel('lambda');
ylabel('norm');
hold off;