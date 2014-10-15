function [ eer, eer_validate] = get_eer( corrects, correct_negs, outliers )
%get_eer Compute the EER programatically
%   corrects and correct_negs are the binary matrices. 1 indicates a correct identifcation. 0 indicates a failure
%   "outliers" is the number of outliers which we compensate for. 

    cor = sum(corrects);
    neg = sum(correct_negs);
    
    cor_rate = cor ./ (size(corrects,1) - outliers);
    neg_rate = neg ./ size(correct_negs,1);
    
    diff = abs(cor_rate - neg_rate);
    [val, idx] = min(diff);
    
    eer = 1 - cor_rate(idx);
    eer_validate = 1 - neg_rate(idx);

end

