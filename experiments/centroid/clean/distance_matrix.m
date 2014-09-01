function [ distances_centroid, imp_distances_centroid] = distance_matrix( clusters1, clusters2, clusters3, clusters4, clusters5, clusters6, veins, veins_unreg, users, images_per_user )
%UNTITLED Summary of this function goes here
%   Very crude way of doing cross validation testing with three folds

if (nargin < 9)
   users = 100; 
end

if (nargin < 10)
   images_per_user = 6; 
end

distances_centroid = zeros(length(veins), length(clusters1)); % make a square matrix
imp_distances_centroid = zeros(length(veins), length(clusters1));

for i = 0:(users-1)
%     for row = [i*images_per_user+2 i*images_per_user+5]
%         for col = 1:length(clusters1)
%             distances_centroid(row,col) = get_score(clusters1(col).cluster, [veins(row).x veins(row).y]);
%             imp_distances_centroid(row,col) = get_score(clusters1(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
%         end
%     end
%     
%     for row = [i*images_per_user+1 i*images_per_user+4]
%         for col = 1:length(clusters2)
%             distances_centroid(row,col) = get_score(clusters2(col).cluster, [veins(row).x veins(row).y]);
%             imp_distances_centroid(row,col) = get_score(clusters2(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
%         end
%     end
%     
%     for row = [i*images_per_user+3 i*images_per_user+6]
%         for col = 1:length(clusters3)
%             distances_centroid(row,col) = get_score(clusters3(col).cluster, [veins(row).x veins(row).y]);
%             imp_distances_centroid(row,col) = get_score(clusters3(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
%         end
%     end

    for row = [i*images_per_user+1]
        for col = 1:length(clusters1)
            distances_centroid(row,col) = get_score(clusters1(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters1(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end
    
    for row = [i*images_per_user+2]
        for col = 1:length(clusters2)
            distances_centroid(row,col) = get_score(clusters2(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters2(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end
    
    for row = [i*images_per_user+3]
        for col = 1:length(clusters3)
            distances_centroid(row,col) = get_score(clusters3(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters3(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end
    
    for row = [i*images_per_user+4]
        for col = 1:length(clusters4)
            distances_centroid(row,col) = get_score(clusters4(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters4(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end
    
    for row = [i*images_per_user+5]
        for col = 1:length(clusters5)
            distances_centroid(row,col) = get_score(clusters5(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters5(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end
    
    for row = [i*images_per_user+6]
        for col = 1:length(clusters6)
            distances_centroid(row,col) = get_score(clusters6(col).cluster, [veins(row).x veins(row).y]);
            imp_distances_centroid(row,col) = get_score(clusters6(col).cluster, [veins_unreg(row).x veins_unreg(row).y]);
        end
    end

    save centroid_distances distances_centroid imp_distances_centroid;

end


end

