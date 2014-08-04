number_of_clusters = 8;
cluster = [];
min_sumD = Inf;

training = [7, 9, 10, 12];
training_data = [];

for i = training
    training_data = [training_data ; [veins(i).x veins(i).y] ];
end

training_data = sortrows (training_data,2);
starting_point = training_data(1,:);

for i = 2:number_of_clusters
    index = round(length(training_data)/number_of_clusters * i);
    starting_point = [starting_point ; training_data(index,:) ];
end

%for k =1:100
%    [index, cluster_t, sumD] = kmeans(training_data, number_of_clusters);
%    if (sumD < min_sumD)
%        min_sumD = sumD;
%        cluster = cluster_t;
%    end
%end

%[~, cluster] = kmeans(training_data, number_of_clusters, 'replicates', 100);
[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point);

for i = [training, 8, 11, 13, 14, 15, 16, 26, 39];
   %score = 0;
   %for j = 1:length(veins(i).x)
   %    score = score + distance_to_cluster(cluster, [veins(i).x(j) veins(i).y(j)]);
   %end
   score = get_score (cluster, [veins(i).x veins(i).y]);
   fprintf ('Subject: %i Sum of distance to centroids was %0.3f\n', i, score);
end