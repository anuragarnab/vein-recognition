function [ svms ] = train_svms( cmd, data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    svms = [];
    
    for i = 1:6
       svms = [svms svmtrain(data(i).labels,data(i).train, cmd)]; 
    end

end

