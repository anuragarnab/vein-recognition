function [ idx, score ] = identify( id, veins, clusters, threshold )
%UNTITLED6 Identifies a vein image
%   id is the index of the vein image you want to identify
%   veins is an array containing the testing image
%   clusters are the clusters which were used to train the image
%   Return -1 if the match is greater than the threshold
    
    score = Inf;
    idx = -1;
    
    for j = 1:length(clusters)
        temp = get_score(clusters(j).cluster, [veins(id).x veins(id).y]);
        
        if (temp < score)
           score = temp;
           idx = j;
        end
    end
    
    if (score > threshold)
        idx = -1;
    end

end

