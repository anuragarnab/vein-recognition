distances = [];

count = 1;
for mhd_frac = 0.7
    [d,i] = distance_matrix(veins, veins_unreg, mhd_frac);
    
    distances(count).gen_distance = d;
    distances(count).imp_distance = i;
    distances(count).mhd_frac = mhd_frac;
    count = count+1;
    save data distances
end