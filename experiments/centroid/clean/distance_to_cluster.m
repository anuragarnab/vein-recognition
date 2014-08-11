function [ distance ] = distance_to_cluster( cluster, data )
%DISTANCE_TO_CLUSTER Find the distance from a point to the nearest centroid
%of a cluster
%   "Data" must be a row vector. Dimension must be equal to one row of the
%   cluster
    distance = Inf;
    
    for i = 1:size(cluster,1)
       temp_dist = norm (cluster(i,:) - data); 
       if (temp_dist < distance)
          distance = temp_dist; 
       end
    end

end

