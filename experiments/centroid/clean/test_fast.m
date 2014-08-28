images_per_user = 6;
users = 100;
num_clusters = 60;
threshold = 300;

correct_record = [];
correct_neg_record = [];
far_record = [];
frr_record = [];
wrong_rec_record = [];



thresh = [10:10:900];
%thresh = [thresh 300:50:600];

clus = train_cluster(images_per_user, users, num_clusters, veins);
[distances_centroid, imp_distances_centroid] = distance_matrix( clus, veins, veins_unreg );

for threshold = thresh
    
    correct = zeros(length(veins),1);
    correct_neg = zeros(length(veins),1);
    far = zeros(length(veins),1);
    frr = zeros(length(veins),1);
    wrong_recognised = zeros(length(veins),1); % Special case of far I guess
    counter = 1;
    
    for k = 0:(users-1)
        %1 and 4
        for j = [k*images_per_user+1 k*images_per_user+4]
            dis = distances_centroid(j,:);
            [dis, idx] = sort(dis, 'ascend');
            val = dis(1);
            id = idx(1);

            if (val > threshold)
                id = -1;
            end

            if (id == ceil(j/6))
                correct(j) = 1;
            elseif (id == -1)
                frr(j) = 1;
            else
                wrong_recognised(j) = 1;
            end 

            if (mod(j,100) == 0)
               fprintf('%i\n', j); 
            end    
        end
    end

    for j = 1:length(veins_unreg)
        
        dis = imp_distances_centroid(j,:);
        [dis, idx] = sort(dis, 'ascend');
        val = dis(1);
        id = idx(1);
        
        if (val > threshold)
            id = -1;
        end

        if (id == -1)
            correct_neg(j) = 1;
        else
            far(j) = 1;
            fprintf('Incorrect. Should not have accepted %d. Identified as %d. Distance was %0.3f\n',j, idx, dist);
        end

    end
    
%     correct / 200
%     correct_neg / 600
%     correct_array = [correct_array correct];
%     correct_neg_array = [correct_neg_array correct_neg];
%     far_record = [far_record far];
%     frr_record = [frr_record frr];

    correct_record = [correct_record correct];
    correct_neg_record = [correct_neg_record correct_neg];
    far_record = [far_record far];
    frr_record = [frr_record frr];
    wrong_rec_record = [wrong_rec_record wrong_recognised];

    counter = counter + 1;
end

sum (correct_record)
sum (correct_neg_record)

