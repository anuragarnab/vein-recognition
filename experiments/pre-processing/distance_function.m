function [ distance ] = distance_function( v1, v2)
%The cost function used when comparing branchpoints
%v1 and v2 are intersection points to compare. They are expected to be 1x2
%vectors

%distance =  sum(abs(v1 - v2));
distance = norm (v1 - v2);

end

