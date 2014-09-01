function [ genuines, imposters ] = distribution_tester( distances, num_per_sample, ignore_zero )
%UNTITLED3 Summary of this function goes here
%   Genuine is a vector of the best scores with a correct match
%   Imposter is a vector of ALL the scores with imposters

if (nargin < 2)
   num_per_sample = 6; 
end

if (nargin < 3)
   ignore_zero = 1; 
end

n = size(distances, 1); % In case matrix is not square (ie k-means)
imposters = [];
genuines = [];

for i = 1:n
   dis = distances(i,:);
   [~, idx] = sort(dis, 'ascend');

   [start, finish] = get_limits(i, num_per_sample);
    
   imposters_idx = idx(idx <= start | idx > finish);
   imposter_distances = dis (imposters_idx);
   imposters = [imposters imposter_distances];
    
   correct_idx = idx(idx > start | idx <= finish);
   
   ix = 1;
   if (ignore_zero) ix=ix+1; end;
   genuines = [genuines dis(correct_idx(ix))]; % correct_idx is in sorted order of value
   
end

end

