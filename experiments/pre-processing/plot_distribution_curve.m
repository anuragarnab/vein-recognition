% This is quite stupid, but you need to run
% 'plot-distribution_curves_proper' first

% This will generate the distribution curve of the Genuine and Imposter
% distances

%%
% Can run with postive_distances_1 (distance to best 1 neighbour), or run
% with positive_distances_2 (distance to best 2 neighbours)
%%

[correct_x correct_y] = generate_pdf (positive_distances_1, 12);
% The issue is that the graph does not end on 0 on either side. So we
% enforce this manualy
epsilon = 0.0001;

x_min = min (correct_x);
x_max = max (correct_x);

correct_x = [(x_min-epsilon) correct_x (x_max+epsilon)];
correct_y = [0 ; correct_y ; 0];

figure
plot (correct_x, correct_y, 'blue');

[imposter_x imposter_y] = generate_pdf (negative_distances, 100);

hold on
plot (imposter_x, imposter_y, 'red');

title ('Relative frequency distributions of genuine and imposter Hausdorff distances');
xlabel ('Hausdorff distance');
ylabel ('Relative frequency');
legend ('Genuine', 'Imposter');