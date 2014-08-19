%load veins
%load veins_unreg

samples_per_person = 6;

correct_record = [];
correct_neg_record = [];
far_record = [];
frr_record = [];
wrong_rec_record = [];
threshes = [5:5:100];

for threshold = threshes

    fprintf('Testing threshold = %0.3f\n', threshold);
    % These four effectively make up the quadrant
    correct = zeros (length(veins),1);
    correct_neg = zeros (length(veins_unreg),1);
    far = zeros (length(veins_unreg),1);
    frr = zeros (length(veins),1);

    wrong_recognised = zeros(length(veins),1); % Special case of far I guess

    for i = 1:length(veins)
        id = identify( veins(i), veins, threshold, 1, i); % The "1" is saying that we are doing LOO testing

        [start, finish] = get_limits(i, samples_per_person);
        if (id > start && id <= finish)
            correct(i) = 1;
        elseif (id == -1)
            frr(i) = 1;
        else
            wrong_recognised(i) = 1;
        end 

        if (mod(i,100) == 0)
           fprintf('%i\n', i); 
        end
    end

    for i=1:length(veins_unreg)
       id = identify(veins_unreg(i), veins, threshold); 

       if (id == -1)
          correct_neg(i) = 1;
       else
           far(i) = 1;
       end

       if (mod(i,100) == 0)
           fprintf('%i\n', i); 
       end
    end
    
    correct_record = [correct_record correct];
    correct_neg_record = [correct_neg_record correct_neg];
    far_record = [far_record far];
    frr_record = [frr_record frr];
    wrong_rec_record = [wrong_rec_record wrong_recognised];
    
    save lbp_test_histogram threshold correct_record correct_neg_record far_record frr_record wrong_rec_record

end