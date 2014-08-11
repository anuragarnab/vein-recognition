images_per_user = 6;
users = 100;
num_clusters = 80;
threshold = 300;

correct_array = [];
correct_neg_array = [];
far_record = [];
frr_record = [];

clus = train_cluster(images_per_user, users, num_clusters, veins);

thresh = [10:10:250];
thresh = [thresh 300:50:600];

for threshold = thresh
    
    correct = 0;
    correct_neg = 0;
    far = 0;
    frr = 0;

    for k = 0:(users-1)
        %1 and 4

        for j = [k*images_per_user+1 k*images_per_user+4]
            [idx, dist] = identify(j, veins, clus, threshold);

            if (idx == ceil(j/6))
                correct = correct + 1;
            elseif (idx > 0)
                far = far + 1;
                fprintf('Incorrect. Should have been %d. Identified as %d. Distance was %0.3f\n', ceil(j/6), idx, dist);
            else
                fprintf('Incorrect. Should have been %d. Identified as %d. Distance was %0.3f\n', ceil(j/6), idx, dist);
                frr = frr + 1;    
            end
        end

    end

    for j = 1:length(veins_unreg)
        [idx, dist] = identify(j, veins_unreg, clus, threshold);

        if (idx == -1)
            correct_neg = correct_neg + 1;
        else
            far = far + 1;
            fprintf('Incorrect. Should not have accepted %d. Identified as %d. Distance was %0.3f\n',j, idx, dist);
        end

    end
    
    correct / 200
    correct_neg / 600
    correct_array = [correct_array correct];
    correct_neg_array = [correct_neg_array correct_neg];
    far_record = [far_record far];
    frr_record = [frr_record frr];
end

save kmeans_test_80 correct_array correct_neg_array far_record frr_record
