% colours = linspecer(2);
% 
% %mu = (max(x1) - min(x1))/ 2;
% mu = 3000;
% sd = 1000;
% ix = -6*sd+mu:1e-3:6*sd+mu; %covers more than 99% of the curve
% iy = pdf('normal', ix, mu, sd);
% plot(ix,iy, 'color', colours(1,:), 'LineWidth', 2);
% ix = -6*sd+mu:1e-3:6*sd+mu; %covers more than 99% of the curve
% 
% hold on
% 
% %mu = (max(x2) - min(x2))/ 2;
% mu = 7000;
% sd = 1200;
% ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve
% iy = pdf('normal', ix, mu, sd);
% plot(ix,iy, 'color', colours(2,:), 'LineWidth', 2);
% ix = -3*sd+mu:1e-3:3*sd+mu; %covers more than 99% of the curve
% iy2 = pdf('normal', ix, mu, sd);
% 
% legend({'Genuine scores', 'Imposter scores'});
% xlabel('Matching score');
% ylabel('Probability');
% 
% goodplot;
% dprime(iy, iy2)
% 
% set(gca, 'YLim', [0 4.5e-4])

crimson = [0.6, 0, 0];
nice_blue = [51/255, 153/255, 1];
samples = 50;

mu = 3000;
sd = 1000;
ix = -6*sd+mu:1e-3:6*sd+mu; %covers more than 99% of the curve
iy = pdf('normal', ix, mu, sd);

centreIndices = [1 : int32(length(ix)/samples) : length(ix)]; 
binIndices = [1 : int32(length(iy)/samples) : length(iy)]; 
centreA = ix(centreIndices);
binA = iy(binIndices);


mu2 = 7000;
sd2 = 1200;
ix2 = -6*sd2+mu2:1e-3:6*sd2+mu2; %covers more than 99% of the curve
iy2 = pdf('normal', ix2, mu2, sd2);

%plot_pdf(iy, iy2, 200, 200, '', 'Matching score', 'Frequency', {'Genuine scores', 'Imposter scores'});
centreB = [min(ix2) : length(ix2)/samples : max(ix2)]; 
binB = [min(iy2) : length(iy2)/samples : max(iy2)]; 

centreIndices = [1 : int32(length(ix2)/samples) : length(ix2)]; 
binIndices = [1 : int32(length(iy2)/samples) : length(iy2)]; 
centreB = ix2(centreIndices);
binB = iy2(binIndices);

figure
bar (centreA, binA, 'hist');
hold on
bar (centreB, binB, 'blue', 'hist');
    
ix = [min(ix)-eps ix max(ix)+eps];
iy = [0 iy 0];
ix2 = [min(ix2)-eps ix2 max(ix2)+eps];
iy2 = [0 iy2 0];
    
plot (ix, iy, 'color', crimson, 'linewidth', 2);
hold on
plot (ix2, iy2, 'color', nice_blue, 'linewidth', 2);
    
goodplot();
    
xlabel('Matching score');
ylabel('Frequency');
legend({'Genuine scores', 'Imposter scores'}, 'Location', 'SouthEast');