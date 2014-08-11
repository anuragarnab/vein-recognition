% putting t as thresh
%t = [100, 150, 200];
figure
plot (thresh, correct_array ./ 200 * 100)
hold on
plot (thresh, correct_neg_array ./ 600 * 100, 'red')
legend ('Genuine samples correctly accepted', 'Imposter samples correctly rejected')

figure
%plot (far_record./600 .* 100 , frr_record./200 .* 100);
%xlabel ('False acceptance rate')
%ylabel ('False rejection rate');

plot (frr_record./200 .* 100, far_record./600 .* 100);
ylabel ('False acceptance rate')
xlabel ('False rejection rate');