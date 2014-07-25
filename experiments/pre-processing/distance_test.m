clc
chosen = 9;

%for j = 1:length (veins_c)
%    [score, matches] = compare_distances (veins_c(chosen).distances, veins_c(j).distances, veins_c(chosen).angles, veins_c(j).angles, 1, 0.05);
%    [matches, score]
%end

for j = 1:length (veins_c)
    
    cx = veins_c(chosen).x - mean (veins_c(chosen).x);
    cy = veins_c(chosen).y - mean (veins_c(chosen).y);
    
    vx = veins_c(j).x - mean (veins_c(j).x);
    vy = veins_c(j).y - mean (veins_c(j).y);
    
    modified_hausdorf_distance ([cx, cy], [vx, vy])
    %modified_hausdorf_distance ([veins_c(chosen).x veins_c(chosen).y], [veins_c(j).x veins_c(j).y])
end