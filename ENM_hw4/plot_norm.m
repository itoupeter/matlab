load a.mat;

plot(norm_b1_hill_x, norm_b1_hill_y, 'rx'); % branch 1 hill
hold on;
plot(norm_b2_hill_x, norm_b2_hill_y, 'bx'); % branch 2 hill
plot(norm_b1_bowl_x, -norm_b1_bowl_y, 'rx'); % branch 1 bowl
plot(norm_b2_bowl_x, -norm_b2_bowl_y, 'bx'); % branch 2 bowl
plot(initial(1, :), initial(2, :), 'g.');
title('L2 Norm of Solution v.s. Lambda');
legend('branch 1', 'branch 2', 'location', 'northeast');
xlabel('Lambda');
ylabel('L2 Norm');
hold off;

xlim([0 60]);
ylim([-20 20]);