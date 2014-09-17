function [ corrects_scores, correct_negs_scores ] = get_scores_fast( svms, data )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    
    corrects_scores = [];
    correct_negs_scores = [];

    for testing = 1:1:6
       [~, ~, scores] = svmpredict(data(testing).expected, data(testing).test_data, svms(testing), '-q');
       corrects_scores = [corrects_scores scores(1:100)];
       correct_negs_scores = [correct_negs_scores scores(101:end)];
    end

end

