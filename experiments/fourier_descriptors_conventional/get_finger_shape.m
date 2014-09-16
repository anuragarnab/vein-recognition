function [ finger ] = get_finger_shape( image, mask_width, mask_height, verbose )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

    if (nargin < 4)
       verbose = 0; 
    end

    thresh = 10; % For detecting edges
    k = 20; % Need k for the "find" function
    
    left_fudge = 0;
    right_fudge = 0;
    
    image = rgb2gray(image);
    
    if (verbose)
        figure
        subplot (3,1,1); imshow(image);
    end
        
    if (nargin < 2)
        % These are values which Bram Ton used and which I found to work as
        % well on the first person (and hopefully all people)
        mask_width = 20;
        mask_height = 4;
    end
    
    [finger, ~] = lee_region ( im2double(image) , mask_height, mask_width);
    
    if (verbose)
        subplot (3,1,2); imshow (finger);
    end
    
    % We need to get rid of the scanner bars at either end of the picture
    
    col_sums = sum (finger);
    derivative = zeros ( length(col_sums) - 1, 1);
    
    for i = 1:length(col_sums)-1
       derivative(i) = col_sums(i+1) - col_sums(i); 
    end
    
    halfway = round(length(derivative)/2);
   % [~, left_edge] = max ( abs(derivative( halfway:-1:1) ) ) % I want to find the maximum from the right, that is why I'm flipping the array from the centre point
   % [~, right_edge] = max ( abs( derivative( halfway:end) ) )
    
   % left_edge = halfway - left_edge + 1 + 1
   % right_edge = right_edge + halfway
   
    left_edge = find ( abs(derivative(1:halfway)) > thresh, k, 'last' ) + left_fudge;
    right_edge = find ( abs(derivative(halfway:end)) > thresh, k, 'first' ) + halfway - right_fudge;
    
    if isempty(left_edge)
       left_edge = 1;
       fprintf ('Left edge was empty');
    end
    
    if isempty(right_edge)
       right_edge = size(image, 2); 
       fprintf ('Right edge was empty');
    end
    
    left_edge = max(left_edge);
    right_edge = min (right_edge);
    
    finger = finger (:, left_edge:right_edge);
    
    if (verbose)
        subplot (3,1,3); imshow(finger);
        figure
        plot (derivative)
    end
end

