load data.mat;

plot(Unorms1_x, Unorms1_y, 'rx');
hold on;
plot(Unorms2_x, Unorms2_y, 'bx');
plot(Unorms3_x, Unorms3_y, 'bx');
title('Norm of Solution v.s. Lambda');
xlabel('lambda');
ylabel('norm');
hold off;