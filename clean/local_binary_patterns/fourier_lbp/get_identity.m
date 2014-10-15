function [ chosen, min_score] = get_identity( vein, veins, threshold, index)
%get_identity Determine identity of a vein image
% Image is compared to all others in database
% It is identified if the matching score is less than the threshold
% "index" is ignored so that a vein image is not matched to itself when we are performing LOO testing. 
    
    if (nargin < 3)
       index = 0; 
    end

    d = get_distances (vein, veins, index);
    
    [val, idx] = sort (d, 'ascend');
    chosen = idx(1);
    min_score = val(1);
    
    if (min_score > threshold)
       chosen = -1; 
    end

end