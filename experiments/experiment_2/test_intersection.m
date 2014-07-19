filenames = ['fv/1/01.jpg' ; 'fv/1/02.jpg' ; 'fv/2/01.jpg' ; 'fv/2/02.jpg' ; 'fv/3/01.jpg' ; 'fv/3/02.jpg' ; 'fv/4/01.jpg' ; 'fv/4/02.jpg'];

veins = {}; % create a struct to store the vein data

for i = 1:size(filenames, 1)
   veins(i).vein = get_vein(filenames(i, :)); 
   [skeleton branchpoints] = get_skeleton (veins(i).vein);
   veins(i).skeleton = skeleton;
   veins(i).branchpoints = branchpoints;
   [x y] = intersection_points (veins(i).branchpoints);
   veins(i).x = x;
   veins(i).y = y;
end

chosen = 7;

for j = 1:size(veins, 2)
%for j = 2:2
    compare_intersection_points (veins(chosen).x, veins(chosen).y, veins(j).x, veins(j).y, 10)
end