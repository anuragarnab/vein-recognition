addpath ../../common

num_outliers = 7;
num_per_sample = 6;
limits = 0;
datat = [];

colours = distinguishable_colors(3*7); % Bit hacky. Length of r x length of c
leg_labels = {};
count = 1;
figure
set(0,'DefaultAxesColorOrder',colours)
hold all
thresholds = [0:5:3000];

for r = [1 2 4] % commented 1 out for now
    for c = [1 2 4 8 12 16 32]
        
        fname = strcat('r',num2str(r),'c',num2str(c));
        load (fname);
        [corrects, correct_negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
    
        far = length(correct_negs) - sum(correct_negs);
        frr = length(corrects) - sum(corrects) - num_outliers;

        far = far ./ length(correct_negs) .* 100;
        frr = frr ./ (length(corrects) - num_outliers) .* 100;
        
        data(count).corrects = corrects;
        data(count).correct_negs = correct_negs;
        data(count).far = far;
        data(count).frr = frr;

        plot (far, frr, 'linewidth', 2);
        leg_labels{count} = strcat('Rows: ',num2str(r),' Columns: ',num2str(c));
        fprintf('%d \n', count);
        count = count + 1;     
    end
end

ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
plot(x,x);
leg_labels{count} = 'EER';

legend(leg_labels);
goodplot();
