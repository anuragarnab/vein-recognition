% Anurag Arnab - ARNANU002
% MHD classifier demo
% Loads vein images from external database (refer to the MHD exended_demo
% to populate the training database from scratch (its expected to take at
% least 15 minutes)

% Depending on the users options, either forms clusters and computes the
% score matrix, or loads a pre-computed score matrix to plot the ROC and
% calculate other figures of merit as described in Chapter 3
% Finally, a few test images are identified

clear
disp('Loading the stored data from the "experimental_data" directory to save time');
load ../experimental_data/training_database

prompt = 'Choose from the following two choices: \n 1) Perform complete testing, including the computation of the score matrix (expect at least 10 minutes) \n 2) Plot the ROC and other experiments using a pre-computed score matrix \n Option 2 is the default\n';
option = input(prompt);

optimal_f_parameter = 0.7; % Showed this in Chapter 5

if (option == 1)
  [distances_mhd, imp_distances_mhd] = distance_matrix( veins, veins_unreg, optimal_f_parameter );  
else
   load ../experimental_data/score_matrices/mhd_scores 
end

num_outliers = 13;
num_per_sample = 6;

disp('Plotting the score distribution and showing the d'' (d-prime) value');
[c, n] = distribution_tester(distances_mhd, num_per_sample);
plot_pdf( c, n, 25, 200, ' ', 'MHD Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
dp = dprime(c,n);
fprintf('The dprime value is %0.3f \n', dp);

disp('Press <Enter to continue>. The ROC will be computed now')
pause()

thresholds = [0:0.05:11]; limits = 0;
[corrects, negs] = tester(distances_mhd, imp_distances_mhd, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);

fprintf('\n')
disp('')
disp('Press <Enter to continue>. Identifying a few arbitrary examples')
pause()

disp('Identifying registered users')
threshold = 5.4; % The threshold resulted in the EER, as shown in Chapter 5 and Accuracy graphs

verbose = 1;
is_imposter = 0;

hFig = figure;

for test = 3:9:50
   id = identify(veins(test), optimal_f_parameter, veins, threshold, verbose, test);
   if (id >= 1)
       figure(hFig);
       subplot(2,1,1)
       imshow(veins(test).image);
       title(strcat('Original: ',num2str(test)));
       subplot(2,1,2);
       imshow(veins(id).image);
       title(strcat('Identified: ',num2str(id)));
       pause
   end
end

disp('Identifying unregistered users. Press <Enter> to continue')
pause

is_imposter = 1;
optimal_f_parameter = 0.7; % Showed this in Chapter 5
for test = 5:9:50
   identify(veins_unreg(test), optimal_f_parameter, veins, threshold, verbose, test);
end