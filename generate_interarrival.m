function [interarrival ] = generate_interarrival(count=3)
  % for i = 1:count
  %   interarrival(i,1) = i;
  %   interarrival(i,2) = 0;
  %   interarrival(i,3) = 0;
  %   interarrival(i,4) = 0;
  %   interarrival(i,5) = 0;
  % end
  interarrival = [
    2 0.3 0 0 0;
    3 0.4 0 0 0;
    4 0.3 0 0 0;
    ];

  for i = 1:count
    interarrival(i,3) = sum(interarrival(1:i,2)); 
    if i > 1
      interarrival(i,4) = interarrival(i-1,5) + 1;
      interarrival(i,5) = interarrival(i,4) + 100*interarrival(i,2) - 1;
    else
      interarrival(i,4) = 1;
      interarrival(i,5) = 100*interarrival(i,2);
    end
  end
end
