function [cost] = q3func3(w, X, Y)

Y_hat = X * w;
error = Y - Y_hat;
error = sum(error .* error, 1);

penalty = sum(abs(w), 1);

cost = error + penalty;
