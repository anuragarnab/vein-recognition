% First svm test, so probably not the best but anyway
% So what this does is pick the top 5 mhd indexes, and then from there, it
% gets the lbp distances. Then it puts it in the svm 

num_test = 600;
test_indices = 15; 
samples_per_person = 6;

correct = zeros(length(num_test), 1);

for i = 1:num_test
   dis = distances_mhd(:,i); % get distances for this samples
   [dis, idx] = sort(dis, 'ascend');
   
   testing = idx(2:2+test_indices); % Leave out 1 since the distance for that is trivially 0
   
%    for t = testing
%       out = svmclassify(svmStruct, [distances_mhd(t,i) , distances_ulbp_emd(t,i)]);
%       accepted = idx(out);
%       if (out == 1)
%          fprintf('Testing %i, accepted %i\n', i, t); 
%       end
%    end

    out = svmclassify(svmStruct_chi, [distances_mhd(testing,i), distances_ulbp_chi(testing,i)]);
    accepted = testing (logical(out));
    ids = ceil (accepted ./ samples_per_person);
    identified = mode (ids);
    
    should_be = ceil (i/samples_per_person);
    if (identified == should_be)
       correct(i) = 1; 
    else
        i
        ids
    end
    
   % fprintf('Testing %i: ', i);
   % fprintf('Identified %i ', identified);
   % fprintf('\n');
    
end

sum(correct)
