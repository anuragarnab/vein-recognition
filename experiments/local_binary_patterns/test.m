%load veins_lbp

num_test = 600;
correct = zeros(num_test, 1);
scores = zeros(num_test,1);
imposter_distances = [];

for i = 1:num_test
   [id, min_score, false_distances] = get_identity(i, veins); 
   
   [start, fin] = get_limits(id, 6);
   if (id >= start && id <= fin)
       correct(i) = 1;
       imposter_distances = [imposter_distances false_distances];
   end
   scores(i) = min_score;
   
   fprintf('Testing %i\n', i);
   save lbp_test correct scores i
end




