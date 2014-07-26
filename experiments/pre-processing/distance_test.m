clc
chosen = 189;
hd_fraction = 0.8;
distances = ones (length(veins), 1);

%for j = 1:length (veins_c)
%    [score, matches] = compare_distances (veins_c(chosen).distances, veins_c(j).distances, veins_c(chosen).angles, veins_c(j).angles, 1, 0.05);
%    [matches, score]
%end

for j = 1:length (veins)
    
    %cx = veins_c(chosen).x - mean (veins_c(chosen).x);
    %cy = veins_c(chosen).y - mean (veins_c(chosen).y);
    
    %vx = veins_c(j).x - mean (veins_c(j).x);
    %vy = veins_c(j).y - mean (veins_c(j).y);
    
    %modified_hausdorf_distance ([cx, cy], [vx, vy], hd_fraction)
    %modified_hausdorf_distance ([veins_c(chosen).x veins_c(chosen).y], [veins_c(j).x veins_c(j).y], hd_fraction)
    
    %distances(j) = modified_hausdorf_distance ( [veins(chosen).x veins(chosen).y], [veins(j).x veins(j).y], hd_fraction);
    %test = mhd_fast ( [veins(chosen).x veins(chosen).y], [veins(j).x veins(j).y], hd_fraction);
    %if ( distances(j) ~= test)
    %   fprintf ('Error %0.3f vs %0.3f \n', distances(j), test);
    %end
    
    distances(j) = mhd_fast ( [veins(chosen).x veins(chosen).y], [veins(j).x veins(j).y], hd_fraction);

end

t = distances;
t (t == 00) = Inf;
[val index] = min(t)