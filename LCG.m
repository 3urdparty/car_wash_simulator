
function [random_numbers]= LCG( m, a, c, n)
  % Linear Congruential Generator
  % seed: initial seed value
  % m: modulus
  % a: multiplier
  % c: increment
  % n: number of random numbers to generate
  
  % Initialize the random numbers array
  random_numbers = zeros(1, n);
  
  % Initialize the seed
  seed = randi([1, 100]);
  
  % Generate n random numbers
  for i = 1:n
    % Generate the next random number
    x = mod(a*seed + c, m);
    
    % Store the random number
    random_numbers(i) = x;
  end
end
