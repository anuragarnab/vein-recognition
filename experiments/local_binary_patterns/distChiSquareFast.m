function [ d ] = distChiSquareFast( a1, b1 )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    % This snippet handles the case that if a1(j) = b1(j) = 0
    % In this case, the bin-to-bin distance is 0/0 which causes problems
    % So by setting both of these numbers to something else, the numerator
    % becomes zero whilst the denominator does not.
    idx = find (a1 == b1);
    a1(idx) = 1; 
    b1(idx) = 1;

    d = sum( (a1-b1).^2 ./ (a1+b1), 2 );
    d = sum(d./2);
    

end

