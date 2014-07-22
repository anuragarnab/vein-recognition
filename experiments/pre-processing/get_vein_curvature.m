function [ veins ] = get_vein_curvature( image, sigma, region )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
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

