function [ cluster ] = get_cluster( number_of_clusters, index, veins )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

cluster = [];

training = [index, index+2, index+3, index+5];
training_data = [];

for i = training
    training_data = [training_data ; [veins(i).x veins(i).y] ];
end

%% This is my method of initially setting the starting points. Sort the (x, y) pairs according to the y co-ordinate, and then pick samples at uniformly spaced intervals
training_data = sortrows (training_data,2);
starting_point = training_data(1,:);

for i = 2:number_of_clusters
    index = round(length(training_data)/number_of_clusters * i);
    starting_point = [starting_point ; training_data(index,:) ];
end
%%

%opts = statset('MaxIter',200); %100 was not enough for one of the tests I did (think with 17 clusters)
%%%%[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point, 'options', opts);
%[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point, 'options', opts, 'emptyaction', 'drop');

[~, cluster] = kmeans_open(training_data, number_of_clusters, 'start', starting_point, 'emptyaction', 'drop', 'Maxiter', 200);

end

