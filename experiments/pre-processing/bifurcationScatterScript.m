figure
scatter(veins(24).x, veins(24).y, 36, colours(12,:), 'filled')
hold on
scatter(veins(23).x, veins(23).y, 36, colours(10,:), 'filled')

xlabel('X co-ordinate of bifurcation');
ylabel('Y co-ordinate of bifurcation');
goodplot;

figure
scatter(veins(1).x, veins(1).y, 36, colours(12,:), 'filled')
hold on
scatter(veins(186).x, veins(186).y, 36, colours(1,:), 'filled')

xlabel('X co-ordinate of bifurcation');
ylabel('Y co-ordinate of bifurcation');
goodplot;

colours = linspecer(12);
v1 = [1 1;3 3; 4 4];
v2 = [1.1 1.1; 2.1 2.1; 3.1 3.1; 4.1 4.1];
figure;
scatter (v1(:,1), v1(:,2), 36, colours(12,:), 'filled');
hold on
scatter (v2(:,1), v2(:,2), 36, colours(10,:), 'filled');