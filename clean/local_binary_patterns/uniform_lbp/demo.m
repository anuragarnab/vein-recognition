% Anurag Arnab - ARNANU002
% Uniform LBP classifier demo
% Loads vein images from external database (refer to the MHD exended_demo
% to populate the training database from scratch (its expected to take at
% least 15 minutes)

% Depending on the users options, either forms clusters and computes the
% score matrix, or loads a pre-computed score matrix to plot the ROC and
% calculate other figures of merit as described in Chapter 3
% Finally, a few test images are identified

clear
addpath ../

disp('Loading the stored data from the "experimental_data" directory to save time');
load ../../experimental_data/training_database

prompt = 'Choose from the following two choices: \n 1) Perform complete testing, including the computation of the score matrix (expect at least 10 minutes) \n 2) Plot the ROC and other experiments using a pre-computed score matrix \n Option 2 is the default\n';
option = input(prompt);

if (option == 1)
  load_lbp; % Compute LBP features
  [distances_ulbp_chi, imp_distances_ulbp_chi] = distance_matrix( veins, veins_unreg );  
else
   load ../../experimental_data/score_matrices/Uniform_lbp_scores 
end

num_outliers = 7;
num_per_sample = 6;

disp('Plotting the score distribution and showing the d'' (d-prime) value');
[c, n] = distribution_tester(distances_ulbp_chi, num_per_sample);
plot_pdf( c, n, 25, 200, ' ', 'Chi-Square Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
dp = dprime(c,n);
fprintf('The dprime value is %0.3f \n', dp);

disp('Press <Enter to continue>. The ROC will be computed now')
pause()

thresholds = [0 600:1:800 810:10:1000 1000:20:1500]; limits = 0;
[corrects, negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
plot_roc(corrects, negs, thresholds, num_outliers);

fprintf('\n')
disp('')
disp('Press <Enter to continue>. Identifying a few arbitrary examples')
pause()

disp('Identifying registered users')
threshold = 800; % The threshold resulted in the EER, as shown in Chapter 7 and Accuracy graphs

genuine_test = 1;

hFig = figure;

for test = [286, 300, 468, 467, 42, 60] % Some nice, hard examples to test with
   id = get_identity(veins(test), veins, threshold, test);
   if (id >= 1)
       figure(hFig);
       subplot(2,1,1)
       imshow(veins(test).image);
       title(strcat('Original: ',num2str(test)));
       subplot(2,1,2);
       imshow(veins(id).image);
       title(strcat('Identified: ',num2str(id)));
       disp('Press any key to continue')
       pause
   end
end


