function [ mhd ] = modified_hausdorf_distance( a, b, fraction, verbose )
%UNTITLED5 Summary of this function goes here
%   a and b can be complex or real
%   MHD is basically the distance taken between the n closest points, where
%   n is the length of the smaller vector

if (nargin < 4)
   verbose = 0; 
end

if (nargin < 3)
   fraction = 1; 
end

if ( length (a) > length (b) )
    n = length (b);
    v1 = b;
    v2 = a;
else
    n = length (a);
    v1 = a;
    v2 = b;
end

mhd = 0;
% The three loops are intentional
% We are finding the best two points which match
% If we only had two loops, would be finding the points in B which best
% matches the ith point in A
% But by third loop, we find the optimal point in A to compare the distance
% with

total = round(length(v1) * fraction);

for i = 1 : length(a)
    
   minLength = Inf;
   minIndexA = 0;
   minIndexB = 0;
   
   for k = 1 : length(v1)
        for j = 1 : length (v2) 
            dist = norm (v1(k, :) - v2(j, :) );
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
   
   %if (minLength == Inf)
        % happens if length (a) > length (b)
   %    break
   %end
   
   if (verbose)
       fprintf ('Closest pair is [%i %i] and [%i %i] with distance %0.3f\n', v1(minIndexA, 1), v1(minIndexA, 2), v2(minIndexB, 1), v2(minIndexB, 2), norm(v1(minIndexA, :) - v2(minIndexB, :)) );
   end
   
   mhd = mhd + norm (v1(minIndexA, :) - v2(minIndexB, :) );
   v1(minIndexA, :) = Inf;
   v2(minIndexB, :) = Inf;
   
   if (i > total)
      break; 
   end
end

mhd = mhd / n;

end

