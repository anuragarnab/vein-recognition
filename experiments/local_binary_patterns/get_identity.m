function [ chosen, min_score ] = get_identity( index, veins )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    d = get_distances (index, veins);
    
    [val, idx] = sort (d, 'ascend');
    chosen = idx(1);
    min_score = val(1);

end