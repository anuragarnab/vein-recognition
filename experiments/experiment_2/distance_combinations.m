function [ distances, angles ] = distance_combinations( x, y )
%UNTITLED Summary of this function goes here
%   Computes all distance combinations between the points
%   x and y are vectors of the same length, ie N x 1
%   The result is an N x N matrix which has the length from x_i, y_i to
%   every other vector
%   Likewise, we do the same for the angles
%   In row i of the result matrix, each column is the distance from point i
%   (x_i, y_i_ to every other point in the matrix

%   It is only necessary to compute half of these entries, or n * (n - 1) /
%   2 entries (if one takes the combinations)


%%
% No use in doing the whole NxN matrix thing
%%
%     distances = zeros ( length (x), length (x) );
%     angles = zeros ( length (x), length (x) );
%     
%     for row = 1 : length (x)
%         
%        vector1 = [ x(row) ; y(row) ];
%         
%        for col = 1 : length (y)
%           
%            vector2 = [ x(col) ; y(col) ];
%            distance = distance_function ( vector1, vector2);
%            
%            distances (row, col) = distance;
%            %angles (row, col) = angle;
%            
%        end
%    end
    
n = length (x);
total = n * (n -1) / 2; % This is equal to nC2. Total number of possible combinations
distances = zeros (total, 1);
angles = zeros (total, 1);
counter = 1;

for row = 1 : length (x)
    
    vector1 = [ x(row) ; y(row) ];
    
    for col = row+1 : length (x)
       
        vector2 = [ x(col) ; y(col) ];
        distance = distance_function ( vector1, vector2);
        
        distances (counter) = distance;
        counter = counter + 1;
    end
end

end

