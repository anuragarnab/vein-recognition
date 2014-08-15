function [ output ] = fill_candidates( candidates, samples_per_person )
%fill_candidates Fills the array, ie [7, 19] -> [7,8,9,10,11,12 , 19,20,21,22,23,24] 
%   Detailed explanation goes here
    output = [];
    
    for i = 1:length(candidates)
       output = [output , [candidates(i):1:candidates(i)+samples_per_person-1] ]; 
    end

end

