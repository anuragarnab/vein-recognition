function [start finish] = get_limits (index, num_per_sample)
% Use this function when unit-testing.
% Ie, if num_per_sample is 6, index = 1, then start = 1, end = 6
% Ie, if num_per_sample is 6, index = 2, then start = 7, end = 12, and so on


    start = floor ( index / num_per_sample );
    finish = ceil ( index / num_per_sample );
    
    if (start == finish)
       start = start - 1; 
    end
    
    start = start * num_per_sample;
    finish = finish * num_per_sample;
end

