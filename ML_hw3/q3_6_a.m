
load('hw3_data/data.mat');

w = [0.8891; -0.8260; 4.1902];
error = Y - X * w;
result = sum(w .* w, 1) / sum(error .* error, 1);

result
