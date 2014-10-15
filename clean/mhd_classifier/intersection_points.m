function [ x y ] = intersection_points( branches, plot )
%intersection_points Returns the x,y co-ordinates of the bifurcation points
    
    if (nargin < 2)
       plot = 0; 
    end
    
    x = zeros ( sum (sum (branches) ), 1 );
    y = zeros ( sum ( sum(branches) ), 1 );
    index = 1;
    
    for row = 1:size (branches, 1)
        for col = 1:size (branches, 2)
           
            if (branches(row, col) == 1)
                x(index) = col;
                y(index) = row;
                index = index + 1;
            end
        end
    end
    
    if (plot)
        figure
        scatter (x, y);
    end

end

