% adds Fourier Descriptors to the "veins" data array

fourier_count = 64; % the number of fourier co-efficients I am storing
step = 3; % I'm taking every 3rd column sum here, just like Kang did

for i = 1:length(veins)
    
    fprintf('\n %d', i);
    veins(i).im = imread (veins(i).filename);
    veins(i).finger = remove_edges (get_finger_shape (veins(i).im) );
    
    s = sum (veins(i).finger);
    s = s (1:3:end);
    
    p = zeros (length(s) - 1, 1);
    for j = 1:length(p)
        p(j) = s(j) - s(j+1);
    end
    
    f = fft (p, fourier_count);
    f = abs(f);
    
    if (f(1) ~= 0)
        f = abs(f) ./ abs(f(1));
    end
    veins(i).fourier = f;
    
end