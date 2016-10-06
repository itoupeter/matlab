
load('hw3_data/data.mat');

options = optimset('PlotFcns', @optimplotfval);
w0 = [0; 0; 0];
lambda = 8;
w = fminsearch(@q3func2, w0, options, X, Y, lambda);

w_mle = [0.8891; -0.8260; 4.1902];

sum(w.^2) / sum(w_mle.^2)
