addpath ../common % This is where the generate_pdf function is now residing

[correct_x, correct_y] = generate_pdf (scores, 12);
% The issue is that the graph does not end on 0 on either side. So we
% enforce this manualy
epsilon = 0.0001;

x_min = min (correct_x);
x_max = max (correct_x);

correct_x = [(x_min-epsilon) correct_x (x_max+epsilon)];
correct_y = [0 ; correct_y ; 0];

figure
plot (correct_x, correct_y, 'blue');

[imposter_x, imposter_y] = generate_pdf (imposter_distances(:), 200);

hold on
plot (imposter_x, imposter_y, 'red');

title ('Relative frequency distributions of genuine and imposter Hamming distances');
xlabel ('Hamming distance');
ylabel ('Relative frequency');
legend ('Genuine', 'Imposter');


rmpath ../common