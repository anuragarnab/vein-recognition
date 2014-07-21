function [ accumulator ] = m( image, y, x, threshold, window_size, verbose )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

accumulator = 0;
[rows cols] = size (image);

if (nargin < 6)
   verbose = 0; 
end

for window_row = -window_size : window_size
    
    py = y + window_row;   
    if (py < 1 || py > rows)
       continue; 
    end
    
    for window_col = -window_size : window_size
    
        px = x + window_col; 
        if (px < 1 || px > cols)
           continue; 
        end
        
        % so now we know that our px and py values are valid for the image
        if (distance_function ([x y], [px py]) > window_size )
            continue;
        end
        
        if (verbose)
            fprintf ('Testing [%i, %i] \n', py, px);
        end
        
        if ( (image(py, px) - image(y,x) ) <= threshold )
           accumulator = accumulator + 1; 
        end
    
    end
end
        
end

