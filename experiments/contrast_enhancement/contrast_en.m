function [ im ] = contrast_en( image, mu_desired, sigma_desired )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    mu = sum(sum(image));
    mu = mu / ( size(image,1) * size(image, 2) );
    
    sigma = (image - mu).^2;
    sigma = sum(sum(sigma));
    sigma = sigma / ( size(image,1) * size(image, 2) );
        
    for row = 1:size(image, 1)
       for col = 1:size(image, 2)
           
           temp = (image(row,col) - mu)^2;
           
           if( image(row, col) > mu)
              im(row, col) = mu_desired + sqrt ( double ((temp * sigma_desired) / sigma) ); 
           else
              im(row, col) = mu_desired - sqrt ( double ( (temp * sigma_desired) / sigma) );
           end
        
       end
    end
end

