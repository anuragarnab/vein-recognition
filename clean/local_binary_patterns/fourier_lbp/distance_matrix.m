function [ distances_flbp, imp_distances_flbp] = distance_matrix( veins, veins_unreg )
%distance_matrix Creates the genuine and imposter distance matrices (or score matrices)
% This was described at length in Chapter 3.4 of the report
% Returns the distance matrix / score matrix of both genuine enrolled images and imposter, unenrolled images

fprintf('Percent complete: ');
distances_flbp = zeros(length(veins)); % make a square matrix
imp_distances_flbp = zeros(length(veins_unreg));

for row = 1:length(distances_flbp)
    for col = 1:length(distances_flbp)

	distances_flbp(row,col) = euclid_rows( veins(row).flbp, veins(col).flbp);
	imp_distances_flbp(row,col) = euclid_rows( veins(row).flbp, veins_unreg(col).flbp);

    end
    
    fprintf('\%0.2f ',100*row/length(veins)); 
end


end

