function [error] = kernreg_xval_error(sigma, X, Y, part, distFunc)
% KERNREG_XVAL_ERROR - Kernel regression cross-validation error.
%
% Usage:
%
%   ERROR = kernreg_xval_error(SIGMA, X, Y, PART, DISTFUNC)
%
% Returns the average N-fold cross validation error of the kernel regression
% algorithm on the given dataset when the dataset is partitioned according to PART
% (see MAKE_XVAL_PARTITION). DISTFUNC is the distance functioned
% to be used (see KERNREG_TEST).
%
% Note that N = max(PART).
%
% SEE ALSO
%   MAKE_XVAL_PARTITION, KERNREG_TEST

% FILL IN YOUR CODE HERE
N = max(part);
error = zeros(1, N);

for i = 1 : N
	% generate indices for train and test points
	trainPointsIndices = find(part ~= i);
	testPointsIndices = find(part == i);

	% pick train points from whole point set
	trainPoints = X(trainPointsIndices, :);
	trainLabels = Y(trainPointsIndices, :);

	% pick test points from whole point set
	testPoints = X(testPointsIndices, :);
	testLabelsGiven = Y(testPointsIndices, :);

	% do kernreg
	testLabels = sign(kernreg_test(sigma, trainPoints, trainLabels, testPoints, distFunc));

	% calculate error
	error(i) = sum(testLabels ~= testLabelsGiven) ./ size(testPoints, 1);
end

error = mean(error);
