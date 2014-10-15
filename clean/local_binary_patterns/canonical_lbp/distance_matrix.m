function [ distances_hamming, imp_distances_hamming] = distance_matrix( veins, veins_unreg )
%distance_matrix Creates the genuine and imposter distance matrices (or score matrices)
% This was described at length in Chapter 3.4 of the report
% Returns the distance matrix / score matrix of both genuine enrolled images and imposter, unenrolled images

fprintf('Percent complete: ');
distances_hamming = zeros(length(veins)); % make a square matrix
imp_distances_hamming = zeros(length(veins_unreg));

for row = 1:length(distances_mhd_rel)
    for col = 1:length(distances_mhd_rel)

        distances_hamming(row,col) = bitwise_hamming(veins(row).lbp(:), veins(col).lbp(:));
		imp_distances_hamming(row,col) = bitwise_hamming(veins(row).lbp(:), veins_unreg(col).lbp(:));

    end
    
    fprintf('\%0.2f ',100*row/length(veins)); 
end


end

