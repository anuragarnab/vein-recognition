%incorrect = 0;
%outlier_count = 0; % I am going to count errors on images 4, 5 and 6 after the 40th hand as an outlier
%threshold = 6;

thresholds = [1 2 4 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 8];

%correct_record = zeros (length(thresholds));
%correct_neg_record = zeros (length(thresholds));
%false_acceptance_record = zeros (length(thresholds));
%outlier_far_record = zeros (length(thresholds));
%false_rejection_record = zeros (length(thresholds));
%outlier_frr_record = zeros (length(thresholds));

for k = 4:length(thresholds)

    %only_test_imposters = 1;
    
    %if (only_test_imposters)
    threshold = thresholds (k);
    
    correct = 0;
    correct_neg = 0;
    false_acceptance = 0;
    outlier_far = 0;
    false_rejection = 0;
    outlier_frr = 0;
    
    for j = 1:length(veins)

       output_id = identify (j, 0.8, veins, threshold);
       [start finish] = get_limits (j, 6);
       index = mod (j, 6);


       if (output_id == -1)
          % Identifier is saying that the person does not exist in the system,
          % but we know that he does!
          false_rejection = false_rejection + 1; 

          if ( (index == 0 || index == 4 || index == 5) && j > 240)
               outlier_frr = outlier_frr + 1;
          end

       elseif (output_id < start || output_id > finish)
          % Identifier has identified the wrong person
          false_acceptance = false_acceptance + 1;

          if ( (index == 0 || index == 4 || index == 5) && j > 240)
               outlier_far = outlier_far + 1;
          end

       else
           correct = correct + 1;
       end

    end

    %end

    for j=1:length(veins)

        output_id = identify (j, 0.8, veins, threshold, 1, veins_unreg);
        if (output_id ~= -1)
           false_acceptance = false_acceptance + 1;
           fprintf ('Error with imposter %i, detected as %i\n', j, output_id);
        else
            correct_neg = correct_neg + 1;
        end

    end
    
    fprintf ('Completed for threshold %0.2f\n', threshold);
    correct_record(k) = correct;
    correct_neg_record(k) = correct_neg;
    false_acceptance_record(k) = false_acceptance;
    outlier_far_record(k) = outlier_far;
    false_rejection_record(k) = false_rejection;
    outlier_frr_record(k) = outlier_frr;
end
