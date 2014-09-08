function [ histograms ] = grid_histogram( image, r, c, verbose, histogram_range )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    [height, width] = size(image);
    histograms = [];
    blue = [79 129 189]./255;
    
    if (nargin < 5)
       histogram_range = [0:1:58];
    end
    
    if (nargin < 4)
       verbose = 0; 
    end
    
    rows = zeros(r,2);
    cols = zeros(r,2);
    
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
          %subplot(r,c,count);
          %imshow(im);
          h = hist(im(:),histogram_range);
          
          %%Fourier test
          %h = abs(fft(h));
          %%
          
          histograms = [histograms ; h];
          %count = count+1;
          
          if (verbose)
              subplot(r,c,count);
              bar(h);
              xlabel('Uniform LBP Codeword');
              ylabel('Frequency');
              set (gca, 'YLim', [0 250]);
              set (findobj(gca,'Type','patch'), 'FaceColor', blue)
              imshow(im);
              count = count + 1;
          end
       end
    end

end

