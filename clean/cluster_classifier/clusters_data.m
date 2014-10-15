% A script for plotting the clustering obtained

id = 1; % The cluster we are showing

colours = linspecer(4);
num_clusters = 160; % Showed in Chapter 5 this is optimal
num_per_class = 6; % We have 6 images per class
fraction = 100; % This was a parameter I initally experimented it. It will be ignored anyway

cl = train_cluster(num_per_class,fraction,num_clusters,veins,[0, 2, 3, 4, 1]); % Not clustering with the 6th image of the class
count = 0;
test_thresh = 5;
figure

% Find points that are far from centroids (> 5 Euclidean distance)
points = [];
outliers = [];

size = 36; %default
scatter (points(:,1), points(:,2), size, colours(1,:), 'Marker', '+', 'linewidth', 2);
hold on
scatter ( cl(id).cluster(:,1), cl(id).cluster(:,2), 2*size, colours(2,:), 'linewidth', 2, 'Marker', 'X');

% Plot Voronoi diagram to show boundaries
cl(id).cluster = cl(id).cluster(~any(isnan(cl(id).cluster),2),:); 
[vx, vy] = voronoi ( cl(id).cluster(:,1), cl(id).cluster(:,2) );
hold on
plot (vx, vy, 'color', colours(3,:), 'linewidth', 2);
legend({'Bifurcation points','Cluster centroids'}); 
goodplot();
legendmarkeradjust(10, 2);

set (gca, 'XLim', [0 320]);
set (gca, 'YLim', [0 80]);

nice_green = [115, 174, 66]./255;
nice_blue = [91, 155, 213]./255;
nice_red = [192, 80, 77]./255;

% Show bifurcations of image which we did not use for training

figure
other_points = [veins(6*id).x veins(6*id).y];
hold on
scatter ( cl(id).cluster(:,1), cl(id).cluster(:,2), 72, nice_red, 'Marker', 'X', 'linewidth', 2);
scatter (other_points(:,1), other_points(:,2), [], nice_blue, 'Marker', '+', 'linewidth', 2);
plot (vx, vy, 'color', nice_green, 'linewidth', 2);
goodplot();
xlabel('X co-ordinate of bifurcation point');
ylabel('Y co-ordinate of bifurcation point');
legend({'Centroids of cluster','Bifurcation point of unseen image'}, 'Location', 'SouthOutside');

set (gca, 'XLim', [0 320]);
set (gca, 'YLim', [0 80]);
