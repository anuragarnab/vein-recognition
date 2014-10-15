% libsvm_basic_test_2;

% mhd_eer = 5.6;
% mhd_l = (mhd_eer - mu(2)) / sigma(2);
% 
% lbp_eer = 17050;
% lbp_l = (lbp_eer - mu(1)) / sigma(1);
% 
% [f1,f2,f3,f4,f5] = plotboundary2(labels, train_data, svm_model, mhd_l, lbp_l);

[f1,f2,f3,f4] = plotboundary(data2(1).labels,data2(1).train, svms(1) , 't');



xlabel('Normalised Hamming Distance from Canonical LBP classifer')
ylabel('Noramlised MHD distance from minutiae')
%legend([f2 f3 f4], {'Decision boundary', 'Genuine samples', 'Imposter samples'})

% Move the legend around a bit first and add spaces
% myaa
contrasting_colour = [204 51 153]./255;

mhd_eer = 17050; %5.6 for mhd, 7100 for fourier lbp
mhd_l = (mhd_eer - mu(2)) / sigma(2)
x = [min(train_data(:,1))*1.02:0.001:max(train_data(:,1))*1.02];
f5 = plot( x, mhd_l*ones(size(x)), 'color', contrasting_colour, 'LineWidth', 2);

lbp_eer = 5.8; % 17050 for canonical lbp, 750 for ulbp_chi (ie think its 735 actually)
lbp_l = (lbp_eer - mu(1)) / sigma(1)
y = [min(train_data(:,2))*1.02:0.001:max(train_data(:,2))*1.02];
plot( lbp_l.*ones(size(y)), y, 'LineWidth', 2, 'color', contrasting_colour);
legend([f2 f3 f4 f5(end)], {'Decision boundary from SVM', 'Genuine samples', 'Imposter samples', 'Decision boundaries from individual classifiers'})



goodplot()



