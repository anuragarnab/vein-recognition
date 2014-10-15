function [ score ] = get_score( cluster, points, histogram )
%get_score Computes Cluster Distance metric described in Chapter 4.3

    if (nargin < 3)
        histogram = ones(size(cluster,1));
    end

    dis = zeros(length(points), 1);
    for i = 1:size(points,1)
       dis(i) = distance_to_cluster(cluster, [points(i, :)], histogram); 
    end
    
    score = sum(dis);
    score = score / length(points);

end


