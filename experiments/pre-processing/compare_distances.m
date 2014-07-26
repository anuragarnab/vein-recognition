function [ score, matches ] = compare_distances( d1, d2, a1, a2, epsilon_d, epsilon_a, verbose)
%UNTITLED13 Summary of this function goes here
%   Detailed explanation goes here

%Find the length of the shortest feature vector
%v1 and v2 are tehe two feature vectors, with v1 being the shorter one and
%v2 the longer one

if (nargin < 7)
    verbose = 0;
end

if (length (d1) < length (d2) )
    v1 = d1;
    v2 = d2;
    
    va1 = a1;
    va2 = a2;
else
    v1 = d2;
    v2 = d1;
    
    va1 = a2;
    va2 = a1;
end

matches = 0;

for i = 1:size (v1, 1)
    for j = 1:size (v2, 1)
        
        if ( (abs (v1(i) - v2(j) ) < epsilon_d) && ( abs( va1(i) - va2(j) ) < epsilon_a ) )
            %fprintf('[%i ] matched to [%i ]', v1(i, :), v2(j, :));
            
            if (verbose)
                fprintf ('[Distance angle] %0.3f, %0.3f matched to %0.3f, %0.3f\n', v1(i), va1(i), v2(j), va2(j) );
            end
            
            matches = matches + 1;
            v2(j) = Inf; % Effectively removes this entry from the list
            break;
        end
    end
end

score = matches / size(v1, 1);
% Should account for size of both images being tested. This is unfair when
% comparing against another image with a lot of branch points.

%score = matches / (size (v1, 1) * size(v2, 2) );

end

