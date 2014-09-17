history = [];
count = 1;
coeff0 = 0; % default

for logc = [-15:1:1];
    c = 2^logc;
for loggamma = [-15:1:3];
    gamma = 2^loggamma;
for w1 = 1:3:20
for degree = 1:1:4
    
    cmd = ['-s 0 -t 1 -b 1 -w-1 1 -w1 ', num2str(w1), ' -g ', num2str(gamma), ' -c ', num2str(c), ' -d ', num2str(degree), ' -r ', num2str(coeff0),' -q'];
    svms = train_svms(cmd, data2);
    [eer1, eer2, eer_ave] = eer_fucksake(svms, data2);
    eers = [eer1, eer2, eer_ave];
    
    count = count+1;
    history(count).eers = eers;
    history(count).c = c;
    history(count).w1 = w1;
    history(count).svms = svms;
    fprintf('%d %0.4f %d %0.4f EER: %0.4f \n', count, c, w1, gamma, eer_ave);
    
    save poly_test_2 history
end
end
end
end