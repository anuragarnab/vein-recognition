eer_refined = [];
for i=2:length(history_poly)
[~,~,temp] = eer_fucksake(history_poly(i).svms, data2);
eer_refined = [eer_refined ; temp];
end
[vals, idx] = sort(eer_refined, 'ascend');
