function [f1, f2, f3, f4, f5] = plotboundary(labels, features, model, xthresh, ythresh)

% PLOTBOUNDARY    Plot the SVM classification boundary in Exercise 8
%
%   plotboundary(labels, features, model, fill_on) plots the training data
%   and decision boundary, given a model produced by LIBSVM
%    
%   The parameter 'fill_on' is a boolean that indicates whether a filled-in
%   contour map should be produced.

% Modified function to return f1,f2,f3 and f4 which are handles to the
% plots. Need this to add a legend to the plot

figure; hold on
contrasting_colour = [204 51 153]./255;

% Make classification predictions over a grid of values
xplot = linspace(min(features(:,1))*1.02, max(features(:,1)), 200)*1.02';
yplot = linspace(min(features(:,2))*1.02, max(features(:,2)), 200)*1.02';
[X, Y] = meshgrid(xplot, yplot);
vals = zeros(size(X));
for i = 1:size(X, 2)
   x = [X(:,i),Y(:,i)];
   % Need to use evalc here to suppress LIBSVM accuracy printouts
   [T,predicted_labels, accuracy, decision_values] = ...
       evalc('svmpredict(ones(size(x(:,1))), x, model)');
   clear T;
   vals(:,i) = decision_values;
end

% Plot the individual classifier boundaries
f5 = plot( min(features(:,1))*1.02:0.001:max(features(:,1))*1.02, xthresh, 'color', contrasting_colour, 'LineWidth', 2);
hold on
plot( ythresh, [min(features(:,2))*1.02:0.001:max(features(:,2))*1.02], 'linewidth', 8, 'color', contrasting_colour);

% Plot the SVM boundary
colormap bone
[~, f1] = contourf(X,Y, vals, 50, 'LineStyle', 'none');
[~, f2] = contour(X,Y, vals, [0 0], 'LineWidth', 2, 'Color', 'k');

% Plot the training data on top of the boundary
pos = find(labels == 1);
neg = find(labels == -1);
f3 = plot(features(pos,1), features(pos,2), 'ko', 'MarkerFaceColor', 'r'); hold on;
f4 = plot(features(neg,1), features(neg,2), 'ko', 'MarkerFaceColor', 'g');
