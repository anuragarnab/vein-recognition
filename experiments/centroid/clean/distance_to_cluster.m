function [ distance ] = distance_to_cluster( cluster, data, histogram )
%DISTANCE_TO_CLUSTER Find the distance from a point to the nearest centroid
%of a cluster
%   "Data" must be a row vector. Dimension must be equal to one row of the
%   cluster
    distance = Inf;

    if (nargin < 3)
        histogram = ones(size(cluster,1));
    end
    
    for i = 1:size(cluster,1)
       temp_dist = norm(cluster(i,:) - data)/histogram(i); 
       if (temp_dist < distance)
          distance = temp_dist; 
       end
    end

end

