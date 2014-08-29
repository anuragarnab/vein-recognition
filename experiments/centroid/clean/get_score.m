function [ score ] = get_score( cluster, points )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    score = 0;
    for i = 1:size(points,1)
       score = score + distance_to_cluster(cluster, [points(i, :)]); 
    end
    score = score / length(points);

end


