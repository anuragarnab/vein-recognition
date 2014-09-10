function [  ] = plot_pdf( a, b, binsA, binsB, ptitle, pxlabel, pylabel, plegend )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    if (nargin < 5)
        ptitle = '';
    end
    
    if (nargin < 6)
        pxlabel = '';
    end
    
    if (nargin < 6)
        pylabel = '';
    end
    
    if (nargin < 7)
       plegend = ''; 
    end
    
    [numA, centersA] = hist(a, binsA);
    [numB, centersB] = hist(b, binsB);
    
    areaA = get_area (centersA, numA);
    areaB = get_area (centersB, numB);
    
    numA = numA./areaA;
    numB = numB./areaB;
    
    crimson = [0.6, 0, 0];
    nice_blue = [51/255, 153/255, 1];
    
    figure
    bar (centersA, numA, 'red');
    hold on
    bar (centersB, numB, 'blue');
    
    centersA = [min(centersA)-eps centersA max(centersA)+eps];
    numA = [0 numA 0];
    
    plot (centersA, numA, 'color', crimson, 'linewidth', 2);
    hold on
    plot (centersB, numB, 'color', nice_blue, 'linewidth', 2);
    
    goodplot();
    
    xlabel(pxlabel);
    ylabel(pylabel);
    title(ptitle);
    legend(plegend, 'Location', 'SouthEast');
    
    disp('Remember to label the graph!');

end

function [area] = get_area (x, y)
    bin_width = x(2) - x(1);
    area = sum ( y.*bin_width);
    
    % Long, non-vectorised way of doing it
    %for i = 1 : length (y)
    %   area = area + y(i)*bin_width; % approximating as area of rectangle 
    %end
end