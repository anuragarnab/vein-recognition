function [ output_id ] = identify( chosen, hd_fraction, veins, threshold, verbose, test_index )
%identify Identify an individual. Compare a chosen index of the training database to all others but itself. 
% Return the index with the lowest score. 
% Match is regarded as genuine if this score is lower than the threshold

    if (nargin < 5)
       verbose = 0; 
    end
    
    [id distance ~] = test_identity (chosen, hd_fraction, veins);
    
    if (distance < threshold)
        
       if (verbose) 
            fprintf ('Identified image %i as %i since distance was %0.3f \n', test_index, id, distance);
       end
       output_id = id;
    else
        
       if (verbose)
           fprintf ('Rejected. Distance from image %i to %i was %0.3f \n', test_index, id, distance);
       end
       output_id = -1; 
    end

end

