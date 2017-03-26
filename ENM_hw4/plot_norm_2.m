load c.mat;

plot(norm_b1_hill_x, norm_b1_hill_y, 'rx'); % branch 1 hill
hold on;
plot(norm_b2_hill_x, norm_b2_hill_y, 'bx'); % branch 2 hill

plot(norm_b1_bowl_x, -norm_b1_bowl_y, 'rx'); % branch 1 bowl
plot(norm_b2_bowl_x, -norm_b2_bowl_y, 'bx'); % branch 2 bowl

title('Norm of Solution v.s. Lambda (Epsilon = 2)');
legend('branch 1', 'branch 2', 'location', 'northeast');
xlabel('Lambda');
ylabel('L2 Norm');
hold off;

xlim([0 60]);
ylim([-20 20]);
