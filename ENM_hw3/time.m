
rand(100) \ rand(100, 1);

ns = 10 : 10 : 1000;
t = [];

for n = ns
	A = rand(n) + eye(n) * (n + 1);
	b = rand(n, 1);

	tic;

	%direct_solve(A, b);
    %jacobi_solve(A, b);
    gs_solve(A, b);

	t = [t toc];
end
