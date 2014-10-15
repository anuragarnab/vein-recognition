function [ distances ] = get_distances( vein, veins, index_to_exclude )
%get_distances Get all distances from "vein" to all the images in "veins"
% distance to "index_to_exclude" is ignored

    if (nargin < 3)
       index_to_exclude = 0; 
    end
    
    distances = zeros (length(veins), 1);
    
    for i = 1:length(veins)
       distances(i) = bitwise_hamming(vein.lbp(:), veins(i).lbp(:));
    end
    
    if (index_to_exclude > 0)
        distances(index_to_exclude) = Inf; % Easier to do this than to find the second lowest value each time
    end
end

