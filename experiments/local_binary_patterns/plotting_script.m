num_per_sample = 6;
limits = 0;
num_outliers = 7;

[c, n] = distribution_tester(distances_ulbp_chi, num_per_sample);
plot_pdf( c, n, 25, 200, ' ', 'Chi Square Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
dprime(c,n)

%thresholds = [200:5:2000];
thresholds = [200:5:500];
thresholds = [thresholds 505:1:900];
thresholds = [thresholds 910:10:2000];
thresholds = [0 thresholds];

[corrects, negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);
