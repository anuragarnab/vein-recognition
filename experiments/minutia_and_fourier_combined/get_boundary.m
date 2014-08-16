function [ boundary ] = get_boundary( finger )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    finger = bwmorph (finger, 'remove');
    [row, col] = find (finger > 0);
    
    lhs = [];
    top = [];
    rhs = [];
    bottom = [];
    
    for i = 1:size(finger,2)
        indices = find(col==i);
        if (length(indices) > 2 && i == 1)
           % means its the start or end column 
           top = [row(indices) col(indices)];
        elseif (length(indices)>2 && i == size(finger,2) )
           rhs = [row(indices) col(indices)];
        else
           % means its along the top or bottom row
           if ( length(indices) ~= 2)
              fprintf ('ERROR \n'); 
           end
           
           if (row(indices(1)) < row(indices(2)) )
               top = [top ; row(indices(1)) col(indices(1))];
               bottom = [bottom ; row(indices(2)) col(indices(2))];
           else
               bottom = [bottom ; row(indices(1)) col(indices(1))];
               top = [top ; row(indices(2)) col(indices(2))];
           end
        end
        
    end
    
    boundary = [lhs ; top ; rhs ; bottom];

end

