num_per_sample = 6;
num_imposters = 20;
skip_diags = 1;
testing = 3;
zero_far = 709;

[genuines, imposters] = get_score_pairs(distances_ulbp_chi, distances_mhd, num_per_sample, num_imposters, skip_diags);

train_idx = [1:1:length(veins)];
train_idx(testing:num_per_sample:length(veins)) = NaN;
train_idx = train_idx(~isnan(train_idx));

test_idx = [testing:num_per_sample:length(veins)];

imposter_indices = [];
for j = 1:length(veins)
   if (ismember(j, train_idx))
      start = (j-1)*num_imposters+1;
      fin = j*num_imposters;
      imposter_indices = [imposter_indices [start:1:fin]]; 
   end
end


imposter_data = imposters(imposter_indices,:);
imposter_data = imposter_data(imposter_data > zero_far, :);

train_data = [genuines(train_idx, :) ; imposter_data];
[train_data, mu, sigma] = zscore(train_data);

labels = ones(length(train_data), 1);
labels(length(train_idx)+1:end) = -1;

c =0.0000010; % default parameter
gamma = 500;

%fuck = svmtrain(labels,train_data,strcat({'-s 0 -t 0 -b 1 -c '}, num2str(c)  ) );
svm_model = svmtrain(labels,train_data, '-s 0 -t 2 -b 1 -c 8 -g 0.5 -w1 10 -w-1 1');
plotboundary(labels,train_data, svm_model, 't');













