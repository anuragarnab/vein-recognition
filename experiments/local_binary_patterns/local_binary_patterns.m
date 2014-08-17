function [ lbp ] = local_binary_patterns( image )
%UNTITLED2 Do the default 3x3 lbp for now

%following the same order as the previous one
cols = [-1 -1 0 1 1  1 0 -1];
rows = [0   1 1 1 0 -1 -1 -1]; 

lbp = zeros(size(image));

% assuming 3x3 grid, we have to start with a padding of one
for row = 2:size(image,1)-1
    for col = 2:size(image,2)-1
        for i = 1:length(cols)
           rd = rows(i);
           cd = cols(i);
           pixel = image(row+rd, col+cd);
           temp = pixel>image(row,col);
           lbp(row,col) = lbp(row,col) + temp*2^(i-1);
        end
    end
end


end

