counts = zeros(length(clus1),1);

for i = 1:length(clus1)
   a = sum(~isnan(clus1(i).cluster)); 
   counts(i) = a(1);
end