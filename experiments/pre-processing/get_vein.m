function [ image ] = get_vein( image )

%im = imread (filename);
%% This depends on database being used. Not needed for images already
%% grayscale
%im = rgb2gray (im);  
%%

%image = adapthisteq ( im );

smooth_filter = fspecial ('gaussian', [7 7], 2);
image = imfilter (image, smooth_filter, 'replicate');

mean_filter = fspecial ('average', 17); % Chose 50 as the window size
imMean = imfilter (image, mean_filter, 'replicate');

image = imMean - image;
thresh = graythresh (image) * 0.7;
image = im2bw (image, thresh);

end

