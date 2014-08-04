%num_clusters = 8;

correct_record = [];
for num_clusters = 1:1:20

clusters = [];
choices = [];

for i = 1:6:97
    clusters(ceil(i/6)).cluster = get_cluster(num_clusters, i, veins);
end

correct = 0;

for i = 1:102
   scores = zeros(length(clusters),1);
   for j = 1:length(clusters)
      scores(j) = get_score(clusters(j).cluster, [veins(i).x veins(i).y]);
   end
   [val, idx] = min (scores);
   
   if ( idx == ceil(i/6))
      correct = correct + 1; 
   end
   
   choices = [choices idx];
end

correct
correct_record = [correct_record correct];

end
