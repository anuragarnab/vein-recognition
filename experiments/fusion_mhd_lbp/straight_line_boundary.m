function [ accepted ] = straight_line_boundary( d1, boundary1, d2, boundary2 )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    accepted = zeros(length(d1));
    accepted = (d1 < boundary1 | d2 < boundary2);
    
end

