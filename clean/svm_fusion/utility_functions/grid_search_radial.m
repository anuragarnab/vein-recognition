% Performs a grid search for the best parameters using the radial basis kernel
% The train/test data split is read form "data2"

history = [];
count = 1;

for logc = [-15:1:1];
    c = 2^logc;
for loggamma = [-15:1:1];
    gamma = 2^loggamma;
for w1 = 1:4:20
    
    cmd = ['-s 0 -t 2 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -q'];
    svms = train_svms(cmd, data2);
    [eer1, eer2, eer_ave] = eer_calculator(svms, data2);
    eers = [eer1, eer2, eer_ave];
    
    count = count+1;
    history(count).eers = eers;
    history(count).c = c;
    history(count).w1 = w1;
    history(count).svms = svms;
    history(count).gamma = gamma;
    fprintf('Count: %d C: %0.4f w1: %d Gamma: %0.4f EER: %0.4f \n', count, c, w1, gamma, eer_ave);
    
    save radial_test_3 history
end
end
end