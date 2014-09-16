function [ genuines, imposters ] = get_score_pairs( d1, d2, num_per_sample, num_imposters, skip_diags )
%UNTITLED Returns pair of genuine/imposter distances. This is important
%when comparing scores to each other.
% Rows are sorted according to col1, ie col1 has precedence
    genuines = [];
    imposters = [];
    
    for i = 1:size(d1,2)
        
        [start, finish] = get_limits(i, num_per_sample);

        col1 = d1(i,:)';
        col2 = d2(i,:)';
        
        % Making use of the fact that entries along diagonal are 0 when
        % considering genuine distances
        
        if (skip_diags)
            col1(i) = Inf;
            col2(i) = Inf;
        end
        
        distances = [col1 col2];
        [dis, idx] = sortrows(distances);

        correct_idx = idx(idx > start & idx <= finish);
        corrects = distances(correct_idx,:);
        corrects = sortrows(corrects);
        %gen = min(corrects);
        [~, min_idx] = min(corrects);
        gen = corrects(min_idx(1),:);
        
        imposter_idx = idx(idx <= start | idx > finish);
        imp = distances(imposter_idx,:);
        
        genuines = [genuines ; gen];
        imposters = [imposters ; imp(1:num_imposters*2,:)];
    
    end
    
    imposters = sortrows(imposters,1);
    imposters = imposters(1:2:end,:);
    
end

