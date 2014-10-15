function [ veins ] = get_vein_curvature( image, sigma, region )
%get_vein_curvature Segment the veins using Miura's Maximum Curvature approach
%   This is just a wrapper function
%   sigma is a parameter for the vein segmentation algorithm
%	"region" is a mask for the input image. By default, we consider the entire image
    
    if (nargin < 2)
       sigma = 3;
       region = ones (size (image) );
    end

    image = im2double (image);
    veins = miura_max_curvature (image, region, sigma);
    
    % threshold the image using the median value of pixels greater than 0
    med = median(veins(veins>0));
    veins = veins > med; % pixels will either be 1 or 0. 
    
end

