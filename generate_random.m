function [random_number] = generate_random(first=0, last=100,n=10, method='LCG')
  switch method
    case 'LCG'
      random_number = LCG( 100, 232, 100, n);
    case 'uniform'

      random_number = uniform(n );
    case 'randi'
      for i = 1:n
        random_number(i) = randi([first, last]);
      end
    otherwise
      disp('Invalid method');
  end
end
