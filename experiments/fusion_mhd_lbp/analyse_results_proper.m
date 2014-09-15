num_outliers = 7;
eers = [];

for chosen = [1953, 1954]

    [corrects_scores, correct_negs_scores] = get_scores (chosen, history, veins, distances_ulbp_chi, distances_mhd, imp_distances_ulbp_chi, imp_distances_mhd);

    threshes =  [-10:0.01:10];
    corrects = [];
    correct_negs = [];
    counter = 1;

    for threshold = threshes

        temp = corrects_scores >= threshold;
        temp = temp';
        temp = temp(:);
        temp(wrong_uns) = 0; % Important. ULBP_chi will sometimes always pick the wrong one (notes in my MEC4063 book) 

        corrects = [corrects temp];

        temp = correct_negs_scores < threshold;
        temp = temp';
        temp = temp(:);
        correct_negs = [correct_negs temp];

        %correct_negs(counter) = sum(correct_negs_scores(:) < threshold);
        %counter = counter+1;
    end

%plot_roc(corrects, correct_negs, threshes, num_outliers);
[eer, eerv] = get_eer(corrects, correct_negs, num_outliers)
eers = [eers ; [eer, eerv, mean([eer, eerv]) ] ];

end