% Anurag Arnab - ARNANU002
% SVM demo
% Tests the combination of MHD and Canonical LBP classifiers, as shown in
% Chapter 8 of the report. 

% To change the classifiers being combined, edit "svm_training"

addpath ../common

clear
load ../experimental_data/score_matrices/mhd_scores 
load ../experimental_data/score_matrices/canonical_lbp_scores
load ../experimental_data/training_database

disp ('Train and test SVM using 6-fold MCV and LibSVM for the implementation of the SVM');
svm_training

disp ('Plot decision boundary');
plot_boundary

disp ('Plot ROC curve');
svm_roc