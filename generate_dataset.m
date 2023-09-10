function data = generate_dataset(num_nodes, num_packets, filename)
    % num_nodes: Number of nodes in the MANET
    % num_packets: Number of packets to simulate
    % filename: Name of the .mat file to save the dataset

    % Pre-allocate arrays for efficiency
    sources = zeros(1, num_packets);
    destinations = zeros(1, num_packets);
    transmission_times = zeros(1, num_packets);
    transmission_rates = zeros(1, num_packets);
    types = strings(1, num_packets);  % Use strings to store the packet type
    
    % Generate data for each packet
    for i = 1:num_packets
        sources(i) = randi([1 num_nodes]);
        destinations(i) = randi([1 num_nodes]);
        while destinations(i) == sources(i)
            destinations(i) = randi([1 num_nodes]); % Ensure destination is not the same as source
        end
        transmission_times(i) = rand(); % random time between 0 and 1 (for simplicity)
        transmission_rates(i) = randi([1 100]); % random transmission rate
        
        % Simulate malicious behaviour (e.g., Black Hole or Gray Hole attacks)
        attack_prob = rand();
        if attack_prob < 0.1
            types(i) = 'black_hole';
            transmission_rates(i) = 0; % Black Hole drops all packets
        elseif attack_prob < 0.2
            types(i) = 'gray_hole';
            transmission_rates(i) = transmission_rates(i) / 2; % Gray Hole drops some packets
        else
            types(i) = 'normal';
        end
    end
    
    % Convert the arrays to a table
    data = table(sources', destinations', transmission_times', transmission_rates', types', ...
        'VariableNames', {'Source', 'Destination', 'TransmissionTime', 'TransmissionRate', 'Type'});
    
    % Save the dataset to a .mat file
    save(filename, 'data');
end

