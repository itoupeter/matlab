%% Script/instructions on how to submit plots/answers for question 2.
% Put your textual answers where specified in this script and run it before
% submitting.

% Loading the data: this loads X, Xnoisy, and Y.
load('../data/breast-cancer-data-fixed.mat');

%% 2.1
answers{1} = 'As number of fold increases, n-fold error goes down and at some point goes up. Since cross validation is only relevant to training set, test error is independent on # of fold.';

% Plotting with error bars: first, arrange your data in a matrix as
% follows:
%
%  nfold_errs(i,j) = nfold error with n=j of i'th repeat
%
% Then we want to plot the mean with error bars of standard deviation as
% folows: y = mean(nfold_errs), e = std(nfold_errs), x = [2 4 8 16].
%
% >> errorbar(x, y, e);
%
% Along with nfold_errs, also plot errorbar for test error. This will
% serve as measure of performance for different nfold-crossvalidation.
%
% To add labels to the graph, use xlabel('X axis label') and ylabel
% commands. To add a title, using the title('My title') command.
% See the class Matlab tutorial wiki for more plotting help.
%
% Once your plot is ready, save your plot to a jpg by selecting the figure
% window and running the command:
%
% >> print -djpg plot_2.1-noisy.jpg % (for noisy version of data)
% >> print -djpg plot_2.1.jpg  % (for regular version of data)
%
% YOU MUST SAVE YOUR PLOTS TO THESE EXACT FILES.
% K-NN error on standard data
FULL_SET_SIZE = size(X, 1);
TRAIN_SET_SIZE = 400;
TEST_SET_SIZE = FULL_SET_SIZE - TRAIN_SET_SIZE;

x = [2, 4, 8, 16];
xLength = length(x);
nfold_errs = zeros(100, xLength);
test_errs = zeros(100, xLength);

for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	for j = 1 : xLength
		trainPoints = X(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		part = make_xval_partition(TRAIN_SET_SIZE, x(j));
		nfold_errs(i, j) = knn_xval_error(1, trainPoints, trainLabels, part, 'l2');

		testLabels = knn_test(1, trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(1);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('N-Fold and Test Error on Original Data');
xlabel('# of Folds');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

% K-NN error on noisy data
FULL_SET_SIZE = size(X_noisy, 1);
TRAIN_SET_SIZE = 400;
TEST_SET_SIZE = FULL_SET_SIZE - TRAIN_SET_SIZE;

x = [2, 4, 8, 16];
xLength = length(x);
nfold_errs = zeros(100, xLength);
test_errs = zeros(100, xLength);

for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	for j = 1 : xLength
		trainPoints = X_noisy(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X_noisy(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		part = make_xval_partition(TRAIN_SET_SIZE, x(j));
		nfold_errs(i, j) = knn_xval_error(1, trainPoints, trainLabels, part, 'l2');

		testLabels = knn_test(1, trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(2);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('N-Fold and Test Error on Noisy Data');
xlabel('# of Folds');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

%% 2.2
answers{2} = 'Best sigma and K are 13 and 7.';

% Save your plots as follows:
%
%  noisy data, k-nn error vs. K --> plot_2.2-k-noisy.jpg
%  noisy data, kernreg error vs. sigma --> plot_2.2-sigma-noisy.jpg
%  regular data, k-nn error vs. K --> plot_2.2-k.jpg
%  regular data, kernreg error vs. sigma --> plot_2.2-sigma.jpg
x = [1, 2, 3, 5, 8, 13, 21, 34];
xLength = length(x);
nfold_errs = zeros(100, xLength);
test_errs = zeros(100, xLength);

% K-NN error on standard data
for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	part = make_xval_partition(TRAIN_SET_SIZE, 10);
	for j = 1 : xLength
		trainPoints = X(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		nfold_errs(i, j) = knn_xval_error(x(j), trainPoints, trainLabels, part, 'l2');

		testLabels = knn_test(x(j), trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(3);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('K-NN N-Fold Error and Test Error on Original Data');
xlabel('K (# of Folds)');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

% K-NN error on noisy data
for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	part = make_xval_partition(TRAIN_SET_SIZE, 10);
	for j = 1 : xLength
		trainPoints = X_noisy(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X_noisy(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		nfold_errs(i, j) = knn_xval_error(x(j), trainPoints, trainLabels, part, 'l2');

		testLabels = knn_test(x(j), trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(4);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('K-NN N-Fold Error and Test Error on Noisy Data');
xlabel('K (# of Folds)');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

% Kernreg error on standard data
x = 1 : 12;
xLength = length(x);
nfold_errs = zeros(100, xLength);
test_errs = zeros(100, xLength);

for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	part = make_xval_partition(TRAIN_SET_SIZE, 10);
	for j = 1 : xLength
		trainPoints = X(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		nfold_errs(i, j) = kernreg_xval_error(x(j), trainPoints, trainLabels, part, 'l2');

		testLabels = kernreg_test(x(j), trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(5);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('Kernreg N-Fold Error and Test Error on Standard Data');
xlabel('Sigma (Kernel Width)');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

% Kernreg error on standard data
for i = 1 : 100
	trainPointsIndices = randperm(FULL_SET_SIZE, TRAIN_SET_SIZE);
	testPointsIndices = setdiff(1 : FULL_SET_SIZE, trainPointsIndices);
	part = make_xval_partition(TRAIN_SET_SIZE, 10);
	for j = 1 : xLength
		trainPoints = X_noisy(trainPointsIndices, :);
		trainLabels = Y(trainPointsIndices, :);

		testPoints = X_noisy(testPointsIndices, :);
		testLabelsGiven = Y(testPointsIndices, :);

		nfold_errs(i, j) = kernreg_xval_error(x(j), trainPoints, trainLabels, part, 'l2');

		testLabels = kernreg_test(x(j), trainPoints, trainLabels, testPoints, 'l2');
		test_errs(i, j) = sum(testLabels ~= testLabelsGiven) ./ TEST_SET_SIZE;
	end
end

y1 = mean(nfold_errs);
e1 = std(nfold_errs);
y2 = mean(test_errs);
e2 = std(test_errs);

figure(6);
errorbar(x, y1, e1);
hold on;
errorbar(x, y2, e2);
title('Kernreg N-Fold Error and Test Error on Noisy Data');
xlabel('Sigma (Kernel Width)');
ylabel('Error');
legend('N-Fold Error', 'Test Error');
hold off;

%% Finishing up - make sure to run this before you submit.
save('problem_2_answers.mat', 'answers');
