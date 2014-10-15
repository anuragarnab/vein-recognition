function [ total ] = euclid_rows(a, b)
%euclid_rows Computes Euclidean distances between rows of matrices a and b
    total = 0;
    for i = 1:size(a,1)
        total = total + norm (a(i,:) - b(i,:));
    end
end

