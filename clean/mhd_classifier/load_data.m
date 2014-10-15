% Adjust the parameter of "rdir" to that of the path where the database
% images are stored.

disp ('Please ensure that the correct directory for the vein database has been chosen. An absolute directory is required');

files = rdir ('C:\\Users\\Anurag\\Documents\\4th Year\\EEE4022S\\Vein Recognition\\Fingerprint Databases\\Finger Vein Database - Shangdon University\**\**\*.bmp');

veins = {};
veins_unreg = {}; % create a struct to store the vein data

counter = 1;

disp('Loading images into database. 600 will be registered users. The other 600 are unregistered. These unregistered users will not have features extracted and will not be enrolled into the training database');

% The unregistered images can just be from the index finger.
% The registeed images are taken from the middle finger

for i = 1:100
    %left_hand_index_1 = 1 +36k
    %left_hand_index_2 = 2 +36k ...
    
    k = i - 1;
    for j = 1:6 
        
       image = get_roi ( files(j + 36*k).name );        
       veins_unreg(counter).vein = get_vein_curvature (image) ; 

       [skeleton branchpoints] = get_skeleton (veins_unreg(counter).vein);
       veins_unreg(counter).skeleton = skeleton;
       veins_unreg(counter).branchpoints = branchpoints;
       [x y] = intersection_points (branchpoints);
       veins_unreg(counter).x = x;
       veins_unreg(counter).y = y;

       [distances angles] = distance_combinations (x, y);
       veins_unreg(counter).distances = distances;
       veins_unreg(counter).angles = angles;
             
       veins_unreg(counter).filename = files(j+36*k).name;
       veins_unreg(counter).image = imread(veins_unreg(counter).filename);
       
       counter = counter + 1;
    end
       
end

counter = 1;

for i = 1:100
    %left_hand_middle_1 = 7 +36k
    %left_hand_middle_2 = 8 +36k ...
    k = i - 1;
    
    for j = 7:12
       image = get_roi ( files(j + 36*k).name );   
       veins(counter).vein = get_vein_curvature (image) ; 

       [skeleton branchpoints] = get_skeleton (veins(counter).vein);
       veins(counter).skeleton = skeleton;
       veins(counter).branchpoints = branchpoints;
       [x y] = intersection_points (branchpoints);
       veins(counter).x = x;
       veins(counter).y = y;

       [distances angles] = distance_combinations (x, y);
       veins(counter).distances = distances;
       veins(counter).angles = angles;
       
       veins(counter).filename = files(j+36*k).name;
       veins(counter).image = imread(veins(counter).filename);
       
       counter = counter + 1;
    end
end

disp('Complete');