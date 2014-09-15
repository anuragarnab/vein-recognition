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

    [train_data, labels , mu, sigma] = get_train_data(testing, veins, genuines, imposters, num_imposters, num_per_sample, outliers, zero_far);
    
    plotboundary(labels, train_data, svm(testing), 't')
end

