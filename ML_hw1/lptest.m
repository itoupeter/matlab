% draw 2 points
p = [0.1, 0.1; 0.5, 0.1; 0.2, 0.5];

axis equal;
hold on;

plot(p(1, 1), p(1, 2), 'r.', 'MarkerSize', 20);
plot(p(2, 1), p(2, 2), 'g.', 'MarkerSize', 20);
plot(p(3, 1), p(3, 2), 'b.', 'MarkerSize', 20);

% draw N points, color them according to distance to 2 points
N = 30000;
q = rand(N, 2);

for i = 1 : N
    dist1 = linfdist(p(1, :), q(i, :));
    dist2 = linfdist(p(2, :), q(i, :));
    dist3 = linfdist(p(3, :), q(i, :));
    
    if dist1 < dist2 && dist1 < dist3
        plot(q(i, 1), q(i, 2), 'r.', 'MarkerSize', 2);
    elseif dist2 < dist1 && dist2 < dist3
        plot(q(i, 1), q(i, 2), 'g.', 'MarkerSize', 2);
    elseif dist3 < dist1 && dist3 < dist2
        plot(q(i, 1), q(i, 2), 'b.', 'MarkerSize', 2);
    end
end

hold off;
