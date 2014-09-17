function [ eer_ave ] = loss_function( params )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    load data2;
    c = params(1);
    w1 = params(2);
    
    cmd = ['-s 0 -t 0 -b 1 -w-1 1 -w1 ', num2str(w1),' -c ', num2str(c), ' -q'];
    svms = train_svms(cmd, data2);
    [~, ~, eer_ave] = eer_fucksake(svms, data2);

end

