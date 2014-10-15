function [ distances ] = get_distances( vein, veins, index_to_exclude )
%get_distances Get distances from one vein images to all others in the database
% "index_to_exclude" is omitted. This is when you want to ignore the distance from one vein to itself


    if (nargin < 3)
       index_to_exclude = 0; 
    end
    
    distances = zeros (length(veins), 1);
    
    for i = 1:length(veins)
       distances(i) = euclid_rows(vein.flbp, veins(i).flbp); 
    end
    
    if (index_to_exclude > 0)
        distances(index_to_exclude) = Inf; % Easier to do this than to find the second lowest value each time
    end
end

