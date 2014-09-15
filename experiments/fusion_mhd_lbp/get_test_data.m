function [ output_args ] = get_test_data( genuines, test_imposters, testing, veins, num_per_sample )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    test_idx = [testing:num_per_sample:length(veins)];
    test_idx(ismember(test_idx, outliers)) = NaN;
    test_idx = test_idx(~isnan(test_idx));

    test_data_gen = genuines(test_idx,:);

    test_data = [test_data_gen ; test_imposters(test_idx,:)];
    test_data(:,1) = (test_data(:,1) - mu(:,1)) ./ sigma(1);
    test_data(:,2) = (test_data(:,2) - mu(:,2)) ./ sigma(2);


    expected = [ones(length(test_data_gen),1) ; -ones(100,1)];


end

