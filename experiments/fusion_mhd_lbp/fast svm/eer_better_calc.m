eer_all = [];
for i=2:length(history_poly)
[e1, e2 ,temp] = eer_fucksake(history_poly(i).svms, data2);
eer_all = [eer_all ; [e1, e2, temp]];
end
[vals, idx] = sortrows(eer_all, 3);

eer_all(idx(1:15),:)