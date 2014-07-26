function [ id, distance, distances ] = test_identity( chosen, hd_fraction, veins )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
distances = ones (length(veins), 1);

%for j = 1:length (veins_c)
%    [score, matches] = compare_distances (veins_c(chosen).distances, veins_c(j).distances, veins_c(chosen).angles, veins_c(j).angles, 1, 0.05);
%    [matches, score]
%end

for j = 1:length (veins)
    
    distances(j) = mhd_fast ( [veins(chosen).x veins(chosen).y], [veins(j).x veins(j).y], hd_fraction);

end

t = distances;
t (t == 0) = Inf;
[distance id] = min(t);

end

