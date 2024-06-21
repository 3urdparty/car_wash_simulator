
function main()
  % Get customer count from user 
  customer_count = input('Enter the number of customers(>2): ');
  if customer_count < 2
    disp('Invalid customer count. Please enter a number greater than 2.');
    return;
  end
  % Get washbay count from user
  washbay_count = input('Enter the number of washbays(<5): ');

  if washbay_count > 5 || washbay_count < 1
    disp('Invalid washbay count. Please enter a number between 1 and 5.');
    return;
  end
  % Get method from user
  disp('Enter the method to generate random numbers:');
  disp('1. LCG (Linear Congruential Generator)');
  disp('2. uniform (Uniform Distribution)');
  disp('3. randi (Inbuilt Random Integer Generation Function)');

  method = input('Enter the method to generate random numbers: ', 's');


  if strcmp(method, 'LCG') == 0 && strcmp(method, 'uniform') == 0 && strcmp(method, 'randi') == 0
    disp('Invalid method. Please enter a valid method.');
    return;
  end

  simulate( washbay_count, customer_count, method);
end
