image = imread ('1.jpg');
image = double (rgb2gray(image)) ;
%im = medfilt2 (image, [5 5]);
im = contrast_en (im, 30, 1200);
im = normalise (im);
imagesc (im);
colormap (gray);