function [start finish] = get_limits (index, num_per_sample)
% Use this function when unit-testing.

    start = floor ( index / num_per_sample );
    finish = ceil ( index / num_per_sample );
    
    if (start == finish)
       start = start - 1; 
    end
    
    start = start * num_per_sample;
    finish = finish * num_per_sample;
end

