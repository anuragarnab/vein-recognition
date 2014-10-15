function [ eer, eerv, eer_mean ] = eer_calculator( svms, data, num_outliers, steps, begin, fin )
%UNTITLED2 Calculates the EER of the SVM for a particular set of data
% In effect, it performs the calculations needed to plot the ROC curve,
% except that the ROC itself is not plotted. Hence, this code is very
% similar to svm_roc
    
    if(nargin < 3)
        num_outliers = 7;
    end
    
    if (nargin < 4)
        steps = 1000;
        begin = -10;
        fin = 10;
    end
    
    increment = (fin - begin)/steps;

    [corrects_scores, correct_negs_scores] = get_scores_fast (svms, data);
       
    threshes =  [-10:0.1:-1];
    threshes = [threshes -0.99:0.001:0.99];
    threshes = [threshes 1:0.1:10];
    corrects = [];
    correct_negs = [];

    for threshold = threshes

        temp = corrects_scores >= threshold;
        temp = temp';
        temp = temp(:);
               
        corrects = [corrects temp];

        temp = correct_negs_scores < threshold;
        temp = temp';
        temp = temp(:);
        correct_negs = [correct_negs temp];
        
    end

    [eer, eerv] = get_eer(corrects, correct_negs, num_outliers);
    eer_mean = mean([eer eerv]);

end

