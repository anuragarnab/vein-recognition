testing = 3;
num_per_sample = 6;

train_idx = [1:1:length(veins)];
train_idx(testing:num_per_sample:length(veins)) = NaN;
train_idx = train_idx(~isnan(train_idx));

test_idx = [testing:num_per_sample:length(veins)];

train_data = populate(train_idx,[500 ; 59*32], veins);
test_data = populate(test_idx,[100 ; 59*32], veins);

% train_data = zeros(500, 59*32);
% count = 1;
% for i = train_idx
%     temp = veins(i).ulbp_hist;
%     temp = temp';
%     train_data(count,:) = temp(:)';
%     count = count + 1;
% end
% 
% test_idx = [training:num_per_sample:length(veins)];
% test_data = zeros(100, 59*32);
% count = 1;
% for i=test_idx
%     temp = veins(i).ulbp_hist;
%     temp = temp';
%     test_data(count,:) = temp(:)';
%     count = count + 1;
% end

labels = zeros(length(train_idx), 1);
for i=1:length(labels)
   labels(i) = ceil(train_idx(i)/num_per_sample); 
end

% quick_train = train_data(1:100,:);
% quick_label = labels(1:100,:);

svmmodel = svmtrain(labels,train_data,'-s 1 -t 0'); 

preds = svmpredict(double([1:1:100]'), double(test_data), svmmodel);
