function [ distance ] = hamming_distance( a, b )
%UNTITLED11 Summary of this function goes here
%   Assumes "a" and "b" are matrices of uint8's

    distance = bitcount ( bitxor (a(:), b(:) ));

end

