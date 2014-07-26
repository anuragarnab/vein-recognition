function [ v ] = wide_line_detector( f, t, r, g )
%UNTITLED2 Summary of this function goes here
%   f is the input image
%   v is the output image
%   Using the notation of the paper, "Finger-vein authentication based on
%   Wide-Line Detector and Pattern Normalisation
%   t is the threshold, default is 1
%   r is the radius, default is 5
%   g is another threshold, default is 41

[height width] = size (f);
window_size = 5;
v = zeros ( size (f) );

if nargin < 2
   t = 1;
   r = 5;
   g = 41;
end


for row = window_size:height-window_size
    for col = window_size:width-window_size
        % Iterating over every pixel
    
        m_val = m (f, row, col, t, r);
        
       %fprintf ('Value at position [%i %i] is %i\n', col, row, m_val);
        
        if (m_val <= g)
           v(row, col) = 1; 
        end
        
    end
end


end

