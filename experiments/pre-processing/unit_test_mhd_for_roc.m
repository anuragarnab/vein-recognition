%incorrect = 0;
%outlier_count = 0; % I am going to count errors on images 4, 5 and 6 after the 40th hand as an outlier
%threshold = 6;

load veins
load veins_unreg

%thresholds = [1 2 4 5 5.2 5.4 5.6 5.8 6 6.2 6.4 6.6 6.8 7 8 8.5 9 10];
thresholds = 10;
mhd_fraction = 0.7;

% correct_record = zeros (length(thresholds),1);
% correct_neg_record = zeros (length(thresholds),1);
% false_acceptance_record = zeros (length(thresholds),1);
% outlier_far_record = zeros (length(thresholds),1);
% false_rejection_record = zeros (length(thresholds),1);
% outlier_frr_record = zeros (length(thresholds),1);

correct_record = [];
correct_neg_record = [];
false_acceptance_record = [];
outlier_far_record = [];
false_rejection_record = [];
outlier_frr_record = [];
wrong_rec_record = [];

for k = 1:length(thresholds)

    %only_test_imposters = 1;
    
    %if (only_test_imposters)
    threshold = thresholds (k);
    
    correct = zeros(length(veins),1);
    correct_neg = zeros(length(veins_unreg),1);
    false_acceptance = zeros(length(veins_unreg),1);
    wrong_rec = zeros(length(veins),1);
    
    outlier_far = zeros(length(veins),1);
    false_rejection = zeros(length(veins),1);
    outlier_frr = zeros(length(veins_unreg),1);
    
    for j = 1:length(veins)

       output_id = identify (j, mhd_fraction, veins, threshold);
       [start, finish] = get_limits (j, 6);
       index = mod (j, 6);


       if (output_id == -1)
          % Identifier is saying that the person does not exist in the system,
          % but we know that he does!
          false_rejection(j) = 1; 

          if ( (index == 0 || index == 4 || index == 5) && j > 240)
               outlier_frr(j) = 1;
          end

       elseif (output_id < start || output_id > finish)
          % Identifier has identified the wrong person
          wrong_rec(j) = 1;

          if ( (index == 0 || index == 4 || index == 5) && j > 240)
               outlier_far(j) = 1;
          end

       else
           correct(j) = 1;
       end

    end

    %end

    for j=1:length(veins_unreg)

        output_id = identify (j, mhd_fraction, veins, threshold, 1, veins_unreg);
        if (output_id ~= -1)
           false_acceptance(j) = 1;
           fprintf ('Error with imposter %i, detected as %i\n', j, output_id);
        else
            correct_neg(j) = 1;
        end

    end
    
    fprintf ('Completed for threshold %0.2f\n', threshold);
   % correct_record(k) = correct;
   % correct_neg_record(k) = correct_neg;
   % false_acceptance_record(k) = false_acceptance;
   % outlier_far_record(k) = outlier_far;
   % false_rejection_record(k) = false_rejection;
   % outlier_frr_record(k) = outlier_frr;
   
   correct_record = [correct_record correct];
   correct_neg_record = [correct_neg_record correct_neg];
   false_acceptance_record = [false_acceptance_record false_acceptance];
   false_rejection_record = [false_rejection_record false_rejection];
   wrong_rec_record = [wrong_rec_record wrong_rec];
   outlier_far_record = [outlier_far_record outlier_far];
   outlier_frr_record = [outlier_frr_record outlier_frr];
   
   save rocData correct_record correct_neg_record false_acceptance_record outlier_far_record false_rejection_record outlier_frr_record wrong_rec_record thresholds
   
end

