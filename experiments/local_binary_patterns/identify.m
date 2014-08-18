function [ id ] = identify( index, veins, threshold, loo )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

    if (nargin < 3)
        % assumes we are doing LOO on the training data
        loo = 1;
    end
    
    if (loo)
        [id, score, ~] = get_identity(index, veins);
    else
        [id, score, ~] = get_identity(index, veins_cv);
    end
    
    if (score > threshold)
        id = -1;
    end

end

