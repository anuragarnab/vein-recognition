function [ mhd ] = mhd_fast( a, b, fraction )
%UNTITLED6 Summary of this function goes here
%   a and b must be column vectors

% Pre-compute all the distances first

if (nargin < 3)
   fraction = 1; 
end

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

mhd = 0;
distance_matrix = sqrt(bsxfun(@minus,a(:,1),b(:,1).').^2 + bsxfun(@minus,a(:,2),b(:,2).').^2);

% Now the distance matrix has been filled. Time to find the n smallest
% entries
% We can only take one entry from each column

if ( length (a) < length (b) )
    n = length(a);
else
    n = length(b);
end


%if ( size(distance_matrix, 1) > size (distance_matrix, 2) )
%   distance_matrix = distance_matrix'; 
%end

total = round ( n * fraction);
if (fraction == 1)
   total = n-1; 
end

%[rows cols] = size(distance_matrix);
%distance_matrix = reshape (distance_matrix, rows * cols, 1);

for j = 1:total+1
       
   minMatrix = min (distance_matrix(:));
   [row_index, col_index] = find(distance_matrix == minMatrix, 1);
   
   distance_matrix (row_index, :) = Inf;
   distance_matrix (:, col_index) = Inf;
   
 %  fprintf ('Min %0.3f\n',  minMatrix);
   mhd = mhd + minMatrix;
end

%distance_matrix

% temps = zeros (size(distance_matrix, 1));
% 
% for j = 1:size(distance_matrix, 1)
%     temp = distance_matrix (j, :);
%     [min_length index] =  min(temp);
%     temps(j) = min_length;
%     distance_matrix (:, index) = Inf;
% end
% 
% total = round ( n * fraction);
% temps = sort (temps, 'ascend');
% mhd = sum ( temps(1:total) );

mhd = mhd/total;


end

