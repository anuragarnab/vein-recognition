% loads fft features, then computes the distance matrix as well

for i = 1:length(veins)
   temp = fft(veins(i).ulbp_hist'); 
   veins(i).fourier = abs(temp');
   
   temp = fft(veins_unreg(i).ulbp_hist');
   veins_unreg(i).fourier = abs(temp');
end

distances_fourier = zeros(length(veins));
imp_distances_fourier = zeros(length(veins));

for rows = 1:length(veins)
    for cols = 1:length(veins)
        distances_fourier(rows,cols) = euclid_rows(veins(rows).fourier, veins(cols).fourier);
        imp_distances_fourier(rows,cols) = euclid_rows(veins(rows).fourier, veins_unreg(cols).fourier);
    end
    fprintf('%d \n', rows);
end

save ( strcat('Fourier ',datestr(now, 'mmm-dd-HH-MM')), 'distances_fourier', 'imp_distances_fourier', 'veins', 'veins_unreg');