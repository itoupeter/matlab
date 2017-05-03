load a.mat;

plot((0:20) / 20, c_20);

title('Solution of C with FDM (N=100)');
xlabel('x');
ylabel('c');
legend('v=1, D=1, k=1');
