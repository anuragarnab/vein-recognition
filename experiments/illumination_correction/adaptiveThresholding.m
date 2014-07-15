image = adapthisteq ( rgb2gray ( imread ('Capture.PNG') ) );
%image = adapthisteq ( rgb2gray ( imread ('1.jpg') ) );
%image = adapthisteq (  imread ('06.jpg') );
%image = imread ('06.jpg');

smooth_filter = fspecial ('gaussian', [13 13], 2);
im = imfilter (image, smooth_filter, 'replicate');
%im = image;
%im = medfilt2 (im, [3 3]);

mean_filter = fspecial ('average', 25); % Chose 50 as the window size

imMean = imfilter (im, mean_filter, 'replicate');

figure
imagesc (im), colormap (gray);

figure
imagesc (imMean), colormap (gray);

imsub = imMean - im;
figure
imagesc (imsub), colormap (gray);

thresh = graythresh (imsub) * 0.7;
%thresh = 0.003;
imfin = im2bw (imsub, thresh);
figure
imagesc (imfin), colormap (gray);

%im_edge = edge (im, 'canny');
%figure
%imagesc (im_edge), colormap (gray);