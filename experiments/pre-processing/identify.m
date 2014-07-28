function [ output_id ] = identify( chosen, hd_fraction, veins, threshold )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

    [id distance ~] = test_identity (chosen, hd_fraction, veins);
    
    if (distance < threshold)
       fprintf ('Identified as %i since distance was %0.3f', id, distance);
       output_id = id;
    else
       fprintf ('Rejected. Distance to %i swas %0.3f', id, distance);
       output_id = -1; 
    end

end

