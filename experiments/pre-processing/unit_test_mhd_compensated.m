correct_distances = [];
imposter_distances = [];
outlier_count = 0; % I am going to count errors on images 4, 5 and 6 after the 40th hand as an outlier

for j = 1:length(veins)
   [id, distance, distances] = test_identity ( j , 0.8, veins);
   distances = sort (distances, 'ascend');
     
 %  if ( mod(j,2) == 0)
 %      answer = j-1;
 %  else
 %      answer = j+1;    
 %  end
 
    [start finish] = get_limits (j, 6);
   
   if (id < start || id > finish)
       fprintf ('Incorrect for %i. Detected as %i, actually the six starting from %i. Distance was %0.3f\n', j, id, start+1, distance); 
       imposter_distances = [imposter_distances ; distances(7:end)]; % just being safe and taking 7 till the end. Since some could actually be from the actual hand
       
       index = mod (j, 6);
       
       if ( (index == 0 || index == 4 || index == 5) && j > 240)
           outlier_count = outlier_count + 1;
       end
       
   else
       correct_distances = [correct_distances ; distances(2)]; %since first one in sorted order is 0
       imposter_distances = [imposter_distances ; distances(7:end)];
   end
end

