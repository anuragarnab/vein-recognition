image = adapthisteq ( rgb2gray ( imread ('1.jpg') ) );

smooth_filter = fspecial ('gaussian', [17 17], 2);
im = imfilter (image, smooth_filter, 'replicate');

mean_filter = fspecial ('average', 50); % Chose 50 as the window size
imMean = imfilter (im, mean_filter, 'replicate');

figure
imagesc (im), colormap (gray);

figure
imagesc (imMean), colormap (gray);

imsub = imMean - imm;
figure
imagesc (imsub), colormap (gray);
