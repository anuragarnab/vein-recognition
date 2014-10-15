function [ distances_ulbp_chi, imp_distances_ulbp_chi] = distance_matrix( veins, veins_unreg )
%distance_matrix Creates the genuine and imposter distance matrices (or score matrices)
% This was described at length in Chapter 3.4 of the report
% Returns the distance matrix / score matrix of both genuine enrolled images and imposter, unenrolled images

fprintf('Percent complete: ');
distances_ulbp_chi = zeros(length(veins)); % make a square matrix
imp_distances_ulbp_chi = zeros(length(veins_unreg));

for row = 1:length(distances_ulbp_chi)
    for col = 1:length(distances_ulbp_chi)

	distances_ulbp_chi(row,col) = distChiSquareFast( veins(row).ulbp_hist, veins(col).ulbp_hist);
	imp_distances_ulbp_chi(row,col) = distChiSquareFast( veins(row).ulbp_hist, veins_unreg(col).ulbp_hist);

    end
    
    fprintf('\%0.2f ',100*row/length(veins)); 
end


end

