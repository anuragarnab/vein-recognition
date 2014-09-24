libsvm_basic_test_2;

pos = find(labels == 1);
neg = find(labels == -1);

figure
f2 = plot(train_data(pos,1), train_data(pos,2), 'ko', 'MarkerFaceColor', 'r'); hold on;
f3 = plot(train_data(neg,1), train_data(neg,2), 'ko', 'MarkerFaceColor', 'g');

contrasting_colour = [204 51 153]./255;

mhd_eer = 5.6;
mhd_l = (mhd_eer - mu(2)) / sigma(2)
x = [min(train_data(:,1))*1.02:0.001:max(train_data(:,1))*1.02];
y = [min(train_data(:,2))*1.02:0.001:max(train_data(:,2))*1.02];

f5 = plot( x, mhd_l*ones(size(x)), 'color', contrasting_colour, 'LineWidth', 2);

lbp_eer = 735; % 17050 for canonical lbp, 750 for ulbp_chi
lbp_l = (lbp_eer - mu(1)) / sigma(1)
plot( lbp_l.*ones(size(y)), y, 'LineWidth', 2, 'color', contrasting_colour);

xlabel('Normalised Chi Square Distance from Uniform LBP classifer')
ylabel('Noramlised MHD distance from minutiae')
legend([f2 f3 f5(end)], {'Genuine samples', 'Imposter samples', 'Decision boundaries from individual classifiers'})

set(gca, 'XLim', [min(x), max(x)]);
set(gca, 'YLim', [min(y), max(y)]);


goodplot()



