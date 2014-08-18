function [ id ] = identify( vein, veins, threshold, loo, index )
%UNTITLED12 Summary of this function goes here
%   Detailed explanation goes here

    if (nargin < 4)
        % assumes we are not doing LOO on the training data
        loo = 0;
    end
    
    if (loo)
        [id, score] = get_identity(vein, veins, index);
    else
        [id, score] = get_identity(vein, veins);
    end
    
    if (score > threshold)
        id = -1;
    end

end

