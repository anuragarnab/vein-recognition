function [ clusters ] = train_cluster( samples_per_user, num_users, num_clusters, veins, test_indices )
%UNTITLED5 Summary of this function goes here
%   Creates an array of cluster centroids
%   Didint use "train" as its name clashes with a MATLAB built in function
%   for neural networks
    clusters = [];
    
    i = 1;
    while (i < num_users * samples_per_user)
        clusters(ceil(i/samples_per_user)).cluster = get_cluster(num_clusters, i, veins, test_indices);
        i =i+samples_per_user;
    end

end

