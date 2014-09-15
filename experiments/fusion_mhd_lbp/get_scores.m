function [corrects_scores, correct_negs_scores] = get_scores (chosen, history, veins, distances_ulbp_chi, distances_mhd, imp_distances_ulbp_chi, imp_distances_mhd)

    %chosen = 1953; I am just going to set these parameters here because it
    %takes too long to type them as input parameters and then set default
    %arguments
    num_imposters = 20;
    num_per_sample = 6;
    outliers = 0;
    zero_far = 709;
    skip_diags = 1;

    svms = history(chosen).svms;
    corrects_scores = [];
    correct_negs_scores = [];
    [genuines, imposters] = get_score_pairs(distances_ulbp_chi, distances_mhd, num_per_sample, num_imposters, skip_diags);

    imp_lbp = imp_distances_ulbp_chi';
    imp_mhd = imp_distances_mhd';
    test_imposters = zeros(size(imp_lbp,2) ,2);

    [~, idx] = min(imp_lbp);

    for i = 1:size(test_imposters,1)
       test_imposters(i,1) = imp_lbp(idx(i),i);
       test_imposters(i,2) = imp_mhd(idx(i),i);
    end


    for testing = 1:1:6
       [train_data, labels , mu, sigma] = get_train_data (testing, veins, genuines, imposters, num_imposters, num_per_sample, outliers, zero_far); % why do i need this? I already have the svm trained with this
       [test_data, expected] = get_test_data(genuines, test_imposters, testing, veins, mu, sigma, num_per_sample, outliers);

       [~, ~, scores] = svmpredict(expected, test_data, svms(testing));
       corrects_scores = [corrects_scores scores(1:100)];
       correct_negs_scores = [correct_negs_scores scores(101:end)];
    end

end