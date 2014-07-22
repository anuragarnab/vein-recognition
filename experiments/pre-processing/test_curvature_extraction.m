filenames = ['images/11.bmp' ; 'images/12.bmp' ; 'images/13.bmp' ; 'images/21.bmp' ; 'images/22.bmp' ; 'images/31.bmp' ; 'images/32.bmp' ; 'images/41.bmp' ; 'images/42.bmp'];

veins_c = {}; % create a struct to store the vein data
region = ones (81, 320); % for compatibility with the code I'm using (will change this)
sigma = 3; % will play around with this

for i = 1:size(filenames, 1)
    
   image = get_roi (filenames (i, :) ); 
   
   veins_c(i).vein = get_vein_curvature (image) ; 
  
   [skeleton branchpoints] = get_skeleton (veins_c(i).vein);
   veins_c(i).skeleton = skeleton;
   veins_c(i).branchpoints = branchpoints;
   [x y] = intersection_points (veins_c(i).branchpoints);
   veins_c(i).x = x;
   veins_c(i).y = y;
   
   [distances angles] = distance_combinations (x, y);
   veins_c(i).distances = distances;
   veins_c(i).angles = angles;
end
