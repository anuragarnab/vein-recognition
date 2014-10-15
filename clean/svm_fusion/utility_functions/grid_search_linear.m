% Performs a grid search for the best parameters using the linear kernel
% The train/test data split is read form "data2"

history = [];
count = 1;

for logc = [-15:0.5:5];
    c = 2^logc;
for w1 = 1:2:20
    cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
    svms = train_svms(cmd, data2);
    [eer1, eer2, eer_ave] = eer_calculator(svms, data2);
    eers = [eer1, eer2, eer_ave];
    
    count = count+1;
    history(count).eers = eers;
    history(count).c = c;
    history(count).w1 = w1;
    history(count).svms = svms;
    fprintf('%d %0.4f %d EER: %0.4f \n', count, c, w1, eer_ave);
    
    save linear_test_2 history
end
end