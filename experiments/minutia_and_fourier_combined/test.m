samples_per_person = 6;
fourier_candidates = 20; % Should play around with this
hd_fraction = 0.7;
threshold = 5.4; % Determined to be best for 0.7-fraction-mhd previously

num_test = 600;
correct = zeros(num_test, 1);
not_in_list = zeros(num_test, 1);

for i = 1:num_test
   
    candidates = get_candidates (i, veins, fourier_candidates, samples_per_person);
    filled_candidates = fill_candidates (candidates, samples_per_person);
    
    id = identify(i, hd_fraction, veins, threshold, 0, [], filled_candidates);
    
    [start, fin] = get_limits(i, samples_per_person);
    if (id >= start && id <= finish)
        correct(i) = 1;
    else
        if (~ismember(i, filled_candidates) )
            fprintf('Incorrect for %i. Predicted %i. Wasnt in candidate list\n', i, id);
            not_in_list(i) = 1;
        end
    end

    if (mod(i,10) == 0)
        fprintf('%i\n', i);
    end

    
end

sum(correct)
