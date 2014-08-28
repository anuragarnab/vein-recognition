images_per_user = 6;
users = 100;
num_clusters = 80;
threshold = 300;

correct_record = [];
correct_neg_record = [];
far_record = [];
frr_record = [];

clus = train_cluster(images_per_user, users, num_clusters, veins);

thresh = [10:10:250];
thresh = [thresh 300:50:600];
%thresh = 250;

for threshold = thresh
    
    correct = zeros(200,1);
    correct_neg = zeros(200,1);
    far = zeros(200,1);
    frr = zeros(200,1);
    counter = 1;
    
    for k = 0:(users-1)
        %1 and 4

        for j = [k*images_per_user+1 k*images_per_user+4]
            [idx, dist] = identify(j, veins, clus, threshold);

            if (idx == ceil(j/6))
                correct(counter) = 1;
            elseif (idx > 0)
                frr(counter) = 1;
                fprintf('Incorrect. Should have been %d. Identified as %d. Distance was %0.3f\n', ceil(j/6), idx, dist);
            else
                fprintf('Incorrect. Should have been %d. Identified as %d. Distance was %0.3f\n', ceil(j/6), idx, dist);
                frr(counter) = 1;   
            end
        end

    end

    for j = 1:length(veins_unreg)
        [idx, dist] = identify(j, veins_unreg, clus, threshold);

        if (idx == -1)
            correct_neg_record(i) = 1;
        else
            far(i) = 1;
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

    counter = counter + 1;
end

save kmeans_test_80_2 correct_record correct_neg_record far_record frr_record
