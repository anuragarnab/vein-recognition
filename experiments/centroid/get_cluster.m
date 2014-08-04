function [ cluster ] = get_cluster( number_of_clusters, index, veins )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cluster = [];

training = [index, index+2, index+3, index+5];
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
opts = statset('MaxIter',200); %100 was not enough for one of the tests I did (think with 17 clusters)
[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point, 'options', opts);

end

