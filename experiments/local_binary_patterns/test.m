%load veins_lbp

num_test = 600;
correct = zeros(num_test, 1);
scores = zeros(num_test,1);
imposter_distances = [];

for i = 1:num_test
   
    if (i == 595)
       disp('w'); 
    end
    
   [id, min_score] = get_identity(veins(i), veins, i); 
   
   [start, fin] = get_limits(i, 6);
   if (id >= start && id <= fin)
       correct(i) = 1;
       %imposter_distances = [imposter_distances false_distances];
   end
   scores(i) = min_score;
   
   fprintf('Testing %i\n', i);
   save lbp_test correct scores i
end




