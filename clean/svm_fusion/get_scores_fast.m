function [ corrects_scores, correct_negs_scores ] = get_scores_fast( svms, data )
%get_scores_fast Calculates the distances from the hyperplane of the data
%clsasified by the SVM.
% Note, this function assumes that the first 100 samples being tested were
% from genuine samples and last 100 from imposters. This fitted the neeeds
% of our project. 
    
    corrects_scores = [];
    correct_negs_scores = [];

    for testing = 1:1:6
       [~, ~, scores] = svmpredict(data(testing).expected, data(testing).test_data, svms(testing), '-q');
       corrects_scores = [corrects_scores scores(1:100)];
       correct_negs_scores = [correct_negs_scores scores(101:end)];
    end

end

