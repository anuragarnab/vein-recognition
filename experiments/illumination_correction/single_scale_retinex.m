image = imread ('1.jpg');

% Reference to the paper, "Illumination Invariant Face Recognition by
% Non-local smoothing
image = double (rgb2gray (image));
gaussian_matrix = gaussian_template (3, 0.5);
illuminance = convolve (image, gaussian_matrix);

imagesc(illuminance), colormap (gray);

reflectance = image ./ illuminance;
figure
imagesc (reflectance), colormap (gray);