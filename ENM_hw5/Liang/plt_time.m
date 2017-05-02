
% a = rand(100, 100) * rand(100, 100);
% 
% t = 0;
% 
% for i = 1 : 5
%     tic;
%     main;
%     t = t + toc;
% end
% 
% t50 = t / 5;
% save t.mat t50 -append;
% figure(1);

load t.mat

n = [5, 10, 20, 30, 50];
t = [t5, t10, t20, t30, t50];

loglog(n, t); hold on;

P = polyfit(log(n), log(t), 1);
t_fit = P(1) * log(n) + P(2);

loglog(n, exp(t_fit)); hold off;

title('Time v.s. Nel');
xlabel('# of Elements');
ylabel('Time');
legend('time', 'linear fit');
