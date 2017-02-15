digits(16);
A = hilb(8);
b = rand(8, 1);
x = A \ b;

r = b - A * x;
z = A \ r;
x = x + z;
A * x - b
