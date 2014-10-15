%% Anurag Arnab - ARNANU002
% This is a script used to test SVM fusion

% It loads the score matrices from the MHD and Canonical LBP classifers (it
% can easily be modified to load more)
% An SVM is then trained using the LibSVM library for the SVM
% implementation
% Six-fold MCV is used as described in Chapter 3.3

% In this example, the SVM is trained with the optimal parameters which
% were shown in Chapter 8
% The script outputs a struct named "data2." This stores the six train and
% test parititions for later use by the grid-search optimiser

%% Set up parameters

num_per_sample = 6;
num_imposters = 20;
skip_diags = 1;
outliers = 0;
data2 = [];

%% Get data from 600 registered samples and 600 unregistered samples for training and testing
[genuines, imposters] = get_score_pairs(distances_mhd, distances_hamming, num_per_sample, num_imposters, skip_diags);

imp_lbp = imp_distances_mhd';
imp_mhd = imp_distances_hamming';

test_imposters = zeros(size(imp_lbp,2) ,2);

[~, idx] = min(imp_lbp);

for i = 1:size(test_imposters,1)
   test_imposters(i,1) = imp_lbp(idx(i),i);
   test_imposters(i,2) = imp_mhd(idx(i),i);
end


%% Do 6 fold testing and classification
svms = [];
all_predictions = [];

for testing = [1:1:6]

    train_idx = [1:1:length(veins)];
    train_idx(testing:num_per_sample:length(veins)) = NaN;
    train_idx = train_idx(~isnan(train_idx));

    test_idx = [testing:num_per_sample:length(veins)];
    test_idx = test_idx(~isnan(test_idx));

    imposter_indices = [];
    for j = 1:length(veins)
       if (ismember(j, train_idx))
          start = (j-1)*num_imposters+1;
          fin = j*num_imposters;
          imposter_indices = [imposter_indices [start:1:fin]]; 
       end
    end


    imposter_data = imposters(imposter_indices,:);

    train_data = [genuines(train_idx, :) ; imposter_data];
    [train_data, mu, sigma] = zscore(train_data);

    labels = ones(length(train_data), 1);
    labels(length(train_idx)+1:end) = -1;

    c = 2^-14; w1 = 17; % optimal parameters for canonical lbp + mhd 
    %c = 2^-15; w1 = 17; gamma = 2^-6; % best for canonical lbp + mhd + fourier lbp


% RBF kernel command - Consult LibSVM documentation for details
%    cmd = ['-s 0 -t 2 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -q'];

% Linear kernel command - Consult LibSVM documentation for details
     cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
     
% Polynomial kernel command - Consult LibSVM documentation for details   
%    cmd = ['-s 0 -t 1 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -d ', num2str(degree), ' -r ', num2str(coeff0),' -q'];
    
    svm_model = svmtrain(labels,train_data, cmd);

    %% Now the actual testing

    % Select the 100 best distances (selected by lbp) from the genuine data
    % Then select the 100 best imposter distances (one every sixth sample),
    % as chosen by lbp as well

    test_data_gen = genuines(test_idx,:);

    test_data = [test_data_gen ; test_imposters(test_idx,:)];
    
    for j = 1:size(test_data,2)
       test_data(:,j) = (test_data(:,j) - mu(:,j) ) ./ sigma(j); 
    end
    
    expected = [ones(length(test_data_gen),1) ; -ones(100,1)];
    [predictions, accuracy, scores] = svmpredict(expected, test_data, svm_model);
    all_predictions = [all_predictions predictions];

    svms = [svms svm_model];
    
    data2(testing).train = train_data;
    data2(testing).labels = labels;
    data2(testing).test_data = test_data;
    data2(testing).expected = expected;

end

%% collate results
corrects = zeros(100,6);
correct_negs = zeros(100,6);
for i = 1:num_per_sample
    fin = length(all_predictions(:,i)) - 100;
    corrects(:,i) = all_predictions(1:1:fin, i) == expected(1:1:fin);
    correct_negs(:,i) = all_predictions(fin+1:1:end, i) == expected(fin+1:1:end);
end


 save data2 data2