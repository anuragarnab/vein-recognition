function [ distances_centroid, imp_distances_centroid] = distance_matrix( clusters, veins, veins_unreg )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

distances_centroid = zeros(length(veins), length(clusters)); % make a square matrix
imp_distances_centroid = zeros(length(veins), length(clusters));

for row = 1:length(distances_centroid)
    for col = 1:length(clusters)
        distances_centroid(row,col) = get_score(clusters(col).cluster, [veins(row).x veins(row).y]);
        imp_distances_centroid(row,col) = get_score(clusters(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        if (mod(col,100) == 0)
           save centroid_distances distances_centroid imp_distances_centroid;
        end
    end
    
    fprintf('\n%i \n',row); 
end


end

