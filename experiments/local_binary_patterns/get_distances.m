function [ distances ] = get_distances( vein, veins, index_to_exclude )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    if (nargin < 3)
       index_to_exclude = 0; 
    end
    
    distances = zeros (length(veins), 1);
    
    for i = 1:length(veins)
       distances(i) = get_score (vein.ulbp_hist, veins(i).ulbp_hist); 
       %if (mod(i,100) == 0)
       %   fprintf('%d\n', i); 
       %end
    end
    
    if (index_to_exclude > 0)
        distances(index_to_exclude) = Inf; % Easier to do this than to find the second lowest value each time
    end
end

