function [ distances_mhd_rel, imp_distances_mhd_rel] = distance_matrix( veins, veins_unreg, mhd_fraction )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

distances_mhd_rel = zeros(length(veins)); % make a square matrix
imp_distances_mhd_rel = zeros(length(veins));

for row = 1:length(distances_mhd_rel)
    for col = 1:length(distances_mhd_rel)
        distances_mhd_rel(row,col) = mhd_fast ( [veins(row).distances], [veins(col).distances], mhd_fraction);
        imp_distances_mhd_rel(row,col) = mhd_fast ( [veins(row).distances], [veins_unreg(col).distances], mhd_fraction);
        if (mod(col,100) == 0)
           fprintf('%i ',col);
           save mhd_relative_distances_point2 distances_mhd_rel imp_distances_mhd_rel;
        end
    end
    
    fprintf('\n%i \n',row); 
end


end

