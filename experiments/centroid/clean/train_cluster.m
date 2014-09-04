function [ clusters ] = train_cluster( samples_per_user, num_users, fraction, veins, test_indices, is_fraction )
%UNTITLED5 Summary of this function goes here
%   Creates an array of cluster centroids
%   Didint use "train" as its name clashes with a MATLAB built in function
%   for neural networks
    clusters = [];

    if (nargin < 6)
        is_fraction = 0;
    end
    
    i = 1;
    while (i < num_users * samples_per_user)
        [c, h] = get_cluster(fraction, i, veins, test_indices, is_fraction);
        clusters(ceil(i/samples_per_user)).cluster = c;
        clusters(ceil(i/samples_per_user)).histogram = h;
        i =i+samples_per_user;
    end

end

