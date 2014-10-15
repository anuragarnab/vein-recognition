[c, n] = distribution_tester(distances_centroid, 6, 0, 1);
plot_pdf( c, n, 25, 100, ' ', 'Centroid Distance', 'Relative Frequency', {'Genuine scores','Imposter scores'});
[corrects, negs] = tester(distances_centroid, imp_distances_centroid, [0:0.25:20], 1, 6);
plot_roc(corrects, negs, [0:0.25:20], 13)
