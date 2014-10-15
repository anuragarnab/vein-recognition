function [ distance ] = distance_function( v1, v2)
%The cost function used when comparing bifurcations
%v1 and v2 are intersection points to compare. They are expected to be 1x2
%vectors.

% Although trivial, it has been written as a separate function so that it can easily be changed

%distance =  sum(abs(v1 - v2));
distance = norm (v1 - v2);

end

