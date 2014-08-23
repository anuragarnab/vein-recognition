% start = 1; finish = 1;

% reduced_mhd = sort (imposter_mhd, 'ascend');
% reduced_mhd = reduced_mhd (start:finish,:); % Only keeps the lowest imposter scores for each sample
% 
% reduced_lbp = sort(imposter_lbp_chi, 'ascend');
% reduced_lbp = reduced_lbp (start:finish,:);

num_per_sample = 6;
num_imposters = 1;
skip_diags = 1;
[genuines, imposters] = get_score_pairs(distances, distances_ulbp_chi, num_per_sample, num_imposters, skip_diags);

figure
scatter (genuines(:,1), genuines(:,2), 'rx');
hold on
scatter (imposters(:,1), imposters(:,2), 'g+');

xlabel ('Modified Hausdorff Distance between bifurcations');
ylabel ('LBP using hamming distance');
legend ('Genuine', 'Imposter');
title ('Scores obtained from two feature extraction methods');

