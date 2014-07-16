function [ best_start, best_fin ] = continuous_block( list )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

    start = 0;
    fin = 0;
    
    best_start = 0;
    best_fin = 0;
    
  %  counting = 1; % boolean expression
    
    for i = 1:max(size(list))
        
        if (list(i) == 0)
           start = fin;
           fin = i;
           
           if ( (fin - start) > (best_fin - best_start) )
              best_start = start;
              best_fin = fin;
           end   
        end
    end
    
    fin = i;
           
    if ( (fin - start) > (best_fin - best_start) )
        best_start = start;
        best_fin = fin;
    end  

end

