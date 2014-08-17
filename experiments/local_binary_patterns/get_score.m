function [ score ] = get_score( vein1, vein2 )
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    
    score = 0;

    for row = 1:size(vein1, 1)
        for col=1:size(vein1, 2)
            score = score + disthamming(vein1(row,col), vein2(row,col));
        end
    end

    score = double(score) / (size(vein1, 1) * size(vein1, 2));
end

