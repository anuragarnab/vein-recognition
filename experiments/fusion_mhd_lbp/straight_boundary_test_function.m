function [ corrects, correct_negs ] = straight_boundary_test_function( d1, i1, t1, d2, i2, t2, num_neighbours, num_test, samples_per_person )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

if nargin < 7
   num_neighbours = 5; 
end

if nargin < 8
   num_test = 600; 
end

if nargin < 9
   samples_per_person = 6; 
end

correct = zeros(length(num_test), 1);
correct_neg = zeros(length(num_test), 1);

for i = 1:num_test
   dis = d1(:,i); % get distances for this samples
   [dis, idx] = sort(dis, 'ascend');
   
   testing = idx(2:2+num_neighbours-1); % Leave out 1 since the distance for that is trivially 0
   
   out = straight_line_boundary( d1(testing,i), t1, d2(testing,i), t2 ); 
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
   end
end


for i = 1:num_test
   dis = i1(i,:); % get distances for this samples
   [dis, idx] = sort(dis, 'ascend');
   
   testing = idx(2:2+num_neighbours-1); % Leave out 1 since the distance for that is trivially 0
   
   out = straight_line_boundary( i1(i,testing), t1, i2(i,testing), t2 ); 
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
   end   
end


corrects = sum(correct);
correct_negs = sum(correct_neg);
end

