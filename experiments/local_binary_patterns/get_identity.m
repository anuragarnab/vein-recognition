function [ chosen, min_score] = get_identity( vein, veins, index)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    
    if (nargin < 3)
       index = 0; 
    end

    d = get_distances (vein, veins, index);
    
    [val, idx] = sort (d, 'ascend');
    chosen = idx(1);
    min_score = val(1);
    %imposter_distances = val(2:end); % This is wrong
    
    % I used this bit to plot the distribution curves
    % Back in those days, the first parameter of the function was "index",
    % the index of the veins struct being searched
    % This function used to return imposter_distances as well
    
    %[start, finish] = get_limits(index, 6);
    %imposters_idx = idx(idx <= start | idx > finish);
    %imposter_distances = d (imposters_idx);

end