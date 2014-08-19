% putting t as thresh
%t = [100, 150, 200];
%thresh = [1 2:0.1:3 3.5 4 5];
thresh = threshes;
outliers = 13; % I got this figure from the original mhd tests. I took the intersection of what mhd could never identify and what lbp (histogram and standrd) could never identify

figure
plot (thresh, sum(correct_record) ./ length(veins) * 100, 'blue')
hold on
plot (thresh, sum(correct_neg_record) ./ length(veins_unreg) * 100, 'red')
legend ('Genuine samples correctly accepted', 'Imposter samples correctly rejected')

figure
%plot (far_record./600 .* 100 , frr_record./200 .* 100);
%xlabel ('False acceptance rate')
%ylabel ('False rejection rate');

far = sum(far_record) + sum(wrong_rec_record);
denom = length(veins_unreg) + sum(wrong_rec_record);

plot (sum(frr_record)./length(veins) .* 100, far./denom .* 100);
ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = ones(100,1);
x = cumsum(x);
hold on
plot(x,x, 'green')