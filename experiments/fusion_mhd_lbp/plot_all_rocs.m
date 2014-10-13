% plot all the rocs from the mhd test

num_outliers = 7;
history = [];

history(1).corrects = corrects_mhd;
history(2).corrects = corrects_fourier;
history(3).corrects = corrects_hamming;
history(4).corrects = corrects_MHDHamming;
history(5).corrects = corrects_fourierMHDHamming;

history(1).negs = negs_mhd;
history(2).negs = negs_fourier;
history(3).negs = negs_hamming;
history(4).negs = negs_MHDHamming;
history(5).negs = negs_FourierMHDHamming;

testing = [1:1:length(history)];
count = 1;

colours = linspecer(length(testing)+1);

temp = colours(1,:);
colours(1,:) = colours(end-1,:);
colours(end-1,:) = temp;

leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all

thresholds = [0:0.1:15];

for i = testing
%     plot ((sum(history(i).frr_record) + sum(history(i).wrong_rec_record)) ./(600 - outliers).* 100, (sum(history(i).far_record))./600 .* 100, 'linewidth', 2); % Tested that this is equivalent to the other methods that I have used
    
   % [corrects, negs] = tester(history(i).gen_distance, history(i).imp_distance, thresholds, limits, num_per_sample);
    
   % history(i).corrects = corrects;
   % history(i).negs = negs;
    
    corrects = history(i).corrects;
    negs = history(i).negs;
    
    history(i).far = size(negs,1) - sum(negs);
    history(i).frr = size(corrects,1) - sum(corrects) - num_outliers;
    
    history(i).far = history(i).far ./ size(negs,1) .* 100;
    history(i).frr = history(i).frr ./ (size(corrects,1) - num_outliers) .* 100;
    
    plot (history(i).far, history(i).frr, 'linewidth', 2);
   % leg_labels{count} = num2str(history(i).mhd_frac);
    
    [eer, eerv] = get_eer(history(i).corrects, history(i).negs, num_outliers);
    history(i).eer = (eer+eerv)/2;

    count = count+1;
end

ylabel ('False acceptance rate (FAR) [%]')
xlabel ('False rejection rate (FRR) [%]');
x = [0:0.01:100];
plot(x,x, 'linestyle', '--', 'linewidth', 2);
legend({'MHD', 'Fourier LBP', 'Canonical LBP', 'MHD + Canonical LBP', 'MHD + Canonical LBP + Fourier LBP', 'EER Line'});
%leg_labels{count} = 'EER line';

%legend(leg_labels);

% Legend title does not go into the box, so fuck it
% l = legend(leg_labels);
% ltitle = get(l,'title');
% set(ltitle,'string','Number of clusters');

for i = testing
    
    scatter(history(i).far, history(i).frr, 'filled');  
end

goodplot();
set(gca, 'XLim', [0 8], 'YLim', [0 8]);

% 
% rmpath ../../common