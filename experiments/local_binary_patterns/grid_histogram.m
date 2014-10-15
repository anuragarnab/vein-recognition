function [ histograms ] = grid_histogram( image, r, c, verbose, histogram_range )
%grid_histogram "image" is an image of ULBP features
%   Subdivides an image into smaller grids
%   Histograms of Uniform LBP features are then computed and then concatenated together
%   This was described in Chapter 6

% The "verbose" option plots the histogram that were computed
% The histogram range is 0-58 by default (range of 8 bit uniform local binary patterns)

    [height, width] = size(image);
    histograms = [];
    
    colours = linspecer(2);
    blue = colours(1,:);
    
    if (nargin < 5)
       histogram_range = [0:1:58];
    end
    
    if (nargin < 4)
       verbose = 0; 
    end
    
    rows = zeros(r,2);
    cols = zeros(c,2);
    
    for i = 1:r
        rows(i,1) = floor(height*(i-1)/r)+1;
        rows(i,2) = floor(height*i/r);
    end
    
    for i = 1:c
       cols(i,1) = floor(width*(i-1)/c)+1;
       cols(i,2) = floor(width*i/c);
    end
    
    count = 1;
    
    for ir = 1:size(rows,1)
       for ic = 1:size(cols,1)
          im = image(rows(ir,1):rows(ir,2) , cols(ic,1):cols(ic,2) );
          h = hist(im(:),histogram_range);
                   
          histograms = [histograms ; h];
          
          if (verbose)
              subplot(r,c,count);
              bar(h);
              xlabel('Uniform LBP Codeword');
              ylabel('Frequency');
              set (gca, 'YScale', 'log');
              set (findobj(gca,'Type','patch'), 'FaceColor', blue);
              goodplot();
              count = count + 1;
          end
       end
    end

end

