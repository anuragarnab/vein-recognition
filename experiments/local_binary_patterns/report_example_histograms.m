colours = linspecer(2);
blue = colours(1,:);

rows = 2; cols = 2;

h1 = grid_histogram(veins(13).ulbp, rows, cols);
h2 = grid_histogram(veins(14).ulbp, rows, cols);
h3 = grid_histogram(veins(424).ulbp, rows, cols);

h1 = h1(2,:);
h2 = h2(2,:);
h3 = h3(2,:);

subplot(3,1,1);
bar(h1, 'FaceColor', blue);
xlabel('Uniform LBP Codeword (from Class 1)');
ylabel('Frequency');
set (gca, 'YScale', 'log');
goodplot();

subplot(3,1,2);
bar(h2, 'FaceColor', blue);
xlabel('Uniform LBP Codeword (from Class 1)');
ylabel('Frequency');
set (gca, 'YScale', 'log');
goodplot();

subplot(3,1,3);
bar(h3, 'FaceColor', blue);
xlabel('Uniform LBP Codeword (from Class 71)');
ylabel('Frequency');
set (gca, 'YScale', 'log');
goodplot();

distChiSquareFast(h1,h2)
distChiSquareFast(h1,h3)