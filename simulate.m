function simulate(washbay_count=3, customer_count=10)
  % Define the service times and probabilities for wash bays
  washbays = generate_washbays(washbay_count)
  interarrival = generate_interarrival()
  customers = generate_customers(customer_count )
  
  simulation = zeros(customer_count, 5 + washbay_count*5);

  t=0;
  for i = 1:customer_count
    simulation(i,1) = customers(i,1); % Customer Number
    simulation(i,2) = customers(i,2); % Random Number for Interarrival
    simulation(i,3) = get_value(customers(i,2), interarrival(:,[1,4,5])); % Interarrival Time
    simulation(i,4) = t; % Arrival Time
    t = t + simulation(i,3); % Arrival Time
    simulation(i,5) = randi([1,100]); % Random Number for Service Time
    simulation(i,6) = randi([1, washbay_count])


    washbay_idx=simulation(i,6);
    duration = get_value(simulation(i,5), washbays(:,[1,4,5],washbay_idx));
    if i == 1
      simulation(i,(washbay_idx-1)*5+7) = simulation(i,4); % Start Time
    else
      simulation(i,(washbay_idx-1)*5+7) = max( simulation(i,4), max(simulation(:, (washbay_idx-1)*5+8))); % Start Time
    end
    simulation(i,(washbay_idx-1)*5+8) = simulation(i,(washbay_idx-1)*5+7) + duration;
    simulation(i,(washbay_idx-1)*5+9) = duration; % Service Time
    simulation(i,(washbay_idx-1)*5+10) = simulation(i,(washbay_idx-1)*5+7) - simulation(i,4); % System Time
    simulation(i,(washbay_idx-1)*5+11) = max(0, simulation(i,(washbay_idx-1)*5+7) - simulation(i,4)); % Queue Time
  end


  printf('\nInterarrival Times:\n');
  print_table(interarrival);

  printf('\nWash Bay %2d:\n', i);
  for i = 1:washbay_count
    printf('\nWash Bay %2d:\n', i);
    print_table(washbays(:,:,i));
  end
  printf('\nSimulation:\n');
  printf('                                                          ')
  for i = 1:washbay_count
    printf('| Washbay %2d                       ', i);
  end
  fmtStr = '|%2d |  %8d|  %10d|  %5d| %9d| %9d|';
  carwashFmtStr = '|%2s | %8s | %10s | %5s | %10';
  printf('\n|No.|Rn Arrival|Interarrival|Arrival|Rn Service|Rn Washbay|');
  for i = 1:washbay_count
    printf('Start| End |Service |System|Queue |');
  end
  printf('|\n')
  for i = 1:customer_count
    printf(fmtStr, simulation(i, 1:6));
    for j = 1:washbay_count
      values = simulation(i, (j-1)*5+7:(j-1)*5+10);
      printf('%4d | %4d| %6d | %5d |', simulation(i, (j-1)*5+ 7:(j-1)*5+11));
    end
    printf('\n')
  end
  printf('\n');
end
