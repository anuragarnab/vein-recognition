function [ dp ] = dprime( a, b )
%UNTITLED7 Calculates the d'prime value

    mean_a = mean(a);
    mean_b = mean(b);
    var_a = var(a);
    var_b = var(b);
    
    dp = (sqrt(2)*abs(mean_a-mean_b))/sqrt(var_a + var_b);
    
end

