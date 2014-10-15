function [ clusters ] = train_cluster( samples_per_user, num_users, fraction, veins, test_indices, is_fraction )
%train_cluster Creates clusters of all the images in "veins"
% "sample_per_user" determines how many images are used per vein
% test_indices determine which veins we use for training the clusters (we
%   don't want to use all our data
% "fraction" should be set to 100. It is a parameter we initally
%   experimented with but has since been abandoned

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

