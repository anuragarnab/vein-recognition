function [ mhd ] = mhd_fast( a, b )
%UNTITLED6 Summary of this function goes here
%   a and b must be column vectors

% Pre-compute all the distances first

distance_matrix = zeros ( length (a), length (b) );
mhd = 0;

for row = 1:length (a)
    for col = 1:length (b)
    
        distance_matrix (row, col) = norm ( a(row, :) - b(col, :) );
        
    end
end

% Now the distance matrix has been filled. Time to find the n smallest
% entries
% We can only take one entry from each column

if ( length (a) < length (b) )
    n = length(a);
else
    n = length(b);
end


if ( size(distance_matrix, 2) > size (distance_matrix, 1) )
   distance_matrix = distance_matrix'; 
end
%distance_matrix

min_lengths = min (distance_matrix);
mhd = sum (min_lengths);
mhd = mhd/n;


end

