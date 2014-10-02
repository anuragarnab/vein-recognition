colours = linspecer(2);

mu = (max(x1) - min(x1))/ 2;
sd = 1000;
ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve
iy = pdf('normal', ix, mu, sd);
plot(ix,iy, 'color', colours(1,:), 'LineWidth', 2);
ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve

hold on

mu = (max(x2) - min(x2))/ 2;
sd = 1200;
ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve
iy = pdf('normal', ix, mu, sd);
plot(ix,iy, 'color', colours(2,:), 'LineWidth', 2);
ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve
iy2 = pdf('normal', ix, mu, sd);

legend({'Genuine scores', 'Imposter scores'});
xlabel('Matching score');
ylabel('Probability');

goodplot;
dprime(iy, iy2)

set(gca, 'YLim', [0 4.5e-4])
