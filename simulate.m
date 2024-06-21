function simulate(washbay_count=3, customer_count=10, method='LCG')
  % Define the service times and probabilities for wash bays, and interarrival times, and create customers
  washbays = generate_washbays(washbay_count);
  interarrival = generate_interarrival();
  
  % Create a matrix to store the simulation results
  simulation = zeros(customer_count, 5 + washbay_count*5);

  t = 0; % Initialize the time
  % Initialize the simulation
  simulation(:,5)=generate_random(1,100, customer_count, method); % Random Number for Service Time
  simulation(:,2)=generate_random(1,100, customer_count, method);% Random Number for Interarrival

  for i = 1:customer_count
    simulation(i,1) = i; % Customer Number
    simulation(i,3) = get_value(simulation(i,2), interarrival(:,[1,4,5])); % Interarrival Time
    simulation(i,4) = t; % Arrival Time
    t = t + simulation(i,3); % Arrival Time



    % Assign the customer to a wash bay based on the wash bay with the earliest end time
    for j = 1:washbay_count
      max_end_times(j)= max(simulation(:,[8 + 5*(j-1)])); % we are looking for the earliest end time, by using the max function we can find the earliest end time
    end

    [min_end_time, washbay_idx] = min(max_end_times); % get the wash bay with the earliest end time by its index

    % Assign the customer to the wash bay
    simulation(i,6) = washbay_idx;

    duration = get_value(simulation(i,5), washbays(:,[1,4,5],washbay_idx)); % Service Time


    printf( 'Customer %d arrives at %d and is assigned to Wash Bay %d\n', i, simulation(i,4), washbay_idx);
    printf(' Customer %d departs at %d\n', i, simulation(i,4) + duration);
    % If this is the first iteration, don't look at previous end times
    if i == 1
      simulation(i,(washbay_idx-1)*5+7) = simulation(i,4); % Start Time
    % If its not the first iteration, look at the previous end times
    else
      simulation(i,(washbay_idx-1)*5+7) = max( simulation(i,4), max(simulation(:, (washbay_idx-1)*5+8))); % Start Time
    end
    simulation(i,(washbay_idx-1)*5+8) = simulation(i,(washbay_idx-1)*5+7) + duration; % End Time calculated by adding the start time and the duration
    simulation(i,(washbay_idx-1)*5+9) = duration; % Service Time calculated by the duration
    simulation(i,(washbay_idx-1)*5+10) = simulation(i,(washbay_idx-1)*5+7) - simulation(i,4)  ; % System Time calculated by the start time and the arrival time
    simulation(i,(washbay_idx-1)*5+11) = max(0, simulation(i,(washbay_idx-1)*5+7) - simulation(i,4)); % Queue Time calculated by the start time and the arrival time
    simulation(i,(washbay_idx-1)*5+10) =duration +   simulation(i,(washbay_idx-1)*5+11) ; % System Time calculated by the start time and the arrival time
  end


  % Part of code that prints the simulation results
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
  printf('\n|No.|Rn Arrival|Interarrival|Arrival|Rn Service| Washbay  |');
  for i = 1:washbay_count
    printf('Start| End |Service |System|Queue |');
  end
  printf('\n')
  for i = 1:customer_count
    printf(fmtStr, simulation(i, 1:6));
    for j = 1:washbay_count
      values = simulation(i, (j-1)*5+7:(j-1)*5+10);
      printf('%4d | %4d| %6d | %5d |', simulation(i, (j-1)*5+ 7:(j-1)*5+11));
    end
    printf('\n')
  end
  printf('\n');

  average_system_time = mean(simulation(:,10));
  average_queue_time = mean(simulation(:,11));
  average_duration = mean(simulation(:,9));
  average_arrival = mean(simulation(:,3));
  average_interarrival = mean(interarrival(:,2));
  probabilty_to_wait_in_queue = sum(simulation(:,11) > 0) / customer_count;
  for i = 1:washbay_count
    printf('Wash Bay %d\n===============\n', i);
    printf('Average System Time: %d\n', mean(simulation(:,(i-1)*5+10)));
    printf('Average Queue Time: %d\n', mean(simulation(:,(i-1)*5+11)));
    printf('Average Duration: %d\n\n', mean(simulation(:,(i-1)*5+9)));
  end
  printf('Summary\n===============\n')
  printf('Average System Time: %d\n', average_system_time);
  printf('Average Queue Time: %d\n', average_queue_time);
  printf('Average Duration: %d\n', average_duration);
  printf('Average Arrival Time: %d\n', average_arrival);
  printf('Average Interarrival Time: %d\n', average_interarrival);
  printf('Probability to Wait in Queue: %d\n\n', probabilty_to_wait_in_queue);

end
