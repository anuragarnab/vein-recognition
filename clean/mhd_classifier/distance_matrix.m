function [ distances_mhd_rel, imp_distances_mhd_rel] = distance_matrix( veins, veins_unreg, mhd_fraction )
%distance_matrix Creates the genuine and imposter distance matrices (or score matrices)
% This was described at length in Chapter 3.4 of the report
% Returns the distance matrix / score matrix of both genuine enrolled images and imposter, unenrolled images

fprintf('Percent complete: ');
distances_mhd_rel = zeros(length(veins)); % make a square matrix
imp_distances_mhd_rel = zeros(length(veins_unreg));

for row = 1:length(distances_mhd_rel)
    for col = 1:length(distances_mhd_rel)

        distances_mhd_rel(row,col) = mhd_fast ( [veins(row).x veins(row).y], [veins(col).x veins(col).y], mhd_fraction);
        imp_distances_mhd_rel(row,col) = mhd_fast ( [veins(row).x veins(row).y], [veins_unreg(col).x veins_unreg(col).y], mhd_fraction);

%         if (mod(col,100) == 0)
%            fprintf('%i ',col);
%            save mhd_relative_distances_point2 distances_mhd_rel imp_distances_mhd_rel;
%         end
    end
    
    fprintf('\%0.2f ',100*row/length(veins)); 
end


end

