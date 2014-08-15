function [ candidates ] = get_candidates( index, veins, num_candidates, samples_per_person )
%get_candidates Gets the candidates to do Nearest Neighbour with

    distances = get_distances (index, veins);
    [~, distances] = sort (distances, 'ascend');
    
    candidates = [];
    counter = 1;
    
    samples_per_person = samples_per_person + 0.001; % Prevents 6 from being mapped to 7 when it should be mapped to 1. For all multiples of 6 really
    
    while (length (candidates) < num_candidates)
        subject = distances(counter);
        subject = floor (subject / samples_per_person) * floor(samples_per_person) + 1;
        
        if ~ismember(subject, candidates)
           candidates = [candidates ; subject]; 
        end
        
        counter = counter + 1;
    end


end

