num_per_sample = 6;
num_imposters = 20;
skip_diags = 1;
testing = 3;
zero_far = 709; % this is what I got from the accuracy graph
history = [];
count = 1;

%% Get data from 600 registered samples and 600 unregistered samples for training and testing
[genuines, imposters] = get_score_pairs(distances_ulbp_chi, distances_mhd, num_per_sample, num_imposters, skip_diags);
imp_lbp = imp_distances_ulbp_chi';
imp_mhd = imp_distances_mhd';
test_imposters = zeros(size(imp_lbp,2) ,2);

[~, idx] = min(imp_lbp);

for i = 1:size(test_imposters,1)
   test_imposters(i,1) = imp_lbp(idx(i),i);
   test_imposters(i,2) = imp_mhd(idx(i),i);
end

for logc = [-3:0.5:5];
    c = 2^logc;
for loggamma = [-4:0.5:3];
    gamma = 2^loggamma;
for w1 = 1:1:20
for degree = 1:1:4

    %% Do multiple cross validation. Split up the training and testing samples. Then train the SVM. 
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
        imposter_data = imposter_data(imposter_data > zero_far, :);

        train_data = [genuines(train_idx, :) ; imposter_data];
        [train_data, mu, sigma] = zscore(train_data);

        labels = ones(length(train_data), 1);
        labels(length(train_idx)+1:end) = -1;

%         c =8; % default parameter
%         gamma = 0.5;
%         w1 = 1;

%        cmd = ['-s 0 -t 2 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -q'];
        %cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
        cmd = ['-s 0 -t 1 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -d ', num2str(degree),' -q'];
        svm_model = svmtrain(labels,train_data, cmd);
    %     svm_model = svmtrain(labels,train_data, '-s 0 -t 2 -b 1 -c 8 -g 0.5 -w1 10 -w-1 1');
    %    plotboundary(labels,train_data, svm_model, 't');

        %% Now the actual testing

        % I select the 100 best distances (selected by lbp) from the genuine data
        % I then select the 100 best imposter distances (one every sixth sample),
        % as chosen by lbp as well

        test_data_gen = genuines(test_idx,:);

        test_data = [test_data_gen ; test_imposters(test_idx,:)];
        test_data(:,1) = (test_data(:,1) - mu(:,1)) ./ sigma(1);
        test_data(:,2) = (test_data(:,2) - mu(:,2)) ./ sigma(2);


        expected = [ones(length(test_data_gen),1) ; -ones(100,1)];
        [predictions, accuracy, scores] = svmpredict(expected, test_data, svm_model);
        all_predictions = [all_predictions predictions];
        
        svms = [svms svm_model];

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

    history(count).corrects = corrects;
    history(count).correct_negs = correct_negs;
    history(count).all_predictions = all_predictions;
    history(count).expected = expected;
    history(count).correct_acceptance = correct_acceptance;
    history(count).correct_rejects = correct_rejects;
    history(count).svms = svms;
   % history(count).gamma = gamma;
    history(count).c = c;
    history(count).w1 = w1;

    count = count + 1;
    save testing history

end
end
end
end

