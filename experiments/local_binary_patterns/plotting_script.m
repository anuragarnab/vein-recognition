num_per_sample = 6;
limits = 0;
num_outliers = 7;

% [c, n] = distribution_tester(distances_fourier, num_per_sample);
% plot_pdf( c, n, 25, 200, ' ', 'Euclidean Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
% dprime(c,n)

% thresholds = [0:10:4000];
% [corrects, negs] = tester(distances_flbp, imp_distances_flbp, thresholds, limits, num_per_sample);
% plot_roc(corrects, negs, thresholds, num_outliers);

% thresholds = [200:5:2000];
thresholds = [200:5:500];
thresholds = [thresholds 505:1:900];
thresholds = [thresholds 910:10:2000];
thresholds = [0 thresholds];

[corrects, negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);

% fourier
% thresholds = [0 2000:5:20000];
% [corrects, negs] = tester(distances_fourier, imp_distances_fourier, thresholds, limits, num_per_sample);
% plot_roc(corrects, negs, thresholds, num_outliers);

%% Hamming
% thresholds = [0 2000:10:25000];
% [corrects, negs] = tester(distances_hamming, imp_distances_hamming, thresholds, limits, num_per_sample);
% plot_roc(corrects, negs, thresholds, num_outliers);

% MHD
% thresholds = [0:0.05:11];
% [corrects, negs] = tester(distances_mhd, imp_distances_mhd, thresholds, limits, num_per_sample);
% plot_roc(corrects, negs, thresholds, num_outliers);
