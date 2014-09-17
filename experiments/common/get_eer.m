function [ eer, eer_validate] = get_eer( corrects, correct_negs, outliers )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    cor = sum(corrects);
    neg = sum(correct_negs);
    
    cor_rate = cor ./ (size(corrects,1) - outliers);
    neg_rate = neg ./ size(correct_negs,1);
    
    diff = abs(cor_rate - neg_rate);
    [val, idx] = min(diff);
    
    eer = 1 - cor_rate(idx);
    eer_validate = 1 - neg_rate(idx);

end

