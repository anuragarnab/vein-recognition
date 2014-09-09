addpath ../../common

num_outliers = 7;
num_per_sample = 6;
limits = 0;
% datat = [];

%colours = linspecer(3*7 + 1); % Bit hacky. Length of r x length of c
%colours = cbrewer('qual', 'Set1', 3*7 + 1);
colours = distinguishable_colors(3*7 + 1); % Bit hacky. Length of r x length of c
colours = colours(end:-1:1,:);
leg_labels = {};
count = 1;
figure
set(0,'DefaultAxesColorOrder',colours)
hold all
thresholds = [0:5:3000];

for r = [1 2 4] % commented 1 out for now
    for c = [1 2 4 8 12 16 32]
        
        %if (isempty(data))
            % this time consuming section of code is only run when "data"
            % has not been computed before
            fname = strcat('r',num2str(r),'c',num2str(c));
            load (fname);
%             [corrects, correct_negs] = tester(distances_ulbp_chi, imp_distances_ulbp_chi, thresholds, limits, num_per_sample);
            corrects = data(count).corrects;
            correct_negs = data(count).correct_negs;
            
            far = size(correct_negs,1) - sum(correct_negs);
            frr = size(corrects,1) - sum(corrects) - num_outliers;

            far = far ./ size(correct_negs,1) .* 100;
            frr = frr ./ (size(correct_negs,1) - num_outliers) .* 100;

            data(count).corrects = corrects;
            data(count).correct_negs = correct_negs;
            data(count).far = far;
            data(count).frr = frr;
            data(count).r = r;
            data(count).c = c;        
        %end
        
        data(count).r = r;
        data(count).c = c;  
        
        plot (data(count).far, data(count).frr, 'linewidth', 2);
        leg_labels{count} = strcat('r= ',num2str(r),' c= ',num2str(c));
        fprintf('%d \n', count);
        count = count + 1;     
    end
end

ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
plot(x,x,'linewidth',2,'linestyle', '--');
leg_labels{count} = 'EER';

legend(leg_labels);
goodplot();

set(gca, 'XLim', [0 100]);
set(gca, 'YLim', [0 100]);


% Now only plot the interesting ones
good_ones = [13, 12, 19, 6, 11, 18, 20, 7];
figure
leg_labels = {};
c = 1;
colours = linspecer(length(good_ones)+1);

for i = good_ones  
    hold on
    %plot(data(i).far, data(i).frr, 'linewidth', 2, 'color', colours(i,:));
    plot(data(i).far, data(i).frr, 'linewidth', 2, 'color', colours(c,:));
    leg_labels{c} = strcat('r= ',num2str(data(i).r),' c= ',num2str(data(i).c));
    c = c + 1;
end

ylabel ('False rejection rate')
xlabel ('False acceptance rate');
x = [0:0.01:100];
%plot(x,x,'linewidth',2,'linestyle', '--','color', colours(end,:) );
plot(x,x,'linewidth',2,'linestyle', '--','color', colours(c,:) );
leg_labels{c} = 'EER';

legend(leg_labels);
goodplot();
set(gca, 'XLim', [0 5]);
set(gca, 'YLim', [0 5]);
