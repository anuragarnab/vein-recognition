disp('Loading the data. This may take several minutes');
disp('An alternative is to load the training database from the "Experimental Data" folder');
disp(' ');
load_data;

disp('Press <Enter> to compute the Score Matrices and the ROC');
pause

optimal_f_parameter = 0.7; % Showed this in Chapter 5
[distances_mhd, imp_distances_mhd] = distance_matrix( veins, veins_unreg, optimal_f_parameter );

num_outliers = 13;
num_per_sample = 6;

[c, n] = distribution_tester(distances_mhd, num_per_sample);
plot_pdf( c, n, 25, 200, ' ', 'Euclidean Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
dp = dprime(c,n);
fprintf('The dprime value is %0.3f \n', dp);

thresholds = [0:0.05:11]; limits = 0;
[corrects, negs] = tester(distances_mhd, imp_distances_mhd, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);

disp('Identifying a few arbitrary examples')
disp('')
disp('Identifying registered users')
threshold = 5.4; % The threshold resulted in the EER, as shown in Chapter 5 and Accuracy graphs

verbose = 1;
is_imposter = 0;

for test = 3:9:50
   identify(veins(test), optimal_f_parameter, veins, threshold, verbose, test);
end

disp('Identifying unregistered users')

is_imposter = 1;
optimal_f_parameter = 0.7; % Showed this in Chapter 5
for test = 5:9:50
   identify(veins_unreg(test), optimal_f_parameter, veins, threshold, verbose, test);
end