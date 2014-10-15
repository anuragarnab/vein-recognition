function svmtoy(label_matrix, instance_matrix, options, contour_level)
%% svmtoy(label_matrix, instance_matrix, options, contour_level)
%% label_matrix: N by 1, has to be two-class
%% instance_matrix: N by 2
%% options: default '',
%%          see libsvm-mat-8 README, has to be a classification formulation.
%% contour_level: default [0 0], 
%%                change to [-1 0 1] for showing the +/- 1 margin.
%%
%% svmtoy shows the two-class classification boundary of the 2-D data
%% based on libsvm-mat-2.8
%%
%% Hsuan-Tien Lin, htlin at caltech.edu, 2006/04/07

if nargin <= 1
  instance_matrix = [];
elseif nargin == 2    
  options = ''
end

if nargin <= 3
  contour_level = [0 0];
end

N = size(label_matrix, 1);
if N <= 0
  fprintf(2, 'number of data should be positive\n');
  return;
end

if size(label_matrix, 2) ~= 1
  fprintf(2, 'the label matrix should have only one column\n');
  return;
end

if size(instance_matrix, 1) ~= N
  fprintf(2, ['the label and instance matrices should have the same ' ...
              'number of rows\n']);
  return;
end

if size(instance_matrix, 2) ~= 2
  fprintf(2, 'svmtoy only works for 2-D data\n');
  return;
end

mdl = svmtrain(label_matrix, instance_matrix, options);

nclass = mdl.nr_class;
svmtype = mdl.Parameters(1);

if nclass ~= 2 || svmtype >= 2
  fprintf(2, ['cannot plot the decision boundary for these ' ...
              'SVM problems\n']);
  return
end

minX = min(instance_matrix(:, 1));
maxX = max(instance_matrix(:, 1));
minY = min(instance_matrix(:, 2));
maxY = max(instance_matrix(:, 2));

gridX = (maxX - minX) ./ 100;
gridY = (maxY - minY) ./ 100;

minX = minX - 10 * gridX;
maxX = maxX + 10 * gridX;
minY = minY - 10 * gridY;
maxY = maxY + 10 * gridY;

[bigX, bigY] = meshgrid(minX:gridX:maxX, minY:gridY:maxY);

mdl.Parameters(1) = 3; % the trick to get the decision values
ntest=size(bigX, 1) * size(bigX, 2);
instance_test=[reshape(bigX, ntest, 1), reshape(bigY, ntest, 1)];
label_test = zeros(size(instance_test, 1), 1);

[Z, acc] = svmpredict(label_test, instance_test, mdl);

bigZ = reshape(Z, size(bigX, 1), size(bigX, 2));

clf;
hold on;

ispos = (label_matrix == label_matrix(1));
pos = find(ispos);
neg = find(~ispos);

plot(instance_matrix(pos, 1), instance_matrix(pos, 2), 'o');
plot(instance_matrix(neg, 1), instance_matrix(neg, 2), 'x');

contour(bigX, bigY, bigZ, contour_level);

title(options);

