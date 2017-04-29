function [I] = gqi(f)
% Gauss Quadrature Integration
% compute integration of input function over [-1, 1]

w1 = 5 / 9;
w2 = 8 / 9;
w3 = 5 / 9;

x1 = -0.6^0.5;
x2 = 0;
x3 = 0.6^0.5;

I = w1 * feval(f, x1) + w2 * feval(f, x2) + w3 * feval(f, x3);