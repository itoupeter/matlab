
M = 10;
x = 0 : 1 : M - 1;
x = x ./ (M - 1);
x = repmat(x, M, 1);

y = x';
