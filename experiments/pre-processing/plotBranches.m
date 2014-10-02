function [] = plotBranches( vein, size )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if (nargin < 2)
       size = 10; 
    end
    
    iptsetpref('ImshowAxesVisible','on');
    
    figure
    imshow(vein.skeleton), colormap(gray);
    hold on
    scatter(vein.x, vein.y, size, 'g+');
    
    zoomStart = 0;
    zoomStop = 320;
    set (gca, 'XLim', [zoomStart zoomStop]);
    

end

