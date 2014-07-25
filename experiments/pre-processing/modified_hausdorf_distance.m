function [ mhd ] = modified_hausdorf_distance( a, b )
%UNTITLED5 Summary of this function goes here
%   a and b can be complex or real
%   MHD is basically the distance taken between the n closest points, where
%   n is the length of the smaller vector

if ( length (a) > length (b) )
    n = length (b);
else
    n = length (a);
end

mhd = 0;
% The three loops are intentional
% We are finding the best two points which match
% If we only had two loops, would be finding the points in B which best
% matches the ith point in A
% But by third loop, we find the optimal point in A to compare the distance
% with

for i = 1 : length (a)
    
   minLength = Inf;
   minIndexA = 0;
   minIndexB = 0;
   
   for k = 1 : length(a)
        for j = 1 : length (b) 
            dist = norm (a(k, :) - b(j, :) );
            if (dist < minLength)
                minIndexA = k;
                minIndexB = j;
                minLength = dist;
                
                if (dist == 0)
                    % won't do that much, still one outer loop left
                    break;
                end
            end
        end
   end
   
   if (minLength == Inf)
        % happens if length (a) > length (b)
       break
   end
   
   mhd = mhd + norm (a(minIndexA, :) - b(minIndexB, :) );
   a(minIndexA, :) = Inf;
   b(minIndexB, :) = Inf;
   mhd = mhd / n;
end


end

