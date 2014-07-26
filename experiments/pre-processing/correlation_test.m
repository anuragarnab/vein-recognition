clc
chosen = 8;

for j = 1:length (veins_c)
    cross_corr_normalised ( veins_c(chosen).vein, veins_c(j).vein )
end
    %compare_intersection_points (veins(chosen).x, veins(chosen).y, veins(j).x, veins(j).y, 10)
%[score, matches] = compare_distances (veins(chosen).distances, veins(j).distances, veins(chosen).angles, veins(j).angles, 1, 0.05);
%[matches, score]
%end