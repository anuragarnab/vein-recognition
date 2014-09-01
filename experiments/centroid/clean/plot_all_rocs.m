addpath ../../common

colours = distinguishable_colors(length(history));
leg_labels = {};
figure
set(0,'DefaultAxesColorOrder',colours)
hold all

for i = 1:length(history)

    plot ((sum(history(i).frr_record) + sum(history(i).wrong_rec_record)) ./600 .* 100, (sum(history(i).far_record))./600 .* 100);
    leg_labels{i} = num2str(history(i).centroids_per_cluster);
end


ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = ones(100,1);
x = cumsum(x);
x = [0; x];
plot(x,x);
leg_labels{i+1} = 'EER';

legend(leg_labels);

rmpath ../../common