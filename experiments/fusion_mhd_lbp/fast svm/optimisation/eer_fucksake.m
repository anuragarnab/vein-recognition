function [ eer, eerv, eer_mean ] = eer_fucksake( svms, data, num_outliers, wrong_uns, steps, begin, fin )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    
    if(nargin < 3)
        num_outliers = 7;
    end
    
    if (nargin < 4)
        wrong_uns = [595;443;132;528;588;216;418;558];
    end
    
    if (nargin < 5)
        steps = 1000;
        begin = -10;
        fin = 10;
    end
    
    increment = (fin - begin)/steps;

    [corrects_scores, correct_negs_scores] = get_scores_fast (svms, data);
    
%     threshes =  [begin:increment:fin];

    
    threshes =  [-10:0.1:-1];
    threshes = [threshes -0.99:0.001:0.99];
    threshes = [threshes 1:0.1:10];
    corrects = [];
    correct_negs = [];

    for threshold = threshes

        temp = corrects_scores >= threshold;
        temp = temp';
        temp = temp(:);
        temp(wrong_uns) = 0; % Important. ULBP_chi will sometimes always pick the wrong one (notes in my MEC4063 book) 
        
%         temp = double(temp);
%         temp(6:6:600) = NaN; 
%         temp = temp(~isnan(temp));
        
        corrects = [corrects temp];

        temp = correct_negs_scores < threshold;
        temp = temp';
        temp = temp(:);
        correct_negs = [correct_negs temp];
        
    end

%plot_roc(corrects, correct_negs, threshes, num_outliers);
    [eer, eerv] = get_eer(corrects, correct_negs, num_outliers);
    eer_mean = mean([eer eerv]);

end

