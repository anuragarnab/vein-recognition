% Anurag Arnab - ARNANU002
% Cluster classifier demo
% Loads vein images from external database (refer to the MHD demo to do
% this again)

% Depending on the users options, either forms clusters and computes the
% score matrix, or loads a pre-computed score matrix to plot the ROC and
% calculate other figures of merit as described in Chapter 3
% Finally, a few test images are identified

clear
disp('Loading the stored data from the "experimental_data" directory to save time');
load ../experimental_data/training_database

prompt = 'Choose from the following two choices: \n 1) Perform complete testing, including training of cluster and the computation of the score matrix (expect at least 10 minutes) \n 2) Plot the ROC and other experiments using a pre-computed score matrix \n Option 2 is the default\n';
option = input(prompt);

images_per_user = 6;
users = 100;
num_clusters = 160; % Showed in Chapter 6 this is optimal

if (option == 1)
    
    warning('off','all'); % empty cluster warnings are annoying
    clus1 = train_cluster(images_per_user, users, num_clusters, veins, [1, 2, 3, 4, 5]);
    clus2 = train_cluster(images_per_user, users, num_clusters, veins, [0, 2, 3, 4, 5]);
    clus3 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 3, 4, 5]);
    clus4 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 4, 5]);
    clus5 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 5]);
    clus6 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 4]);

    [distances_centroid, imp_distances_centroid] = distance_matrix( clus1, clus2, clus3, clus4, clus5, clus6, veins, veins_unreg );
 
else
   load ../experimental_data/score_matrices/cluster_scores 
   load ../experimental_data/score_matrices/clusters 
end

num_outliers = 13;

% Since we use the same "tester" function for all classes, we set these
% parameters since the Cluster classifier is tested using MCV unlike the
% others which use LOO
limits = 1;
ignore_zero = 0;


disp('Plotting the score distribution and showing the d'' (d-prime) value');
[c, n] = distribution_tester(distances_centroid, images_per_user, ignore_zero, limits);
plot_pdf( c, n, 25, 200, ' ', 'Centroid Distance', 'Relative Frequency', {'Genuine scores','Imposter scores   '});
dp = dprime(c,n);
fprintf('The dprime value is %0.3f \n', dp);

disp('Press <Enter to continue>. The ROC will be computed now')
pause()

thresholds = [0:0.25:20];
[corrects, negs] = tester(distances_centroid, imp_distances_centroid, thresholds, limits, images_per_user);
plot_roc(corrects, negs, thresholds, num_outliers);

fprintf('\n')
fprintf('\n')
disp('Press <Enter to continue>. Identifying a few arbitrary examples')
pause()

disp('Identifying registered users')
threshold = 5; % The threshold resulted in the EER, as shown in Chapter 5 and Accuracy graphs

verbose = 1;

hFig = figure;

for test = 3:9:50
   id = identify(test , veins, clus3, threshold);
   if (id >= 1)
       figure(hFig);
       subplot(2,1,1)
       imshow(veins(test).image);
       title(strcat('Original: ',num2str(test), ' from Class: ', num2str(ceil((test-eps)/6)) ));
       subplot(2,1,2);
       imshow(veins(id*6).image);
       title(strcat('Identified as belonging to class: ',num2str(id)));
       pause
   end
end
