function result = uniformDistribution(n,first)
    a = 1;
    b = 100;
    result(1,1) = randi([0,100])/100;
    for(i=2:n)
        result(1,i) = floor(a + b * rand(1));
    end  
    result(1,1) = floor(result(1,1)*100); % normalize the first element so that all numbers are whole
end
