function [washbays] = generate_washbays(count)
  washbays = zeros(3, 2, count);
  for i = 1:count
    washbays(:,:,i) = [
    10, 0.4 ;
    15, 0.3 ;
    20, 0.3
    ];
  end

  for i = 1:count
    for j = 1:3
      washbays(j,3,i) = sum(washbays(1:j,2,i)); 
      if j > 1
        washbays(j,4,i) = washbays(j-1,5,i) + 1;
        washbays(j,5,i) = washbays(j,4,i) + 100*washbays(j,2,i) - 1;
      else
        washbays(j,4,i) = 1;
        washbays(j,5,i) = 100*washbays(j,2,i);
      end
    end
  end
  return;
end
