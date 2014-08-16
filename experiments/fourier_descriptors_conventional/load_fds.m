fourier_samples = 256;

for i=1:length(veins)
    fprintf('%i \n', i);
    boundary = get_boundary (veins(i).finger);

    centre = [mean(boundary(:,1)) mean(boundary(:,2))];
    boundary = bsxfun(@minus, boundary,centre);

    boundary = [boundary(:,1) + boundary(:,2).*sqrt(-1)];

    f = fft (boundary, fourier_samples);
    f = abs(f) ./ abs(f(1));
    veins(i).fd = f;
end