function [ correlation ] = cross_corr_normalised( a, b )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    a = double( reshape (a, 1, size(a,1) * size(a, 2) ) );
    b = double( reshape (b, 1, size(b,1) * size(b, 2) ) );
    
    correlation = max ( xcorr (double(a), double(b) ) );
    correlation = correlation / ( norm(a) * norm(b)  );

end

