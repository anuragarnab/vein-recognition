function [ score ] = get_score( cluster, points, fraction )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%     score = 0;
%     for i = 1:size(points,1)
%        score = score + distance_to_cluster(cluster, [points(i, :)]); 
%     end
    
    if (nargin < 3)
       fraction = sum(isnan(cluster(:,1))) / length(cluster);
    end

    dis = zeros(length(points), 1);
    for i = 1:size(points,1)
       dis(i) = distance_to_cluster(cluster, [points(i, :)]); 
    end
    
    dis = sort (dis, 'ascend');
    num_points = floor(fraction * length(points));
    dis = dis(1:num_points, :);
    score = sum(dis);
    
    score = score / num_points;

end


