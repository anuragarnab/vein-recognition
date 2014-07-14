image = imread ('1.jpg');
image = rgb2gray (image);

image = adapthisteq(image);

smoothing_filter = fspecial ('gaussian', [7 7], 1);
image = imfilter (image, smoothing_filter, 'replicate');

out = zeros (size(image));

linetrack(image, 0, 590, 245, 590, 245);  