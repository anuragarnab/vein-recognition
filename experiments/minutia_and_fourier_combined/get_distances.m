function [ distances ] = get_distances( index, veins )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    
    distances = zeros (length(veins), 1);
    
    for i = 1:length(veins)
       distances(i) = norm (veins(index).fourier - veins(i).fourier); 
    end
    
    distances(index) = Inf; % Easier to do this than to find the second lowest value each time

end

