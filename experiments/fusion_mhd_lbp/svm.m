pos = [genuine_mhd genuine_lbp_chi'];
neg = [imposter_mhd(:) imposter_lbp_chi(:)];
training = [pos ; neg];

targets = ones( length(pos), 1);
targets = [targets ; zeros(length(neg),1)];

svmStruct_chi = svmtrain( training, targets, 'showplot', 'true', 'kernel_function', 'rbf'); 