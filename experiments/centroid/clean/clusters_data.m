id = 52;

cl = train_cluster(6,100,0.9,veins,[0, 2, 3, 4, 1]);
count = 0;
test_thresh = 5;
figure

points = [];
outliers = [];

for i=6*(id-1):6*id-1
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

scatter (points(:,1), points(:,2), 'blue');
hold on
scatter (outliers(:,1), outliers(:,2), 'magenta');
scatter ( cl(id).cluster(:,1), cl(id).cluster(:,2), 'red');

cl(id).cluster = cl(id).cluster(~any(isnan(cl(id).cluster),2),:); 
[vx, vy] = voronoi ( cl(id).cluster(:,1), cl(id).cluster(:,2) );
hold on
plot (vx, vy, 'green');

set (gca, 'XLim', [0 320]);
set (gca, 'YLim', [0 80]);

count
number_of_centroids = length(cl(id).cluster)