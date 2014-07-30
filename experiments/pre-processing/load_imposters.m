files = rdir ('C:\\Users\\Anurag\\Documents\\4th Year\\EEE4022S\\Vein Recognition\\Fingerprint Databases\\Finger Vein Database - Shangdon University\**\**\*.bmp');

veins_unreg = {}; % create a struct to store the vein data

region = ones (81, 320); % for compatibility with the code I'm using (will change this)
sigma = 3; % will play around with this
counter = 1;


% The unregistered ones can just be from the index finger as opposed to the
% middle finger
for i = 1:100
    %left_hand_index_1 = 1 +36k
    %left_hand_index_2 = 2 +36k
    
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
       
       counter = counter + 1;
    end
    
end
