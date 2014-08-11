data = [];
indices = [7 ; 13 ; 19 ; 8 ; 9];

for i = 1:length(indices)
    data(i).im = imread (veins(indices(i)).filename);
    data(i).finger = get_finger_shape (data(i).im );
    
    s = sum (data(i).finger);
    s = s (1:3:end);
    
    p = zeros (length(s) - 1, 1);
    for j = 1:length(p)
        p(j) = s(j) - s(j+1);
    end
    
    f = fft (p, 64);
    f = f ./ f(1);
    data(i).fourier = f;
    
end