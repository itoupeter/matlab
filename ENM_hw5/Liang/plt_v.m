load v.mat;

x = (0:20) / 20;

plot(x, v01); hold on
plot(x, v05);
plot(x, v1);
plot(x, v2);
plot(x, v4);

title('Solution of c with Varying v (Nel=20)');
xlabel('x');
ylabel('c');
legend('v=0.1', 'v=0.5', 'v=1', 'v=2', 'v=4');

hold off;