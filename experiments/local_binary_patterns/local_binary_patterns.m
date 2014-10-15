function [ lbp ] = local_binary_patterns( image )
%local_binary_patterns Computes LBP_8_1 (Canonical LBP) as described in Chapter 6 and 2

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

lbp = lbp(3:end-1,2:end-1); % Trim off the first and last columns since they are not considered. I actually trimmed the first two rows to have an even number of rows which is easier to subdivide


end

