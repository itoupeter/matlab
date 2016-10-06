function [cost] = q3func2(w, X, Y, lambda)

Y_hat = X * w;
error = Y - Y_hat;
error = sum(error.^2, 1);

penalty = sum(w.^2, 1);

if ~exist('lambda')
	lambda = 1;
end

cost = error + lambda * penalty;
