pos = [genuine_mhd genuine_lbp_emd'];
neg = [imposter_mhd(:) imposter_lbp_emd(:)];
training = [pos ; neg];

targets = ones( length(pos), 1);
targets = [targets ; zeros(length(neg),1)];

svmStruct = svmtrain( training, targets, 'showplot', 'true', 'kernel_function', 'rbf'); 