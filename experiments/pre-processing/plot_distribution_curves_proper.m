% creates the correct/incorrect distribution
positive_distances_2 = zeros (length(veins)*2, 1);
positive_distances_1 = zeros (length(veins), 1);
negative_distances = [];

for i = 1:length(veins)
    
    [start, finish] = get_limits(i, 6);
    temp_distances = []; % Stores the correct ones

    % Test the ith sample against all j other samples (including itself)
    for j = 1:length(veins)

        if (i == j)
            continue;
        end
        
        distance = mhd_fast ( [veins(i).x veins(i).y] , [veins(j).x veins(j).y], 0.8);
        
        if ( j >= start && j <= finish)
            temp_distances = [temp_distances distance];
        else
            negative_distances = [negative_distances distance];
        end
    end
    % Find the best two distances for positive matches
    
    temp_distances = sort (temp_distances, 'ascend');
    positive_distances_2( 1 + 2*(i-1) ) = temp_distances(1);
    positive_distances_2( 1 + 2*(i-1) + 1 ) = temp_distances(2);
    positive_distances_1(i) = temp_distances(1);
end

