% Changes the params on the straight boundary classifier
% It is unlikely that it is going that the thresholds of mhd = 5 and ulbp
% = 1000 will be improved upon

mhd_threshes = [0.1 : 0.1 : 6];
lbp_threshes = [500 : 10 : 1200];
corrects = zeros (length(lbp_threshes), length(mhd_threshes) );
correct_negs = zeros (length(lbp_threshes), length(mhd_threshes) );

for i = 1:length(lbp_threshes)
    t1 = lbp_threshes(i);
    for j = 1:length(mhd_threshes)
        
        t2 = mhd_threshes(j);
        [c, n] = straight_boundary_test_function(distances_ulbp_chi, imp_distances_ulbp_chi, t1, distances_mhd, imp_distances_mhd, t2);
        corrects(i, j) = c;
        correct_negs(i,j) = n;
    end
end

total = corrects + correct_negs;