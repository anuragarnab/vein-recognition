function [ lbp ] = get_lbp( filename, scale, use_extracted_vein )
%Returns standard LBP8,1 - Radius of 1, sample all 8 pixels around it
%   Detailed explanation goes here
    if (nargin < 3)
       use_extracted_vein = 1; 
    end

    image = get_roi(filename);
    
    image = imresize(image, scale);
    
    if (use_extracted_vein)
        image = get_vein_curvature (image) ; 
    end

    lbp = local_binary_patterns(image);
    lbp = uint8(lbp);

end

