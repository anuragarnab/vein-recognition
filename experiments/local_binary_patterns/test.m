load veins_lbp

num_test = 600;
correct = zeros(num_test, 1);
scores = zeros(num_test,1);

for i = 1:num_test
   [id, min_score] = get_identity(i, veins); 
   
   [start, fin] = get_limits(id, 6);
   if (id >= start && id <= fin)
       correct(i) = 1;
   end
   scores(i) = min_score;
   
   fprintf('Testing %i', i);
   save lbp_test correct scores i
end




