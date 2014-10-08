% files = rdir ('C:\\Users\\Anurag\\Documents\\4th Year\\EEE4022S\\Vein Recognition\\Fingerprint Databases\\Finger Vein Database - Shangdon University\**\**\*.bmp');
% 
% v1_unreg = {}; % create a struct to store the vein data
% v1 = {};
% 
% region = ones (81, 320); % for compatibility with the code I'm using (will change this)
% sigma = 3; % will play around with this
% counter = 1;
% times = [];
% 
% tic;
% % The unregistered ones can just be from the index finger as opposed to the
% % middle finger
% for i = 1:100
%     %left_hand_index_1 = 1 +36k
%     %left_hand_index_2 = 2 +36k
%     
%     k = i - 1;
%     for j = 1:6 
%         
%        image = get_roi ( files(j + 36*k).name );        
%        v1_unreg(counter).vein = get_vein_curvature (image) ; 
% 
%        [skeleton branchpoints] = get_skeleton (v1_unreg(counter).vein);
%        v1_unreg(counter).skeleton = skeleton;
%        v1_unreg(counter).branchpoints = branchpoints;
%        [x y] = intersection_points (branchpoints);
%        v1_unreg(counter).x = x;
%        v1_unreg(counter).y = y;
% 
%        [distances angles] = distance_combinations (x, y);
%        v1_unreg(counter).distances = distances;
%        v1_unreg(counter).angles = angles;
%        
%        v1_unreg(counter).filename = files(j+36*k).name;
%        
%        counter = counter + 1;
%     end
%     
% end
% 
% 
% counter = 1;
% for i = 1:100
%     %left_hand_index_1 = 1 +36k
%     %left_hand_index_2 = 2 +36k
%     
%     k = i - 1;
%     for j = 1:6 
%         
%        image = get_roi ( files(j + 6 + 36*k).name );        
%        v1(counter).vein = get_vein_curvature (image) ; 
% 
%        [skeleton branchpoints] = get_skeleton (v1(counter).vein);
%        v1(counter).skeleton = skeleton;
%        v1(counter).branchpoints = branchpoints;
%        [x y] = intersection_points (branchpoints);
%        v1(counter).x = x;
%        v1(counter).y = y;
% 
%        [distances angles] = distance_combinations (x, y);
%        v1(counter).distances = distances;
%        v1(counter).angles = angles;
%        
%        v1(counter).filename = files(j+36*k).name;
%        
%        counter = counter + 1;
%     end
%     
% end
% 
% t = toc;
% times = [times t];
% 
% tic
% 
% mhd_frac = 0.7;
% [d,i] = distance_matrix(v1, v1_unreg, mhd_frac);
% 
% t = toc;
% times = [times t];