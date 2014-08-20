start = 1; finish = 500;

reduced_mhd = sort (imposter_mhd, 'ascend');
reduced_mhd = reduced_mhd (start:finish,:); % Only keeps the lowest imposter scores for each sample

reduced_lbp = sort(imposter_lbp, 'ascend');
reduced_lbp = reduced_lbp (start:finish,:);

figure
scatter (genuine_mhd, genuine_lbp, 'rx');
hold on
scatter (reduced_mhd(:), reduced_lbp(:), 'g+');

xlabel ('Modified Hausdorff Distance between bifurcations');
ylabel ('LBP using hamming distance');
legend ('Genuine', 'Imposter');
title ('Scores obtained from two feature extraction methods');