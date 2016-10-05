function [cost] = q3func2(w, X, Y)

Y_hat = X * w;
error = Y - Y_hat;
error = sum(error .* error, 1);

penalty = sum(w .* w, 1);

cost = error + penalty;
