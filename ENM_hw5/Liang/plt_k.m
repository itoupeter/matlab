load k.mat;

x = (0:20) / 20;

plot(x, k01); hold on
plot(x, k05);
plot(x, k1);
plot(x, k2);
plot(x, k4);

title('Solution of c with Varying k (Nel=20)');
xlabel('x');
ylabel('c');
legend('k=0.1', 'k=0.5', 'k=1', 'k=2', 'k=4');

hold off;