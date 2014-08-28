function [ total ] = euclid_rows(a, b)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    total = 0;
    for i = 1:size(a,1)
        total = total + norm (a(i,:) - b(i,:));
    end
end

