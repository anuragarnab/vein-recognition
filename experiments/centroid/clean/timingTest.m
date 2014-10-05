images_per_user = 6;
users = 100;
num_clusters = 160;


clus1 = train_cluster(images_per_user, users, num_clusters, veins, [1, 2, 3, 4, 5]);
    clus2 = train_cluster(images_per_user, users, num_clusters, veins, [0, 2, 3, 4, 5]);
    clus3 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 3, 4, 5]);
    clus4 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 4, 5]);
    clus5 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 5]);
    clus6 = train_cluster(images_per_user, users, num_clusters, veins, [0, 1, 2, 3, 4]);

    [distances_centroid, imp_distances_centroid] = distance_matrix( clus1, clus2, clus3, clus4, clus5, clus6, veins, veins_unreg );