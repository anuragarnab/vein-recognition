filenames = ['images/11.bmp' ; 'images/12.bmp' ; 'images/13.bmp' ; 'images/21.bmp' ; 'images/22.bmp' ; 'images/31.bmp' ; 'images/32.bmp'];

veins = {}; % create a struct to store the vein data

for i = 1:size(filenames, 1)
    
   image = get_roi (filenames (i, :) ); 
   veins(i).vein = get_vein(image); 
   [skeleton branchpoints] = get_skeleton (veins(i).vein);
   veins(i).skeleton = skeleton;
   veins(i).branchpoints = branchpoints;
   [x y] = intersection_points (veins(i).branchpoints);
   veins(i).x = x;
   veins(i).y = y;
   
   [distances angles] = distance_combinations (x, y);
   veins(i).distances = distances;
   veins(i).angles = angles;
end

%chosen = 3;

%for j = 1:size(veins, 2)
%for j = 2:2
    %compare_intersection_points (veins(chosen).x, veins(chosen).y, veins(j).x, veins(j).y, 10)
%[score, matches] = compare_distances (veins(chosen).distances, veins(j).distances, veins(chosen).angles, veins(j).angles, 1, 0.05);
%[matches, score]
%end