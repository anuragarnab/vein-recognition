function [ image ] = remove_edges( image )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    bottom_fraction = 2/3;
    top_fraction = 1/3;
    
    [image_rows, ~] = size(image);
    
    temp = bwmorph (image, 'remove');
    branchpoints = bwmorph (temp, 'branchpoints');
    [row, col] = find (branchpoints > 0);
    
    bottom_row = row ( row > bottom_fraction*image_rows);
    bottom_col = col (row > bottom_fraction*image_rows);
    
    top_row = row (row < top_fraction * image_rows);
    top_col = col (row < top_fraction * image_rows);
    
    for i = 1:length(bottom_row)
       image(bottom_row(i)+1:end, bottom_col(i)) = 0; 
    end

    for i = 1:length(top_row)
       image(1:top_row(i)-1, top_col(i)) = 0; 
    end
end

