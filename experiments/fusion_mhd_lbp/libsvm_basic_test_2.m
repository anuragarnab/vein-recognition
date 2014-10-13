%% Set up parameters

num_per_sample = 6;
num_imposters = 20;
skip_diags = 1;
testing = 6;
%zero_far = 709; % this is what I got from the accuracy graph
history = [];
outliers = 0;
data2 = [];

%% Get data from 600 registered samples and 600 unregistered samples for training and testing
[genuines, imposters] = get_score_pairs(distances_mhd, distances_hamming, num_per_sample, num_imposters, skip_diags);
%[genuines2, imposters2] = get_score_pairs(distances_fourier, distances_hamming, num_per_sample, num_imposters, skip_diags);
% [genuines3, imposters3] = get_score_pairs(distances_ulbp_chi, distances_fourier, num_per_sample, num_imposters, skip_diags);
%genuines = [genuines genuines2(:,2)];
%imposters = [imposters imposters2(:,2)];
% genuines = [genuines genuines3(:,2)];
% imposters = [imposters imposters3(:,2)];


imp_lbp = imp_distances_mhd';
imp_mhd = imp_distances_hamming';
imp_fourier = imp_distances_hamming';
imp4 = imp_distances_fourier';

test_imposters = zeros(size(imp_lbp,2) ,2);

[~, idx] = min(imp_lbp);

for i = 1:size(test_imposters,1)
   test_imposters(i,1) = imp_lbp(idx(i),i);
   test_imposters(i,2) = imp_mhd(idx(i),i);
%   test_imposters(i,3) = imp_fourier(idx(i),i);
%    test_imposters(i,4) = imp4(idx(i),i);
end


%% Do 6 fold testing and classification
svms = [];
all_predictions = [];

for testing = [1:1:6]

    train_idx = [1:1:length(veins)];
    train_idx(testing:num_per_sample:length(veins)) = NaN;
    train_idx(ismember(train_idx, outliers)) = NaN;
    train_idx = train_idx(~isnan(train_idx));

    test_idx = [testing:num_per_sample:length(veins)];
    test_idx(ismember(test_idx, outliers)) = NaN;
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
   % imposter_data = imposter_data(imposter_data(:,1) > zero_far, :);

    train_data = [genuines(train_idx, :) ; imposter_data];
    [train_data, mu, sigma] = zscore(train_data);

    labels = ones(length(train_data), 1);
    labels(length(train_idx)+1:end) = -1;

       % c =30.2458; % default parameter
       % c = 1;
       % gamma = 6.6201;
       
        c = 2^-14; w1 = 17; % best for canonical lbp + mhd 
       %c = 2^-15; w1 = 17; gamma = 2^-6; % best for canonical lbp + mhd + fourier lbp
       
%        c = 0.5; w1 = 5; gamma = 2^-1; % samplpe rbf
%       %  w1 = 5;
%         degree = 3;
%         coeff0 = 0;

% RBF
%    cmd = ['-s 0 -t 2 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -q'];

% Linear
     cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
     
% Polynomial     
%    cmd = ['-s 0 -t 1 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -d ', num2str(degree), ' -r ', num2str(coeff0),' -q'];
    
    svm_model = svmtrain(labels,train_data, cmd);
%     svm_model = svmtrain(labels,train_data, '-s 0 -t 2 -b 1 -c 8 -g 0.5 -w1 10 -w-1 1');
%    plotboundary(labels,train_data, svm_model, 't');

    %% Now the actual testing

    % I select the 100 best distances (selected by lbp) from the genuine data
    % I then select the 100 best imposter distances (one every sixth sample),
    % as chosen by lbp as well

    test_data_gen = genuines(test_idx,:);

    test_data = [test_data_gen ; test_imposters(test_idx,:)];
    
    for j = 1:size(test_data,2)
       test_data(:,j) = (test_data(:,j) - mu(:,j) ) ./ sigma(j); 
    end
    
    % test_data(:,1) = (test_data(:,1) - mu(:,1)) ./ sigma(1);
   % test_data(:,2) = (test_data(:,2) - mu(:,2)) ./ sigma(2);


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

correct_acceptance = sum(sum(corrects))/600.0
correct_rejects = sum(sum(correct_negs))/600.0

count = length(history)+1;
history(count).corrects = corrects;
history(count).correct_negs = correct_negs;
history(count).all_predictions = all_predictions;
history(count).expected = expected;
history(count).correct_acceptance = correct_acceptance;
history(count).correct_rejects = correct_rejects;
history(count).svms = svms;
history(count).c = c;
history(count).w1 = w1;
