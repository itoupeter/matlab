
load('hw3_data/data.mat');

options = optimset('PlotFcns', @optimplotfval);
x0 = [0; 0; 0];
x = fminsearch(@q3func2, x0, options, X, Y);

x
