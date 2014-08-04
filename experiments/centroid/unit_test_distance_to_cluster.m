number_of_clusters = 10;
epsilon = 0.1;

training = [7, 9, 10, 12];
training_data = [];

for i = training
    training_data = [training_data ; [veins(i).x veins(i).y] ];
end

[index, cluster, ~, D] = kmeans(training_data, number_of_clusters);
counter = 1;
pass = 1;

for j = training
   for k = 1:length(veins(j).x)
       point = [veins(j).x(k) veins(j).y(k)];
       test_d = distance_to_cluster(cluster, point);
       if ( abs(test_d^2 - min (D(counter,:))) > epsilon )
          fprintf ('Wrong. Calculated squared distance as %0.3f, actually %0.3f\n', test_d^2, min(D(counter,:) ) );  
          pass = 0;
       end
       counter = counter + 1;
   end
end

if (pass)
   fprintf('All correct. Test passed'); 
end