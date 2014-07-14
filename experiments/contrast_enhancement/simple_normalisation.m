image = imread ('1.jpg');
im = double ( rgb2gray (image) );
imn = normalise (im);

imagesc (imn);
colormap (gray);

