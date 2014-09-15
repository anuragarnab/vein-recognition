function [] = plot_svm_boundary( svm, testing, veins, genuines, imposters, num_imposters, num_per_sample, outliers, zero_far )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if (nargin < 7)
       num_per_sample = 6; 
    end
    
    if (nargin < 6)
       num_imposters = 20; 
    end
    
    if (nargin < 8)
       outliers = 0; 
    end
    
    if (nargin < 9)
       zero_far = 709; 
    end

%     train_idx = [1:1:length(veins)];
%     train_idx(testing:num_per_sample:length(veins)) = NaN;
%     train_idx(ismember(train_idx, outliers)) = NaN;
%     train_idx = train_idx(~isnan(train_idx));
% 
%     test_idx = [testing:num_per_sample:length(veins)];
%     test_idx(ismember(test_idx, outliers)) = NaN;
%     test_idx = test_idx(~isnan(test_idx));
% 
%     imposter_indices = [];
%     for j = 1:length(veins)
%        if (ismember(j, train_idx))
%           start = (j-1)*num_imposters+1;
%           fin = j*num_imposters;
%           imposter_indices = [imposter_indices [start:1:fin]]; 
%        end
%     end
% 
% 
%     imposter_data = imposters(imposter_indices,:);
%     imposter_data = imposter_data(imposter_data > zero_far, :);
% 
%     train_data = [genuines(train_idx, :) ; imposter_data];
%     [train_data, mu, sigma] = zscore(train_data);
% 
%     labels = ones(length(train_data), 1);
%     labels(length(train_idx)+1:end) = -1;

    [train_data, labels , mu, sigma] = get_train_data(testing, veins, genuines, imposters, num_imposters, num_per_sample, outliers, zero_far);
    
    plotboundary(labels, train_data, svm(testing), 't')
end

