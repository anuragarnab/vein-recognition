num_outliers = 13; % decided this
colour = linspecer(1);

figure;
plot( mhd_fractions, correct_positives./(600-13) .* 100, 'linewidth', 2, 'color', colour(1,:) );
xlabel('Value of fraction parameter, \it f');
ylabel('Percentage of genuine queries correctly accepted');

hold on
scatter (0.7, 96.25, 36, colour(1,:), 'filled');
goodplot();