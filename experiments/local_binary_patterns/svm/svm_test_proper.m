num_per_sample = 6;

distances_svm = zeros(length(veins),length(veins)/num_per_sample);
imposter_data = populate([1:1:600], [600 ; 59*32], veins_unreg);
accuracies = [];

for n = 0.05:0.05:1
    predictions = [];
    for testing = [1:1:num_per_sample]

        train_idx = [1:1:length(veins)];
        train_idx(testing:num_per_sample:length(veins)) = NaN;
        train_idx = train_idx(~isnan(train_idx));

        test_idx = [testing:num_per_sample:length(veins)];

        train_data = populate(train_idx,[500 ; 59*32], veins);
        train_data = zscore(train_data);

        test_data = populate(test_idx,[100 ; 59*32], veins);
        test_data = zscore(test_data);

        labels = zeros(length(train_idx), 1);
        for i=1:length(labels)
           labels(i) = ceil(train_idx(i)/num_per_sample); 
        end

        svmmodel = svmtrain(labels,train_data,strcat('-s 1 -t 0 -b 1', '-n ', num2str(n)) ); 
        [preds, acc, probabilities] = svmpredict(double([1:1:100]'), double(test_data), svmmodel, '-b 1');
        predictions = [predictions preds];

        %distances_svm(test_idx,:) = probabilities; 
    end

    corrects = [1:1:100]';
    all_corrects = [];
    for i=1:num_per_sample
        all_corrects = [all_corrects corrects];
    end
    
    accuracy = sum(sum(all_corrects==predictions))/double(length(veins))*100
    accuracies = [accuracies accuracy];

end

