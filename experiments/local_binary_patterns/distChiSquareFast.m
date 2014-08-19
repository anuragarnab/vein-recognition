function [ d ] = distChiSquareFast( a1, b1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    d = sum( (a1-b1).^2 ./ (a1+b1) );
    d = d/2;

end

