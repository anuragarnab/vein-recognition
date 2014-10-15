% Anurag Arnab - ARNANU002
% Plots the ROC curve for the SVM-fused data
% This does this by calculating the distance for the separating hyperplane
% for the test data
% Different thresholds are then applied to this data to see how it affects
% the number of genuine acceptances and imposter rejections.
% This was detailed in Chapter 8

num_outliers = 7;
eers = [];

    [corrects_scores, correct_negs_scores] = get_scores_fast (svms, data2);
    
    threshes =  [-5:0.05:-1];
    threshes = [threshes -0.99:0.001:0.99];
    threshes = [threshes 1:0.05:5];
    corrects = [];
    correct_negs = [];
    counter = 1;

    for threshold = threshes

        temp = corrects_scores >= threshold;
        temp = temp';
        temp = temp(:);
                
        corrects = [corrects temp];

        temp = correct_negs_scores < threshold;
        temp = temp';
        temp = temp(:);
        correct_negs = [correct_negs temp];

    end

plot_roc(corrects, correct_negs, threshes, num_outliers);
