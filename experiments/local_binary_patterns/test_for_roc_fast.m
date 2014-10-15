samples_per_person = 6;

correct_record = [];
correct_neg_record = [];
far_record = [];
frr_record = [];
wrong_rec_record = [];
threshes = [0:10:3000];

for threshold = threshes

    fprintf('Testing threshold = %0.3f\n', threshold);
    % These four effectively make up the quadrant
    correct = zeros (length(veins),1);
    correct_neg = zeros (length(veins_unreg),1);
    far = zeros (length(veins_unreg),1);
    frr = zeros (length(veins),1);

    wrong_recognised = zeros(length(veins),1); % Special case of far I guess

    for i = 1:length(veins)
        
        dis = distances_ulbp_chi(:,i);
        [dis, idx] = sort(dis, 'ascend');
        val = dis(2);
        id = idx(2);
        
        if (val > threshold)
            id = -1;
        end
        
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
        
        dis = imp_distances_ulbp_chi(i,:); % Important. Thats how distance_matrix_imposters runs
        [dis, idx] = sort(dis, 'ascend');
        val = dis(2);
        id = idx(2);
        
        if (val > threshold)
            id = -1;
        end

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
    
    save ulbp_test_histogram threshold correct_record correct_neg_record far_record frr_record wrong_rec_record

end