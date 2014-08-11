function [ x, y ] = generate_pdf( data, bins )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    
    range = max(data) - min(data);
    y = zeros (bins, 1);
    x = [min(data) : range/bins : min(data) + range - range/bins];
    
    for i = 1:length(data)
       % find which of the bins the data point is closest to
       distance = Inf;
       best_index = 0;
       
       for j = 1: length(x)
          centre = x(j);
          if ( abs(data(i) - centre) < distance)
              distance = abs (data(i) - centre);
              best_index = j;
          end
       end
       
       y(best_index) = y(best_index) + 1;
        
    end
    
    area = get_area (x, y);
    y = y ./ area;
    normalised_area = get_area (x, y);
    fprintf ('Area was %0.3f, now it is %0.3f', area, normalised_area);

end


% Approximate the area by doing Riemann integation
% In other words, just add up the areas of multiple rectangles
function [area] = get_area (x, y)
    bin_width = x(2) - x(1);
    area = sum ( y.*bin_width);
    
    % Long, non-vectorised way of doing it
    %for i = 1 : length (y)
    %   area = area + y(i)*bin_width; % approximating as area of rectangle 
    %end
end
