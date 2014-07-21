chosen = 6;

for j = 1:length (veins)
    cross_corr_normalised ( veins(chosen).vein, veins(j).vein )
end
    %compare_intersection_points (veins(chosen).x, veins(chosen).y, veins(j).x, veins(j).y, 10)
%[score, matches] = compare_distances (veins(chosen).distances, veins(j).distances, veins(chosen).angles, veins(j).angles, 1, 0.05);
%[matches, score]
%end