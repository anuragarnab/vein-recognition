% putting t as thresh
%t = [100, 150, 200];
figure
plot (thresh, sum(correct_record) ./ 200 * 100)
hold on
plot (thresh, sum(correct_neg_record) ./ 600 * 100, 'red')
legend ('Genuine samples correctly accepted', 'Imposter samples correctly rejected')

figure
%plot (far_record./600 .* 100 , frr_record./200 .* 100);
%xlabel ('False acceptance rate')
%ylabel ('False rejection rate');

plot (sum(frr_record)./200 .* 100, sum(far_record)./600 .* 100);
ylabel ('False acceptance rate')
xlabel ('False rejection rate');
x = ones(100,1);
x = cumsum(x);
x = [0; x];
hold on;
plot(x,x,'green');