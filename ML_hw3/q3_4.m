
load('hw3_data/data.mat');

options = optimset('PlotFcns', @optimplotfval);
x0 = [0; 0; 0];
x_used = [1; 2; 3];
[x, fval] = fminsearch(@q3func4, x0, options, x_used, X, Y);

if ~exist('x_all')
	fval_all = [];
end

fval_all = [fval_all, fval];
