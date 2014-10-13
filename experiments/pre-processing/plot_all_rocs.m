% plot all the rocs from the mhd test

num_outliers = 13;

testing = [1:1:length(history)];
count = 1;

colours = linspecer(length(testing)+1);
leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all

thresholds = [0:0.1:15];

for i = testing
%     plot ((sum(history(i).frr_record) + sum(history(i).wrong_rec_record)) ./(600 - outliers).* 100, (sum(history(i).far_record))./600 .* 100, 'linewidth', 2); % Tested that this is equivalent to the other methods that I have used
    
    [corrects, negs] = tester(history(i).gen_distance, history(i).imp_distance, thresholds, limits, num_per_sample);
    
    history(i).corrects = corrects;
    history(i).negs = negs;
    
    history(i).far = length(negs) - sum(negs);
    history(i).frr = length(corrects) - sum(corrects) - num_outliers;
    
    history(i).far = history(i).far ./ length(negs) .* 100;
    history(i).frr = history(i).frr ./ (length(corrects) - num_outliers) .* 100;
    
    plot (history(i).far, history(i).frr, 'linewidth', 2);
    leg_labels{count} = num2str(history(i).mhd_frac);
    
    [eer, eerv] = get_eer(history(i).corrects, history(i).negs, num_outliers);
    history(i).eer = (eer+eerv)/2;

    count = count+1;
end

ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = [0:0.01:100];
plot(x,x, 'linestyle', '--', 'linewidth', 2);
leg_labels{count} = 'EER line';

legend(leg_labels);

% Legend title does not go into the box, so fuck it
% l = legend(leg_labels);
% ltitle = get(l,'title');
% set(ltitle,'string','Number of clusters');

for i = testing
    
    scatter(history(i).far, history(i).frr, 'filled');  
end

goodplot();


%% Selectively plot a few
colours = linspecer(9, 'qua');
leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all
count = 1;

for i = 1:8
    plot (history(i).far, history(i).frr, 'linewidth', 2);
    leg_labels{count} = num2str(history(i).mhd_frac);
    count = count+1;
end

ylabel ('False acceptance rate [%]')
xlabel ('False rejection rate [%]');
x = [0:0.01:100];
plot(x,x, 'linestyle', '--', 'linewidth', 2);
leg_labels{count} = 'EER line';

for i = 1:8
    scatter(history(i).far, history(i).frr, 'filled'); 
end

legend(leg_labels);
goodplot();

set(gca, 'XLim', [0 15]);
set(gca, 'YLim', [0 15]);
% 
% 
% rmpath ../../common