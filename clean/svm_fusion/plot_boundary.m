% %% Anurag Arnab - ARNANU002
% Plots the decision boundary created by the SVM

[f1,f2,f3,f4] = plotboundary(data2(1).labels,data2(1).train, svms(1) , 't'); % Plot SVM decision boundary

xlabel('Normalised Hamming Distance from Canonical LBP classifer')
ylabel('Noramlised MHD distance from minutiae')

contrasting_colour = [204 51 153]./255;

%% Plot the decision boundaries of the individual classifiers as well

mhd_eer = 17050; %5.6 for mhd, 7100 for fourier lbp
mhd_l = (mhd_eer - mu(2)) / sigma(2);
x = [min(train_data(:,1))*1.02:0.001:max(train_data(:,1))*1.02];
f5 = plot( x, mhd_l*ones(size(x)), 'color', contrasting_colour, 'LineWidth', 2);

lbp_eer = 5.8; % 17050 for canonical lbp, 750 for ulbp_chi (ie think its 735 actually)
lbp_l = (lbp_eer - mu(1)) / sigma(1);
y = [min(train_data(:,2))*1.02:0.001:max(train_data(:,2))*1.02];
plot( lbp_l.*ones(size(y)), y, 'LineWidth', 2, 'color', contrasting_colour);

%%
legend([f2 f3 f4 f5(end)], {'Decision boundary from SVM', 'Genuine samples', 'Imposter samples', 'Decision boundaries from individual classifiers'})

%% Make the plot prettier
goodplot()



