function [random_numbers] = LCG(seed, a, c, m, n)
% LCG: Linear Congruential Generator
% Inputs:
%   seed: Initial seed value (integer)
%   a, c, m: Parameters for the LCG (integers)
%   n: Number of random numbers to generate
% Outputs:
%   random_numbers: Vector of n random numbers between 0 and 1

% Initialize variables
random_numbers = zeros(1, n);
x = seed;

% Generate n random numbers
for i = 1:n
    x = mod(a * x + c, m);
    random_numbers(i) = x / m;
end

end
