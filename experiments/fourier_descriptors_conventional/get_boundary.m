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
           lhs = [row(indices) col(indices)];
        elseif (length(indices)>2 && i == size(finger,2) )
           rhs = [row(indices) col(indices)];
        else
           % means its along the top or bottom row
           if ( length(indices) ~= 2)
              fprintf ('Artifacts remained in this one \n'); 

              for i=1:length(indices)
                r = row(indices(i));
                if (r < size(finger,1)/2)
                    top = [top ; row(indices(i)) col(indices(i))];
                else
                    bottom = [bottom ; row(indices(i)) col(indices(i))];
                end
              end

             % temp = find(row(indices) < size(finger,2)/2 );
             % top = [top ; row(temp(1)) col(temp(1))];

             % temp = find(row(indices) >= size(finger,2)/2 );
             % bottom = [bottom ; row(temp(1)) col(temp(1))];
           elseif (row(indices(1)) < row(indices(2)) )
               top = [top ; row(indices(1)) col(indices(1))];
               bottom = [bottom ; row(indices(2)) col(indices(2))];
           else
               bottom = [bottom ; row(indices(1)) col(indices(1))];
               top = [top ; row(indices(2)) col(indices(2))];
           end
        end
        
    end
    
    %boundary = [lhs ; top ; rhs ; bottom];
    
    % order is very important! must get it to be circular!
    boundary = [top ; rhs ; bottom(end:-1:1,:) ; lhs(end:-1:1,:)];
end

