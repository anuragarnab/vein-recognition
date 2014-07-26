for j = 1 : length (veins_c)
   sum (sum (veins_c(j).skeleton) ) 
end

figure
scatter ( sum (sum (veins_c(3).skeleton) ), length(veins_c(3).x), 'red' );
hold on
scatter ( sum (sum (veins_c(4).skeleton) ), length(veins_c(4).x), 'blue' );
scatter ( sum (sum (veins_c(5).skeleton) ), length(veins_c(5).x), 'green' );
scatter ( sum (sum (veins_c(6).skeleton) ), length(veins_c(6).x), 'black' );
