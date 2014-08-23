index = 42;

addpath lbp
d_lbp = get_distances(veins(index), veins, 42);
[val_l, idx_l] = sort(d_lbp, 'ascend');
rmpath lbp

addpath mhd
[~, ~, d_mhd] = test_identity(42,0.7,veins);
[val_m, idx_m] = sort(d_mhd, 'ascend');
rmpath mhd