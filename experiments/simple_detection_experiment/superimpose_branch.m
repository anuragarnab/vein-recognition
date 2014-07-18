function [ rgb ] = superimpose_branch( image, branches )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
red_channel = image .* 255;
green_channel = image .* 255;
blue_channel = image .* 255;

for row = 1:size(image, 1)
    for col = 1:size(image, 2)
        if ( branches(row, col) == 1)
           red_channel(row, col) = 0;
           green_channel (row, col) = 1;
           blue_channel (row, col) = 0;
        end
    end
end

rgb = cat (3, red_channel, green_channel, blue_channel);

end

