function [cost] = q3func2(w, w_used, X, Y)

w_used_num = numel(w_used);
w_all = zeros(3, 1);
w_all(w_used) = w;
Y_hat = X * w_all;
error = Y - Y_hat;
error = sum(error .* error, 1);

penalty = w_used_num;

cost = error + penalty;
