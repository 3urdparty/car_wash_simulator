function [customers] = generate_customers(count=3)
  customers = zeros(count, 3);
  for i = 1:count
    customers(i,1) = i;
    customers(i,2) = randi([1,100]);
    customers(i,3) = randi([1,100]);
  end
  return;
end
