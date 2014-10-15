function [ id, distance, distances ] = test_identity( chosen, hd_fraction, veins )
%UNTITLED Find the index in the training database which has the lowest distance to the chosen image
% We discard the chosen image compared to itself
% Returns the index of the closest image in the database, the distance (matching score) to it, and the complete distance vector to all items in the training database as well
distances = zeros (length(veins), 1);

for j = 1:length (veins)
    
    distances(j) = mhd_fast ( [chosen.x chosen.y], [veins(j).x veins(j).y], hd_fraction);

end

t = distances;
t (t == 0) = Inf;
[distance id] = min(t);

end

