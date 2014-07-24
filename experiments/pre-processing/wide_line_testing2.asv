    image = imread ('images/11.bmp');
    image = rgb2gray (image);
    
    projection = sum (image, 2); % Get the vertical projection.
    total = length (projection);
    halfway = round (total / 2);
   
    [value peak1] = max ( projection(1:halfway) );
    %projection (peak1) = 0;
    projection (1:halfway) = 0;
    [value peak2] = max ( projection );
    
    centre = round( (peak1 + peak2)/2 );
    
    image = image ( centre-40:centre+40 , :);
    
    smooth_filter = fspecial ('gaussian', [7 7], 3);
    image = imfilter (image, smooth_filter);
    %image = medfilt2 (image, [7 7]);
    
    vein = huang_wide_line (image, fvr, 10, 1, 164);
    subplot (2, 1, 2);
    imshow (vein)
