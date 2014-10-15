function [ mhd ] = mhd_fast( a, b, fraction )
%mhd Compute the Modified Hausdorff Distance (MHD) between two matrices,
%"a" and "b".
% "a" is an n x d matrix.
% "b" is a m x d matrix.
% m and n do not have to be equal, although they can. Each row is a
% separate point.
% fraction is the "f" parameter described in Chapter 4.3

if (nargin < 3)
   fraction = 1; 
end

%% The slow way of computing the distance matrix
% distance_matrix = zeros ( length (a), length (b) );
% mhd = 0;
% 
% for row = 1:length (a)
%     for col = 1:length (b)
%     
%         distance_matrix (row, col) = norm ( a(row, :) - b(col, :) );
%         
%     end
% end

%% The quicker, vectorised implementation
% Vectorised way to create distance matrix
% However, note that we have to hard-code the dimensionality of the vectors
% into "bsxfun." This does however give a speed-up
mhd = 0;
distance_matrix = sqrt(bsxfun(@minus,a(:,1),b(:,1).').^2 + bsxfun(@minus,a(:,2),b(:,2).').^2);

%% The number of points which we consider is f x n where n is the length of the smallest vector
if ( length (a) < length (b) )
    n = length(a);
else
    n = length(b);
end

total = ceil( n * fraction);
% if (fraction == 1)
%    total = n; 
% end

%% Iteratively match the two closest points in the point sets. 
% Remove their entries from the distance matrix so that they are not matched again
for j = 1:total
       
   minMatrix = min (distance_matrix(:));
   [row_index, col_index] = find(distance_matrix == minMatrix, 1);
   
   distance_matrix (row_index, :) = Inf;
   distance_matrix (:, col_index) = Inf;
   
   mhd = mhd + minMatrix;
end

mhd = mhd/total;

end

