function [ ] = plotFFT( image )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    image = fftshift(image); % Center FFT

    image = abs(image); % Get the magnitude
    image = log(image+1); % Use log, for perceptual scaling, and +1 since log(0) is undefined
    image = mat2gray(image); % Use mat2gray to scale the image between 0 and 1

    imshow(image,[]); % Display the result
end

