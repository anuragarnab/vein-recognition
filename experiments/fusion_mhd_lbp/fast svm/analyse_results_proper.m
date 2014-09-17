num_outliers = 7;
eers = [];

svms = history_poly(479).svms;

for chosen = [1]

    [corrects_scores, correct_negs_scores] = get_scores_fast (svms, data2);
    
    threshes =  [-10:0.05:-1];
    threshes = [threshes -0.99:0.001:0.99];
    threshes = [threshes 1:0.05:1];
    corrects = [];
    correct_negs = [];
    counter = 1;

    for threshold = threshes

        temp = corrects_scores >= threshold;
        temp = temp';
        temp = temp(:);
        temp(wrong_uns) = 0; % Important. ULBP_chi will sometimes always pick the wrong one (notes in my MEC4063 book) 
        
%         temp = double(temp);
%         temp(6:6:600) = NaN; 
%         temp = temp(~isnan(temp));
        
        corrects = [corrects temp];

        temp = correct_negs_scores < threshold;
        temp = temp';
        temp = temp(:);
        correct_negs = [correct_negs temp];

        %correct_negs(counter) = sum(correct_negs_scores(:) < threshold);
        %counter = counter+1;
    end

plot_roc(corrects, correct_negs, threshes, num_outliers);
[eer, eerv] = get_eer(corrects, correct_negs, num_outliers)
eers = [eers ; [eer, eerv, mean([eer, eerv]) ] ];

end