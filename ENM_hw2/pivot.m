function [B] = pivot(A, k)
% Function that performs pivoting on square matrix A for the kth column.

% Partial Pivoting
% Select maximal element below A(k, k) and swap that row with kth row

if ~exist('k')
    k = 1;
end

B = A;

% Select maximal element below A(k, k)
[maxn, maxi] = max(abs(B(k:end, k)));

% swap rows
if maxi ~= 1
    tmp = B(k, :);
    B(k, :) = B(k + maxi - 1, :);
    B(k + maxi - 1, :) = tmp;
end
