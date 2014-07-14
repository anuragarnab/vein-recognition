function [ out ] = local_threshold( image, window_size)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    
% Find mean in a window and use that as the threshold

if (nargin < 2)
   window_size = [13 13]; 
end

%get image dimensions
[irows,icols]=size(image);

%get template dimensions
wrows = window_size(1);
wcols = window_size(2);

out = image;

row = 1;

while row <= (irows-wrows)
    
    col = 1;

    while col <= (icols-wcols)
        
 %       if (row > 500)
  %         row
  %%         col
    %       irows
     %      icols
      %     wrows
       %    wcols
       % end
        window = image (row:row+wrows-1, col:col+wcols-1);
        thresh = graythresh(window ./ 255);
        
        for i = row:row+wrows-1
            for j = col:col+wcols-1
                out(i, j) = (image(i, j)/255) > thresh;
            end
        end
        
%        figure
%        imagesc (out (row:row+wrows-1, col:col+wcols-1)) , colormap (gray);
        
        col = col + wcols;
        
        %if (row > 560)
        %   row 
        %end
        %imagesc (window);
        %colormap ('gray');mean
    end
    row = row + wrows;
end

end

