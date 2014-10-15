function [ score ] = get_score( vein1, vein2 )
%get_score gets the matching score between two veins
% This function may seem redundant. It was originally created to allow more flexibility in changing distance functions

    score = distChiSquareFast(vein1, vein2);
%     score = distEmd(vein1, vein2);
end

