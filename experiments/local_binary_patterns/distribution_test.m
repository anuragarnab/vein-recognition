num_per_sample = 6;
genuine = [];
imposter = [];

for i = 1:length(veins)
   
    [start, finish] = get_limits(i, num_per_sample);
%     dis = zeros(6,1);
%     
%     for j = start:finish
%         dis(j-start+1) = get_distances( veins(i).ulbp_hist, veins(j).ulbp_hist);
%     end
%     
%     [dis, idx] = sort(dis, 'ascend');
%     genuine = [genuine;dis(2)];

    d = get_distances(veins(i), veins, i);
    [val, idx] = sort(d, 'ascend');
    
    imposters_idx = idx(idx <= start | idx > finish);
    imposter_distances = d (imposters_idx);
    imposter = [imposter imposter_distances];
    
    correct_idx = idx(idx > start | idx <= finish);
    genuine = [genuine min(d(correct_idx))];
end