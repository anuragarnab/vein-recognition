function [ image ] = get_vein( filename )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

im = imread (filename);
image = adapthisteq ( im );
%image = adapthisteq ( rgb2gray ( imread ('1.jpg') ) );
%image = adapthisteq (  imread ('06.jpg') );
%image = imread ('06.jpg');

smooth_filter = fspecial ('gaussian', [13 13], 2);
image = imfilter (image, smooth_filter, 'replicate');
%im = image;
%im = medfilt2 (im, [3 3]);

mean_filter = fspecial ('average', 25); % Chose 50 as the window size

imMean = imfilter (image, mean_filter, 'replicate');

image = imMean - image;
thresh = graythresh (image) * 0.7;
image = im2bw (image, thresh);


%% 
%Now we automatically crop the image to only get the vein portion
%To do this, we threshold the original image and use that as a mask
%From the image, we can see that the finger is lighter than the dark
%background
% So by thresholding this image with Otsu, we should get the just the
% finger coming out
% We then use the projection of the finger onto the horizontal axis to work
% out the bounds of the image
% 
% It would have been nice to element wise multiply the two images, but this
% is not quite possible since the dark vein parts of the original image
% become black when thresholded
%%

threshold = graythresh (im);
projection = sum ( im2bw (im, threshold) );
[start, fin] = continuous_block(projection);
image = image (:,  start:fin);

struct_element = strel ('rectangle', [5 5]);
image = imopen (image, struct_element); % do morphological opening


end

