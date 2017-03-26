load a.mat;

plot(norm_b1_hill_x, norm_b1_hill_y, 'r.'); % branch 1 hill
hold on;
plot(norm_b2_hill_x, norm_b2_hill_y, 'b.'); % branch 2 hill
plot(norm_b1_bowl_x, -norm_b1_bowl_y, 'r.'); % branch 1 bowl
plot(norm_b2_bowl_x, -norm_b2_bowl_y, 'b.'); % branch 2 bowl

load c.mat;
plot(norm_b1_hill_x, norm_b1_hill_y, 'r.'); % branch 1 hill
plot(norm_b2_hill_x, norm_b2_hill_y, 'b.'); % branch 2 hill
plot(norm_b1_bowl_x, -norm_b1_bowl_y, 'r.'); % branch 1 bowl
plot(norm_b2_bowl_x, -norm_b2_bowl_y, 'b.'); % branch 2 bowl

load d.mat;
plot(norm_b1_hill_x, norm_b1_hill_y, 'ro'); % branch 1 hill
plot(norm_b2_hill_x, norm_b2_hill_y, 'bo'); % branch 2 hill
plot(norm_b1_bowl_x, -norm_b1_bowl_y, 'ro'); % branch 1 bowl
plot(norm_b2_bowl_x, -norm_b2_bowl_y, 'bo'); % branch 2 bowl

title('Norm of Solution v.s. Lambda (Epsilon from 0 to 2)');
legend('thin: epsilon fixed', 'bold: epsilon transitioning', 'location', 'northeast');
xlabel('Lambda');
ylabel('L2 Norm');
hold off;

xlim([0 60]);
ylim([-20 20]);
