%% Plots/submission for SVM portion, Question 1.

%% Put your written answers here.
clear all
answers{1} = 'Answer to 1.3';

save('problem_1_answers.mat', 'answers');

%% Load and process the data.

load ../data/windows_vs_mac.mat;
[X Y] = make_sparse(traindata, vocab);
[Xtest Ytest] = make_sparse(testdata, vocab);

%% Bar Plot - comparing error rates of different kernels

% INSTRUCTIONS: Use the KERNEL_LIBSVM function to evaluate each of the
% kernels you mentioned. Then run the line below to save the results to a
% .mat file.

results.linear = % ERROR RATE OF LINEAR KERNEL GOES HERE
results.quadratic = % ERROR RATE OF QUADRATIC KERNEL GOES HERE
results.cubic = % ERROR RATE OF CUBIC KERNEL GOES HERE
results.gaussian = % ERROR RATE OF GAUSSIAN (SIGMA=20) GOES HERE
results.intersect = % ERROR RATE OF INTERSECTION KERNEL GOES HERE

% Makes a bar chart showing the errors of the different algorithms.
algs = fieldnames(results);
for i = 1:numel(algs)
    y(i) = results.(algs{i});
end
bar(y);
set(gca,'XTickLabel', algs);
xlabel('Kernel');
ylabel('Test Error');
title('Kernel Comparisons');

print -djpeg -r72 plot_1.jpg;
