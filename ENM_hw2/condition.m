
n = 1 : 1 : 100;
len = numel(n);
condition_hilbert = zeros(1, len);
condition_dense_random = zeros(1, len);
condition_banded_random = zeros(1, len);

for i = 1 : len
    A = generate_hilbert(n(i));
    condition_hilbert(i) = cond(A);

    B = generate_dense_random(n(i));
    condition_dense_random(i) = cond(B);

    C = generate_banded_random(n(i));
    condition_banded_random(i) = cond(C);
end

loglog(n, condition_hilbert);
hold on;
loglog(n, condition_dense_random);
loglog(n, condition_banded_random);

legend('Hilbert', 'dense random', 'banded random');
title('Condition Number vs Matrix Size');
xlabel('Size of Matrix');
ylabel('Condition #');
