id = 1;

colours = linspecer(4);

cl = train_cluster(6,100,160,veins,[0, 2, 3, 4, 1]);
count = 0;
test_thresh = 5;
figure

points = [];
outliers = [];

for i=6*(id-1)+1:6*id-1
    temp = [veins(i).x veins(i).y];
    for j=1:length(temp)
        d = distance_to_cluster(cl(id).cluster, temp(j,:));
        if (d > test_thresh)
            outliers = [outliers ; temp(j,:)];
        else
            points = [points ; temp(j,:)];
        end

    end
end

% for i=6*(id-1)+1:6*id-1
%     id
%     scatter ( veins(i).x, veins(i).y, 'blue' ); 
%     count = count + length(veins(i).x);
%     hold on
% end

size = 36; %default
scatter (points(:,1), points(:,2), size, colours(1,:), 'Marker', '+', 'linewidth', 2);
hold on
scatter ( cl(id).cluster(:,1), cl(id).cluster(:,2), 2*size, colours(2,:), 'linewidth', 2, 'Marker', 'X');
%scatter (outliers(:,1), outliers(:,2), size, colours(4,:), 'linewidth', 2, 'Marker', '*'); % Not differentiating between outliers in the plot I need now (19 Sep)

cl(id).cluster = cl(id).cluster(~any(isnan(cl(id).cluster),2),:); 
[vx, vy] = voronoi ( cl(id).cluster(:,1), cl(id).cluster(:,2) );
hold on
plot (vx, vy, 'color', colours(3,:), 'linewidth', 2);
legend({'Bifurcation points','Cluster centroids'}); legendmarkeradjust(10, 2)
goodplot();

set (gca, 'XLim', [0 320]);
set (gca, 'YLim', [0 80]);

nice_green = [115, 174, 66]./255;
nice_blue = [91, 155, 213]./255;
nice_red = [192, 80, 77]./255;

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

count
number_of_centroids = length(cl(id).cluster)