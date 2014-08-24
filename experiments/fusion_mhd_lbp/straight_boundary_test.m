num_test = 600;
test_indices = 5; 
samples_per_person = 6;

mhd_thresh = 5; % We know this is good
lbp_thresh = 1000;

correct = zeros(length(num_test), 1);
correct_neg = zeros(length(num_test), 1);

for i = 1:num_test
   dis = distances_ulbp_chi(:,i); % get distances for this samples
   [dis, idx] = sort(dis, 'ascend');
   
   testing = idx(2:2+test_indices-1); % Leave out 1 since the distance for that is trivially 0
   
   out = straight_line_boundary( distances_mhd(testing,i), mhd_thresh, distances_ulbp_chi(testing,i), lbp_thresh ); 
   accepted = testing (logical(out));
   ids = ceil (accepted ./ samples_per_person);
   %identified = mode (ids);
   if (~isempty(ids))
    identified = ids(1);
   else
    identified = -1;
   end
   
   should_be = ceil (i/samples_per_person);
   if (identified == should_be)
      correct(i) = 1; 
   else
      i
      ids
      identified
   end
    
   % fprintf('Testing %i: ', i);
   % fprintf('Identified %i ', identified);
   % fprintf('\n');
    
end


for i = 1:num_test
   dis = imp_distances_ulbp_chi(i,:); % get distances for this samples
   [dis, idx] = sort(dis, 'ascend');
   
   testing = idx(2:2+test_indices-1); % Leave out 1 since the distance for that is trivially 0
   
   out = straight_line_boundary( imp_distances_mhd(i,testing), mhd_thresh, imp_distances_ulbp_chi(i,testing), lbp_thresh ); 
   accepted = testing (logical(out));
   ids = ceil (accepted ./ samples_per_person);
   %identified = mode (ids);
   if (~isempty(ids))
    identified = ids(1);
   else
    identified = -1;
   end
   
   should_be = -1;
   if (identified == should_be)
      correct_neg(i) = 1; 
   else
      i
      ids
      identified
   end
    
   % fprintf('Testing %i: ', i);
   % fprintf('Identified %i ', identified);
   % fprintf('\n');
    
end


sum(correct)
sum(correct_neg)