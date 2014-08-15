function [ id, distance, distances ] = test_identity( chosen, hd_fraction, veins, indices_to_check )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

if (nargin < 4)
   indices_to_check = 1:length(veins); 
end

distances = zeros (length(veins), 1); % So distances could be a lot longer than actual indices being checked. Thats ok though, since all the zeros will get changed to Infinity anyway

for j = indices_to_check
    distances(j) = mhd_fast ( [veins(chosen).x veins(chosen).y], [veins(j).x veins(j).y], hd_fraction);
end

t = distances;
t (t == 0) = Inf;
[distance, id] = min(t);

end

