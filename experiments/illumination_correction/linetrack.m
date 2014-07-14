%
% "out" is a global variable defined in a script!
%
%


function [] = linetrack( image, delta, y, x, fromy, fromx )
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

% Recursive algorithm. For each pixel, look at 8 neighbouring pixels
% Select the darkest one and continue in that path

darkest_x = 0;
darkest_y = 0;
difference = -1000000;

ychange = [-1 -1 -1 0 0 1 1 1]';
xchange =  [0 1 -1 1 -1 0 1 -1]';

for j = 1: size(xchange)
    
    ycur = y + ychange(j);
    xcur = x + xchange(j);
    
    if (y+ychange(j) == fromy && x+xchange(j) == fromx)
       continue; 
    end
    
    pixel = image (y + ychange(j), x + xchange(j));
    diff = double(image(y, x)) - double(pixel);
    
    if (diff > difference)
       difference = diff;
       darkest_x = x + xchange(j);
       darkest_y = y + ychange(j);
    end
    
end

if (difference >= delta)
   fprintf('Moving to the next pixel (%d, %d).\n',darkest_y, darkest_x);
   out (darkest_y, darkest_x) = 1;
   linetrack (image, delta, darkest_y, darkest_x, y, x); 
end

end

