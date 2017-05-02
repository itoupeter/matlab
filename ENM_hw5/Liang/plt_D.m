load D.mat;

x = (0:20) / 20;

plot(x, D02); hold on
plot(x, D05);
plot(x, D1);
plot(x, D2);
plot(x, D4);

title('Solution of c with Varying D (Nel=20)');
xlabel('x');
ylabel('c');
legend('D=0.2', 'D=0.5', 'D=1', 'D=2', 'D=4');

hold off;