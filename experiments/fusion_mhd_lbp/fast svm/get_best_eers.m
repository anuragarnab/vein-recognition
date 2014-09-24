eers_all = [];

for i = 1:length(history_ulbpMhdRad)
     eers_all = [eers_all; [history_ulbpMhdRad(i).eers] ];
end

[eers_best idx] = sortrows(eers_all, 3);
eers_best(1:15,:)