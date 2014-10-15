function [ far, frr ] = get_far_frr( corrects, negs, num_outliers )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
far = size(negs,1) - sum(negs);
frr = size(corrects,1) - sum(corrects) - num_outliers;

far = far ./ size(negs,1) .* 100;
frr = frr ./ (size(corrects,1) - num_outliers) .* 100;

end

