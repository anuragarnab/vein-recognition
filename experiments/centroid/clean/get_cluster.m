function [ cluster ] = get_cluster( number_of_clusters, index, veins, col_to_sort )
%get_cluster Returns the cluster centroids for set of data
% Uses k-means to calculate centroids of the clusters. 
% kmeans runs for 200 iterations
%
% Cluster centroids are assigned for determinism. Done by sorting
% co-ordinates according to y-values

% number_of_clusters is self explanatory
% "index" is refers to the index of the veins database. Ie, specify index
% =1 to create the cluster of images from 1 to 6 (assuming there are 6
% samples per person
% veins is the veins database
% col_to_sort is used for determining initial centroid locations

if (nargin < 4)
   col_to_sort = 2; 
end

cluster = [];

training = [index, index+2, index+3, index+5];
training_data = [];

for i = training
    training_data = [training_data ; [veins(i).x veins(i).y] ];
end

number_of_clusters = min(number_of_clusters, length(training_data));

%% This is my method of initially setting the starting points. Sort the (x, y) pairs according to the y co-ordinate, and then pick samples at uniformly spaced intervals
training_data = sortrows (training_data,col_to_sort);
starting_point = training_data(1,:);

for i = 2:number_of_clusters
    idx = round(length(training_data)/number_of_clusters * i);
    starting_point = [starting_point ; training_data(idx,:) ];
end
%%

%opts = statset('MaxIter',200); %100 was not enough for one of the tests I did (think with 17 clusters)
%%%%[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point, 'options', opts);
%[~, cluster] = kmeans(training_data, number_of_clusters, 'start', starting_point, 'options', opts, 'emptyaction', 'drop');


[vals, cluster] = kmeans_open(training_data, number_of_clusters, 'start', starting_point, 'emptyaction', 'drop', 'Maxiter', 200);
% Remove empty clusters now

% histogram = hist(vals, number_of_clusters);
% idx = find( histogram == 0 | histogram == 1);
% cluster(idx, :) = NaN;

end

