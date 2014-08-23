% makes a distance matrix for testing.
% Should not be limited to only mhd distance, but any distance

%% Compute the distances

imp_distances_ulbp_chi = zeros(length(veins)); % make a square matrix

for row = 1:length(imp_distances_ulbp_chi)
    for col = 1:length(imp_distances_ulbp_chi)
        
        %distances(row,col) = mhd_fast ( [veins(row).x veins(row).y], [veins(col).x veins(col).y], mhd_fraction);
        imp_distances_ulbp_chi(row,col) = get_distances( veins(row), veins_unreg(col));
    end
end

%% Compute the correct and incorrect scores
% num_per_sample = 6;
% genuine_mhd = [];
% imposter_mhd = [];
% 
% for i = 1:size(distances,1)
%    d = distances(:,i);
%    [start, finish] = get_limits(i, num_per_sample);
%    
%    genuine_idx = [start+1:1:finish];
%    genuines = d (genuine_idx);
%    genuines = sort (genuines, 'ascend');
%    genuine_mhd = [genuine_mhd ; genuines(2)];
%    
%    imposter_idx = [1:1:start finish+1:600];
%    imposter_mhd = [imposter_mhd d(imposter_idx)];
%    
% end

