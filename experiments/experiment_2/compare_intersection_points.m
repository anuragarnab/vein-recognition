function [ score ] = compare_intersection_points( x1, y1, x2, y2, epsilon)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

%Find the length of the shortest feature vector
%v1 and v2 are tehe two feature vectors, with v1 being the shorter one and
%v2 the longer one
if (length (x1) < length (x2) )
    v1 = [x1 y1];
    v2 = [x2 y2];
else
    v1 = [x2 y2];
    v2 = [x1 y1];
end

matches = 0;

for i = 1:size (v1, 1)
    for j = 1:size (v2, 1)
        
        if ( distance_function ( v1(i, :), v2(j, :) ) < epsilon )
            %fprintf('[%i ] matched to [%i ]', v1(i, :), v2(j, :));
            fprintf ('[');
            fprintf ('%i ', v1(i, :) );
            fprintf ('matched to ');
            fprintf ('%i ', v2(j, :) );
            fprintf ('\n');
            
            matches = matches + 1;
            v2(j, :) = [Inf Inf]; % Effectively removes this entry from the list
            break;
        end
    end
end

score = matches / size(v1, 1);


end

