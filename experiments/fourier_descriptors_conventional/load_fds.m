fourier_samples = 256;

for i=1:length(veins)
    fprintf('%i \n', i);
    
    veins(i).im = imread (veins(i).filename);
    veins(i).finger = remove_edges (get_finger_shape (veins(i).im) );

    boundary = get_boundary (veins(i).finger);

    centre = [mean(boundary(:,1)) mean(boundary(:,2))];
    boundary = bsxfun(@minus, boundary,centre);

    boundary = [boundary(:,1) + boundary(:,2).*sqrt(-1)];

    f = fft (boundary, fourier_samples);
    %f = abs(f) ./ abs(f(1));
    f = abs(f);
    veins(i).fd = f;
end

for i=1:length(veins_unreg)
    fprintf('%i \n', i);
    veins_unreg(i).im = imread (veins_unreg(i).filename);
    veins_unreg(i).finger = remove_edges (get_finger_shape (veins_unreg(i).im) );

    boundary = get_boundary (veins_unreg(i).finger);

    centre = [mean(boundary(:,1)) mean(boundary(:,2))];
    boundary = bsxfun(@minus, boundary,centre);

    boundary = [boundary(:,1) + boundary(:,2).*sqrt(-1)];

    f = fft (boundary, fourier_samples);
    %f = abs(f) ./ abs(f(1));
    f = abs(f);
    veins_unreg(i).fd = f;
end