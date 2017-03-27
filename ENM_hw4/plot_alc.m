load e.mat;

plot(norm_b1_hill(1, :), norm_b1_hill(2, :), 'rx'); % branch 1 hill
hold on;
plot(norm_b2_hill(1, :), norm_b2_hill(2, :), 'bx'); % branch 2 hill
plot(norm_b1_bowl(1, :), -norm_b1_bowl(2, :), 'rx'); % branch 1 bowl
plot(norm_b2_bowl(1, :), -norm_b2_bowl(2, :), 'bx'); % branch 2 bowl

plot(b1_hill(1, :), b1_hill(2, :), 'g.');
plot(b1_bowl(1, :), -b1_bowl(2, :), 'g.');
plot(b2_hill(1, :), b2_hill(2, :), 'g.');
plot(b2_bowl(1, :), -b2_bowl(2, :), 'g.');

title('L2 Norm of Solution v.s. Lambda (By ALC)');
legend('branch 1', 'branch 2', 'location', 'northeast');
xlabel('Lambda');
ylabel('L2 Norm');
hold off;

xlim([0 60]);
ylim([-20 20]);