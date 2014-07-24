aa = fft2 (a);
a_coeff = reshape (aa, size(aa,1) * size(aa, 2), 1);
a_coeff_sort = sort (aa);
a_coeff_sort = sort (a_coeff);
a_coeff_sort = sort (a_coeff, 'descend');
a_256 = a_coeff_sort (1:256);

bb = fft2 (b);
b_coeff = reshape (bb, size(bb,1) * size(bb, 2), 1);
b_coeff_sort = sort (bb);
b_coeff_sort = sort (b_coeff);
b_coeff_sort = sort (b_coeff, 'descend');
b_256 = b_coeff_sort (1:256);

% To test nearest neighbour
sqrt ( sum ( (a_256 .* conj(a_256) - b_256 .*conj(b_256)).^2 ) )
sqrt ( sum ( (a_256 .* conj(a_256) - c_256 .*conj(c_256)).^2 ) )
