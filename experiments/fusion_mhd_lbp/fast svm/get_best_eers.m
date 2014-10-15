eers_all = [];

for i = 1:length(history)
     eers_all = [eers_all; [history(i).eers] ];
end

[eers_best idx] = sortrows(eers_all, 3);
eers_best(1:15,:)