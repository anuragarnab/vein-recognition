mhd_fractions = [0.05 : 0.05 : 1];
correct_positives = [];

threshold_test = 100000; % Not checking for threshold here. Just large enough so we can see if Nearest Neighbour is getting the correct output


for i = mhd_fractions;
    
    correct = 0;
    
    for j = 1:length(veins)

       output_id = identify (j, i, veins, threshold_test);
       [start, finish] = get_limits (j, 6);
       index = mod (j, 6);
       
       if (output_id >= start && output_id <= finish)
           correct = correct + 1;
       end

    end
    
    correct_positves = [correct_positives ; correct];

end

correct_positives