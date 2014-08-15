correct = zeros (length(veins), 1);

for i = 1:length(veins)
   d = get_distances(i, veins);
   [val, idx] = min(d);
   
   [start, finish] = get_limits(i, 6);
   
   if (idx >= start && idx <= finish)
       correct(i) = 1;
   else
       fprintf('Wrong for %i\n', i);
   end
   
end

sum(correct)