function [ lbp ] = get_lbp( filename, scale )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    image = get_roi(filename);
    
    image = imresize(image, scale);
    
    % Could add some denoising code here
    lbp = local_binary_patterns(image);
    lbp = uint8(lbp);

end

