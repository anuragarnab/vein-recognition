% makes a distance matrix for testing.
% Should not be limited to only mhd distance, but any distance

%% Compute the distances

distances_lbp = zeros(length(veins)); % make a square matrix

for row = 1:length(distances_lbp)
    for col = 1:length(distances_lbp)
        
        distances_lbp(row,col) = get_score(veins(row).lbp, veins(col).lbp);
        
    end
end

%% Compute the correct and incorrect scores
num_per_sample = 6;
genuine_lbp = [];
imposter_lbp = [];

for i = 1:size(distances_lbp,1)
   d = distances_lbp(:,i);
   [start, finish] = get_limits(i, num_per_sample);
   
   genuine_idx = [start+1:1:finish];
   genuines = d (genuine_idx);
   genuines = sort (genuines, 'ascend');
   genuine_lbp = [genuine_lbp ; genuines(2)];
   
   imposter_idx = [1:1:start finish+1:600];
   imposter_lbp = [imposter_lbp d(imposter_idx)];
   
end

