files = rdir ('C:\\Users\\Anurag\\Documents\\4th Year\\EEE4022S\\Vein Recognition\\Fingerprint Databases\\Finger Vein Database - Shangdon University\**\**\*.bmp');

veins = {}; % create a struct to store the vein data
veins_cv = {};

region = ones (81, 320); % for compatibility with the code I'm using (will change this)
sigma = 3; % will play around with this
counter = 1;

for i = 1:100
    %left_hand_index_1 = 1 +36k
    %left_hand_index_2 = 2 +36k
    
    k = i - 1;
    for j = 1:5 
        
       image = get_roi ( files(6 + j + 36*k).name );        
       veins(counter).vein = get_vein_curvature (image) ; 

       [skeleton branchpoints] = get_skeleton (veins(counter).vein);
       veins(counter).skeleton = skeleton;
       veins(counter).branchpoints = branchpoints;
       [x y] = intersection_points (veins(counter).branchpoints);
       veins(counter).x = x;
       veins(counter).y = y;

       [distances angles] = distance_combinations (x, y);
       veins(counter).distances = distances;
       veins(counter).angles = angles;
       
       veins(counter).filename = files(6+j+36*k).name;
       
       counter = counter + 1;
    end
    
    % Now load one cross-validation image
        
       index = floor (counter / 5); 
       
       image = get_roi ( files(6 + 6 + 36*k).name );        
       veins_cv(index).vein = get_vein_curvature (image) ; 

       [skeleton branchpoints] = get_skeleton (veins_cv(index).vein);
       veins_cv(index).skeleton = skeleton;
       veins_cv(index).branchpoints = branchpoints;
       [x y] = intersection_points (veins_cv(index).branchpoints);
       veins_cv(index).x = x;
       veins_cv(index).y = y;

       [distances angles] = distance_combinations (x, y);
       veins_cv(index).distances = distances;
       veins_cv(index).angles = angles;
       
       veins_cv(index).filename = files(6+4+36*k).name;


end
