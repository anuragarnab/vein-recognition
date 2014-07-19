function [ image ] = get_vein( filename )

im = imread (filename);
%% This depends on database being used. Not needed for images already
%% grayscale
%im= im2gray (im);  
%%
image = adapthisteq ( im );

smooth_filter = fspecial ('gaussian', [13 13], 2);
image = imfilter (image, smooth_filter, 'replicate');

mean_filter = fspecial ('average', 25); % Chose 50 as the window size
imMean = imfilter (image, mean_filter, 'replicate');

image = imMean - image;
thresh = graythresh (image) * 0.7;
image = im2bw (image, thresh);

end

