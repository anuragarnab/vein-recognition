eers= [];

for logc = [-4:0.5:5];
    c = 2^logc;
for w1 = 1:1:20
    cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
    svms = train_svms(cmd, data);
    [eer1, eer2, eer_ave] = eer_fucksake(svms, data);
    eers = [eers ;[eer1, eer2, eer_ave]];
end
end