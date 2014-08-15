function [ output_id ] = identify( chosen, hd_fraction, veins, threshold, is_imposter_test, veins_imposter, indices_to_check, verbose )
%UNTITLED3 Summary of this function goes here
%   THIS WILL CURRENTLY THROW AN ERROR IF "indices_to_check" IS EMPTY

    if (nargin < 5)
       verbose = 0; 
       is_imposter_test = 0;
    elseif (nargin < 8)
        verbose = 0;
    end
    
    if (~is_imposter_test)
        if (isempty(indices_to_check))
            [id, distance, ~] = test_identity (chosen, hd_fraction, veins);
        else
            [id, distance, ~] = test_identity (chosen, hd_fraction, veins, indices_to_check);
        end
    else
        [id, distance, ~] = test_identity_2 (veins_imposter(chosen), hd_fraction, veins);
    end
    
    if (distance < threshold)
        
       if (verbose) 
            fprintf ('Identified as %i since distance was %0.3f', id, distance);
       end
       output_id = id;
    else
        
       if (verbose)
           fprintf ('Rejected. Distance to %i swas %0.3f', id, distance);
       end
       output_id = -1; 
    end

end

